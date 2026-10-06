(function () {
  'use strict';

  var sections = document.querySelectorAll('.projects-carousel-section');
  if (!sections.length) return;

  var AUTOPLAY_DELAY_MS = 4500;

  sections.forEach(function (section) {
    var track = section.querySelector('.projects-carousel-track');
    var previousButton = section.querySelector('.projects-carousel-control--previous');
    var nextButton = section.querySelector('.projects-carousel-control--next');
    if (!track || !previousButton || !nextButton) return;

    var reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    var timer = null;

    function slideStep() {
      var slide = track.querySelector('.projects-carousel-slide');
      if (!slide) return track.clientWidth;
      var gap = parseFloat(window.getComputedStyle(track).columnGap || '0') || 0;
      return slide.getBoundingClientRect().width + gap;
    }

    function atStart() { return track.scrollLeft <= 4; }
    function atEnd() { return track.scrollLeft + track.clientWidth >= track.scrollWidth - 4; }

    function advance(direction) {
      if (direction > 0 && atEnd()) {
        track.scrollTo({ left: 0, behavior: 'smooth' });
        return;
      }
      if (direction < 0 && atStart()) {
        track.scrollTo({ left: track.scrollWidth, behavior: 'smooth' });
        return;
      }
      track.scrollBy({ left: direction * slideStep(), behavior: 'smooth' });
    }

    function startAutoplay() {
      if (reduceMotion || timer) return;
      timer = window.setInterval(function () { advance(1); }, AUTOPLAY_DELAY_MS);
    }

    function stopAutoplay() {
      if (!timer) return;
      window.clearInterval(timer);
      timer = null;
    }

    previousButton.addEventListener('click', function () {
      stopAutoplay();
      advance(-1);
    });
    nextButton.addEventListener('click', function () {
      stopAutoplay();
      advance(1);
    });

    section.addEventListener('mouseenter', stopAutoplay);
    section.addEventListener('mouseleave', startAutoplay);
    section.addEventListener('focusin', stopAutoplay);
    section.addEventListener('focusout', function (event) {
      if (!section.contains(event.relatedTarget)) startAutoplay();
    });
    track.addEventListener('pointerdown', stopAutoplay);

    startAutoplay();
  });
}());
