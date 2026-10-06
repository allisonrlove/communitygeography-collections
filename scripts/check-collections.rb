#!/usr/bin/env ruby
require 'jekyll'
require 'json'
require 'nokogiri'
require 'digest'

output = File.expand_path(ARGV.fetch(0, '_site'))
comparison = ARGV[1] && File.expand_path(ARGV[1])
site = Jekyll::Site.new(Jekyll.configuration('source' => Dir.pwd, 'destination' => output, 'quiet' => true))
site.read # Also runs record schema, date, image, and grouping validation.
events, news, people = %w[events news people].map { |name| site.collections.fetch(name).docs }
index = JSON.parse(File.read(File.join(output, 'assets/search-index.json')))
base = site.baseurl
base = YAML.load_file('_config.ci.yml').fetch('baseurl', base) if File.file?('_config.ci.yml')
urls = index.map { |entry| entry['url'].delete_prefix(base) }
errors = []
errors << 'Duplicate search URLs' unless urls.uniq == urls
(events + news).each do |record|
  errors << "Missing output: #{record.url}" unless File.file?(File.join(output, record.url.delete_prefix('/')))
  errors << "Missing search record: #{record.url}" unless urls.include?(record.url)
end
people.each do |record|
  record.data['groups'].each do |group|
    url = group == 'team' ? '/about/our-team.html' : '/about/affiliates.html'
    entry = index.find { |item| item['url'].delete_prefix(base) == url }
    errors << "Missing searchable biography: #{record.data['name']}" unless entry && entry['content'].include?(record.data['name'])
  end
end
gallery = Nokogiri::HTML(File.read(File.join(output, 'projects/gis-day-2025-gallery.html')))
errors << 'Gallery lost photographs' unless gallery.css('.record-gallery img').size == site.data['gis-day-gallery'].size
gallery.css('.record-gallery img').each { |image| errors << "Gallery link missing: #{image['src']}" unless image.parent.name == 'a' && image.parent['href'] == image['src'] }

if comparison
  tokens = ->(text) { text.scan(/[\p{L}\p{N}]+/u) }
  manifest = JSON.parse(File.read('migration/manifest.json'))
  manifest['pages'].each do |page|
    path = page['permalink'].delete_prefix('/')
    before = Nokogiri::HTML(File.read(File.join(comparison, path))).at_css('.center-article')
    after = Nokogiri::HTML(File.read(File.join(output, path))).at_css('.center-article')
    old_ids = before.css('[id]').map { |node| node['id'] }.reject(&:empty?)
    missing = old_ids - after.css('[id]').map { |node| node['id'] }
    errors << "Lost anchors in #{path}: #{missing.join(', ')}" unless missing.empty?
    if after.at_css('.record-event')
      before.at_css('h1')&.remove
      before.at_css('#photo-event')&.ancestors('p')&.first&.remove
      before.css('p').select { |p| p.text.strip.match?(/\A(?:Start|End|Presenter|Location):/) }.each(&:remove)
      errors << "Changed event narrative: #{path}" unless tokens.call(before.text) == tokens.call(after.at_css('.record-body').text)
    elsif after.at_css('.record-news')
      before.at_css('h1')&.remove
      errors << "Changed news narrative: #{path}" unless tokens.call(before.text) == tokens.call(after.at_css('.record-body').text)
    elsif %w[about/our-team.html about/affiliates.html].include?(path)
      errors << "Changed directory wording/order: #{path}" unless tokens.call(before.text) == tokens.call(after.text)
    end
  end
  site.data['legacy-assets'].each do |asset|
    expected = Digest::SHA256.file(File.join(comparison, asset['from'])).hexdigest
    [asset['from'], asset['to']].each do |path|
      file = File.join(output, path)
      errors << "Changed/missing asset: #{path}" unless File.file?(file) && Digest::SHA256.file(file).hexdigest == expected
    end
  end
  # The formerly embedded 2026 story is maintained once, in its new record.
  original = Nokogiri::HTML(File.read(File.join(comparison, 'news/2026.html'))).at_css('.center-article')
  original.at_css('h1')&.remove
  migrated = Nokogiri::HTML(File.read(File.join(output, 'news/michael-devivo-visit.html'))).at_css('.record-body')
  # The descriptive PDF link is the single intentional prose addition.
  migrated.css('a').select { |a| a.text == 'View the Dr. Michael DeVivo talk flyer (PDF)' }.each(&:remove)
  article_title = migrated.ancestors('article').first.at_css('h1').text
  errors << 'Changed embedded 2026 article' unless tokens.call(original.text) == tokens.call(article_title + ' ' + migrated.text)
end
abort errors.join("\n") unless errors.empty?
puts "Checked #{events.size} events, #{news.size} news records, #{people.size} people: metadata, output, search, gallery passed."
puts 'Original narrative, directory order, anchors, and asset hashes also passed.' if comparison
