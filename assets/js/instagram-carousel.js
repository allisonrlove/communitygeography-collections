(function () {
  'use strict';

  var feed = document.querySelector('.instagram-feed');
  if (!feed) return;

  var username = feed.dataset.instagramUsername;
  var track = feed.querySelector('.instagram-carousel-track');
  var previousButton = feed.querySelector('.instagram-carousel-control--previous');
  var nextButton = feed.querySelector('.instagram-carousel-control--next');
  var fallback = feed.querySelector('.instagram-feed-fallback');

  function getPosts(payload) {
    var user = payload && payload.data && payload.data.user;
    var timeline = user && user.edge_owner_to_timeline_media;
    var media = timeline && timeline.edges;

    return Array.isArray(media) ? media.map(function (edge) {
      return edge.node;
    }) : [];
  }

  function getCaption(post) {
    var captionEdge = post.edge_media_to_caption && post.edge_media_to_caption.edges[0];
    return captionEdge && captionEdge.node.text ? captionEdge.node.text : 'Instagram post from the Center for Community Geography';
  }

  function escapeHtml(value) {
    return String(value).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/'/g, '&#39;');
  }

  function renderPosts(posts) {
    var cards = posts.slice(0, 12).map(function (post) {
      var image = post.display_url || post.thumbnail_src;
      if (!image || !post.shortcode) return '';

      return '<article class="instagram-post">' +
        '<a href="https://www.instagram.com/p/' + encodeURIComponent(post.shortcode) + '/" target="_blank" rel="noopener noreferrer">' +
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
    previousButton.disabled = false;
    nextButton.disabled = false;
  }

  function showFallback() {
    track.innerHTML = '';
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

  fetch('https://www.instagram.com/api/v1/users/web_profile_info/?username=' + encodeURIComponent(username), {
    headers: { 'X-IG-App-ID': '936619743392459' }
  })
    .then(function (response) {
      if (!response.ok) throw new Error('Instagram feed request failed');
      return response.json();
    })
    .then(function (payload) {
      renderPosts(getPosts(payload));
    })
    .catch(showFallback);
})();
