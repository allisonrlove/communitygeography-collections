(function () {
  'use strict';

  var feed = document.querySelector('.instagram-feed');
  if (!feed) return;

  var track = feed.querySelector('.instagram-carousel-track');
  var previousButton = feed.querySelector('.instagram-carousel-control--previous');
  var nextButton = feed.querySelector('.instagram-carousel-control--next');
  var fallback = feed.querySelector('.instagram-feed-fallback');

  function getPosts(payload) {
    return payload && Array.isArray(payload.posts) ? payload.posts : [];
  }

  function getCaption(post) {
    return post.caption || 'Instagram post from the Center for Community Geography';
  }

  function escapeHtml(value) {
    return String(value).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
  }

  function renderPosts(posts) {
    var cards = posts.slice(0, 12).map(function (post) {
      var image = post.thumbnail_url || post.media_url;
      if (!image || !post.permalink) return '';

      return '<article class="instagram-post">' +
        '<a href="' + escapeHtml(post.permalink) + '" target="_blank" rel="noopener noreferrer">' +
        '<img src="' + escapeHtml(image) + '" loading="lazy" decoding="async" alt="' + escapeHtml(getCaption(post)) + '">' +
        '<span class="instagram-post-overlay"><span>View post <span aria-hidden="true">↗</span></span></span>' +
        '</a>' +
        '</article>';
    }).filter(Boolean);

    if (!cards.length) {
      showFallback();
      return;
    }

    track.innerHTML = cards.join('');
    previousButton.hidden = false;
    nextButton.hidden = false;
  }

  function showFallback() {
    track.innerHTML = '';
    previousButton.hidden = true;
    nextButton.hidden = true;
    fallback.hidden = false;
  }

  function move(direction) {
    var firstCard = track.querySelector('.instagram-post');
    if (!firstCard) return;
    track.scrollBy({
      left: direction * (firstCard.getBoundingClientRect().width + 16),
      behavior: 'smooth'
    });
  }

  previousButton.addEventListener('click', function () {
    move(-1);
  });

  nextButton.addEventListener('click', function () {
    move(1);
  });

  try {
    var dataElement = document.getElementById('instagram-feed-data');
    renderPosts(JSON.parse(dataElement.textContent));
  } catch (error) {
    showFallback();
  }
})();
