# Validate author records and supply derived lists/search text without parallel data.
require 'date'
module CommunityRecords
  def self.upcoming?(data, today)
    return false if data['date_review']
    Date.iso8601(data['end_date'] || data.fetch('start_date')) >= today
  end

  def self.validate_date!(value, context)
    raise ArgumentError, "#{context}: expected YYYY-MM-DD" unless value.is_a?(String) && value.match?(/\A\d{4}-\d{2}-\d{2}\z/)
    Date.iso8601(value)
  end
end

Jekyll::Hooks.register :site, :post_read do |site|
  events = site.collections.fetch('events').docs
  news = site.collections.fetch('news').docs
  people = site.collections.fetch('people').docs
  events.each do |record|
    d = record.data
    %w[title permalink start_date].each { |key| raise "#{record.relative_path}: missing #{key}" if d[key].to_s.empty? }
    CommunityRecords.validate_date!(d['start_date'], record.relative_path)
    CommunityRecords.validate_date!(d['end_date'], record.relative_path) if d['end_date']
    %w[start_time end_time].each do |key|
      raise "#{record.relative_path}: invalid #{key}; quote HH:MM values" if d[key] && !(d[key].is_a?(String) && d[key].match?(/\A(?:[01]\d|2[0-3]):[0-5]\d\z/))
    end
    raise "#{record.relative_path}: year folder disagrees with start date" unless record.relative_path.include?("_events/#{d['start_date'][0,4]}/")
    start_value = d['start_date'] + d.fetch('start_time', '')
    end_value = (d['end_date'] || d['start_date']) + d.fetch('end_time', d.fetch('start_time', ''))
    raise "#{record.relative_path}: end precedes start without date_review" if end_value < start_value && !d['date_review']
    d['search_content'] = ([d['title'], d['start_date'], d['end_date'], d['presenter'], d['location'], record.content].compact.join(' '))
  end
  news.each do |record|
    d = record.data
    %w[title permalink].each { |key| raise "#{record.relative_path}: missing #{key}" if d[key].to_s.empty? }
    CommunityRecords.validate_date!(d['published_date'], record.relative_path) if d['published_date']
    year = d['published_date']&.slice(0,4) || d['published_year'] || 'undated'
    d['archived'] = record.relative_path.include?('_news/archived-news/')
    expected_directory = d['archived'] ? '_news/archived-news/' : "_news/#{year}/"
    raise "#{record.relative_path}: folder disagrees with publication metadata" unless record.relative_path.include?(expected_directory)
    d['archive_year'] = year
    d['sort_date'] = d['published_date'] || "#{year}-00-00"
  end
  people.each do |record|
    %w[name role affiliation anchor groups display_order].each { |key| raise "#{record.relative_path}: missing #{key}" if record.data[key].nil? }
  end
  (events + news + people).each do |record|
    %w[image flyer].each do |key|
      path = record.data[key]
      next unless path
      raise "#{record.relative_path}: missing #{key}: #{path}" unless File.file?(File.join(site.source, path.delete_prefix('/')))
      alt_key = key == 'flyer' ? 'flyer_alt' : 'image_alt'
      raise "#{record.relative_path}: missing #{alt_key}" if record.data[alt_key].to_s.strip.empty?
    end
  end
  site.data['upcoming_events'] = events.select { |event| CommunityRecords.upcoming?(event.data, site.time.to_date) }.sort_by { |event| event.data['start_date'] }
  {'/about/our-team.html' => 'team', '/about/affiliates.html' => 'affiliates'}.each do |url, group|
    page = site.pages.find { |p| p.url == url }
    members = people.select { |p| p.data['groups'].include?(group) }
    anchors = members.map { |p| p.data['anchor'] }
    raise "Duplicate people anchors in #{group}" unless anchors.uniq == anchors
    page.data['search_content'] = page.content + ' ' + members.map { |p| [p.data['name'], p.data['role'], p.data['affiliation'], p.data['expertise'], p.content].compact.join(' ') }.join(' ')
  end
end

Jekyll::Hooks.register :site, :pre_render do |site|
  published = site.pages + site.collections.values.select { |c| c.metadata['output'] }.flat_map(&:docs)
  duplicates = published.group_by(&:url).select { |url, docs| docs.size > 1 }
  raise "Duplicate output URLs: #{duplicates.keys.join(', ')}" unless duplicates.empty?
end

class CommunityNewsYears < Jekyll::Generator
  safe true
  def generate(site)
    site.collections.fetch('news').docs.map { |record| record.data['archive_year'] }.uniq.each do |year|
      url = "/news/#{year}.html"
      next if site.pages.any? { |page| page.url == url }
      page = Jekyll::PageWithoutAFile.new(site, site.source, 'news', "#{year}.md")
      page.data = {'title' => "#{year} News", 'permalink' => url, 'layout' => 'base-unm', 'section' => 'News', 'section_url' => '/news/index.html'}
      page.content = "# #{year} News\n\n{% include community/news-list.html year=\"#{year}\" %}\n"
      site.pages << page
    end
  end
end
