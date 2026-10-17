// Client-side motion, as vanilla-JS strings injected by main.server.dart.
//
// Two scripts:
//
//   [bootstrapScript] — tiny, synchronous, in <head>. Adds `js` +
//     `is-loading` to <html> before first paint so hidden "from" states
//     apply without a flash, and arms a failsafe that reveals everything
//     if the motion script never starts (CDN blocked, JS error, …).
//
//   [animationScripts] — the motion engine. Runs on DOMContentLoaded,
//     after the deferred vendor scripts (Lenis, GSAP, ScrollTrigger):
//
//       1. Preloader       — counter 0→100, then a curtain wipe.
//       2. Lenis           — inertial smooth scroll, synced to GSAP's ticker.
//       3. Anchors         — in-page links glide via lenis.scrollTo().
//       4. Navbar          — hides on scroll-down, progress bar, ScrollSpy
//                            with a sliding active pill.
//       5. Mobile menu     — full-screen overlay, Esc to close.
//       6. Reveals         — IntersectionObserver adds `.is-in`.
//       7. Counters        — stats count up when visible.
//       8. Cursor          — dot + lagging ring, label on [data-cursor].
//       9. Magnetic        — `.magnetic` elements lean toward the pointer.
//      10. Scroll scenes   — GSAP ScrollTrigger: hero parallax-out, scrubbed
//                            statement, stacked work cards, pinned horizontal
//                            Lab, marquee skew from scroll velocity.
//
// Every feature degrades: no GSAP → no scrubbed scenes but everything is
// visible; no Lenis → native scroll; reduced motion → no motion at all.
//
// Raw strings (r''' … ''') keep the JS free of Dart `$` interpolation.

/// Synchronous `head` bootstrap. Must NOT be deferred.
const String bootstrapScript = r'''
(function () {
  var d = document.documentElement;
  d.classList.add('js', 'is-loading');
  try { if ('scrollRestoration' in history) history.scrollRestoration = 'manual'; } catch (_) {}
  setTimeout(function () {
    if (!window.__motionStarted) {
      d.classList.add('reveal-all');
      d.classList.remove('is-loading');
    }
  }, 4500);
})();
''';

/// The motion engine.
const String animationScripts = r'''
(() => {
  'use strict';
  const root = document.documentElement;
  const mq = (q) => window.matchMedia && window.matchMedia(q).matches;
  const reduce = mq('(prefers-reduced-motion: reduce)');
  const fine = mq('(hover: hover) and (pointer: fine)');
  const $ = (s, c = document) => c.querySelector(s);
  const $$ = (s, c = document) => Array.from(c.querySelectorAll(s));
  const clamp = (v, a, b) => Math.min(b, Math.max(a, v));

  const ready = (fn) =>
    document.readyState === 'loading'
      ? document.addEventListener('DOMContentLoaded', fn, { once: true })
      : fn();

  ready(() => {
    window.__motionStarted = true;
    try {
      init();
    } catch (err) {
      console.error('[motion]', err);
      root.classList.add('reveal-all');
      root.classList.remove('is-loading');
    }
  });

  function init() {
    // `late` = the head failsafe already revealed everything because the
    // vendor scripts were slow. The page is visible and maybe scrolled, so
    // skip the intro + entrance reveals but still bring the motion layer
    // (smooth scroll, cursor, scroll scenes) online.
    const late = root.classList.contains('reveal-all');
    const motion = !reduce;
    const intro = motion && !late;
    const hasGsap = !!(window.gsap && window.ScrollTrigger);
    if (hasGsap) gsap.registerPlugin(ScrollTrigger);
    if (!location.hash && !late) window.scrollTo(0, 0);

    const lenis = setupLenis(hasGsap);
    if (lenis && root.classList.contains('is-loading')) lenis.stop();

    setupAnchors(lenis);
    setupNav();
    setupMenu(lenis);
    setupClock();
    setupRotator(motion);
    setupCursor(motion);
    setupMagnetic(motion);
    setupSpotlight();
    setupCopy();
    setupReveals(intro);
    setupCounters(intro);
    if (hasGsap && motion) setupScenes(lenis);

    runPreloader(intro, () => {
      root.classList.remove('is-loading');
      if (lenis) lenis.start();
      $$('[data-load]').forEach((el) => el.classList.add('is-in'));
      if (hasGsap) ScrollTrigger.refresh();
      if (location.hash && !late) {
        const t = document.getElementById(location.hash.slice(1));
        if (t) lenis ? lenis.scrollTo(t, { immediate: true, force: true }) : t.scrollIntoView();
      }
    });
  }

  // -----------------------------------------------------------------
  // 1. Preloader
  // -----------------------------------------------------------------
  function runPreloader(motion, done) {
    const pre = $('[data-preloader]');
    if (!pre || !motion) {
      if (pre) pre.remove();
      done();
      return;
    }
    const count = $('[data-preloader-count]', pre);
    const bar = $('[data-preloader-bar]', pre);
    let seen = false;
    try {
      seen = sessionStorage.getItem('ab-intro') === '1';
      sessionStorage.setItem('ab-intro', '1');
    } catch (_) {}
    const duration = seen ? 450 : 1800;
    const ease = (p) => 1 - Math.pow(1 - p, 3);
    const t0 = performance.now();
    pre.classList.add('is-running');

    const step = (now) => {
      const p = Math.min(1, (now - t0) / duration);
      const e = ease(p);
      if (count) count.textContent = String(Math.round(e * 100));
      if (bar) bar.style.transform = 'scaleX(' + e + ')';
      if (p < 1) return requestAnimationFrame(step);
      setTimeout(() => {
        pre.classList.add('is-done');
        setTimeout(done, 420);
        setTimeout(() => pre.remove(), 1600);
      }, seen ? 0 : 220);
    };
    requestAnimationFrame(step);
  }

  // -----------------------------------------------------------------
  // 2. Lenis smooth scroll
  // -----------------------------------------------------------------
  function setupLenis(hasGsap) {
    if (reduce || !window.Lenis) return null;
    const lenis = new Lenis({
      duration: 1.25,
      easing: (t) => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
      smoothWheel: true,
      wheelMultiplier: 0.95,
      touchMultiplier: 1.5,
    });
    if (hasGsap) {
      lenis.on('scroll', ScrollTrigger.update);
      gsap.ticker.add((time) => lenis.raf(time * 1000));
      gsap.ticker.lagSmoothing(0);
    } else {
      const raf = (t) => { lenis.raf(t); requestAnimationFrame(raf); };
      requestAnimationFrame(raf);
    }
    window.__lenis = lenis;
    return lenis;
  }

  // -----------------------------------------------------------------
  // 3. In-page anchors
  // -----------------------------------------------------------------
  function setupAnchors(lenis) {
    const samePage = (url) =>
      url.origin === location.origin &&
      url.pathname.replace(/index\.html$/, '') === location.pathname.replace(/index\.html$/, '');
    const easeInOut = (t) => (t < 0.5 ? 4 * t * t * t : 1 - Math.pow(-2 * t + 2, 3) / 2);

    document.addEventListener('click', (e) => {
      const a = e.target.closest('a[href*="#"]');
      if (!a || e.metaKey || e.ctrlKey || e.shiftKey) return;
      let url;
      try { url = new URL(a.href, location.href); } catch (_) { return; }
      if (!samePage(url)) return;
      const id = decodeURIComponent(url.hash.slice(1));
      const target = id ? document.getElementById(id) : null;
      if (id && !target) return;
      e.preventDefault();
      if (window.__closeMenu) window.__closeMenu();
      const top = !target || id === 'home' ? 0 : target;
      if (lenis) {
        lenis.scrollTo(top, { duration: 1.7, easing: easeInOut, force: true });
      } else if (target) {
        target.scrollIntoView({ behavior: reduce ? 'auto' : 'smooth' });
      } else {
        window.scrollTo({ top: 0, behavior: reduce ? 'auto' : 'smooth' });
      }
      try { history.replaceState(null, '', id ? '#' + id : location.pathname); } catch (_) {}
    });
  }

  // -----------------------------------------------------------------
  // 4. Navbar — hide on scroll-down, progress bar, ScrollSpy
  // -----------------------------------------------------------------
  function setupNav() {
    const nav = $('[data-nav]');
    const bar = $('[data-progress]');
    let lastY = window.scrollY;
    let ticking = false;

    const update = () => {
      const y = window.scrollY;
      const max = document.documentElement.scrollHeight - window.innerHeight;
      if (bar) bar.style.transform = 'scaleX(' + (max > 0 ? clamp(y / max, 0, 1) : 0) + ')';
      if (nav) {
        nav.classList.toggle('is-scrolled', y > 24);
        if (!root.classList.contains('menu-open')) {
          const down = y > lastY + 2;
          const up = y < lastY - 2;
          if (down && y > window.innerHeight * 0.5) nav.classList.add('is-hidden');
          else if (up || y < 80) nav.classList.remove('is-hidden');
        }
      }
      lastY = y;
      ticking = false;
    };
    window.addEventListener('scroll', () => {
      if (!ticking) { ticking = true; requestAnimationFrame(update); }
    }, { passive: true });
    update();

    // ScrollSpy — sections map to nav links by id (or data-spy override).
    const links = $$('[data-nav-link]');
    const menuLinks = $$('[data-menu-link]');
    const indicator = $('[data-nav-indicator]');
    const hashOf = (el) => (el.getAttribute('href') || '').split('#')[1] || '';
    let active = null;

    const moveIndicator = () => {
      if (!indicator) return;
      const link = links.find((l) => hashOf(l) === active);
      if (!link) { indicator.style.opacity = '0'; return; }
      indicator.style.opacity = '1';
      indicator.style.width = link.offsetWidth + 'px';
      indicator.style.transform = 'translateX(' + link.offsetLeft + 'px)';
    };
    const setActive = (id) => {
      if (id === active) return;
      active = id;
      links.forEach((l) => l.classList.toggle('is-active', hashOf(l) === id));
      menuLinks.forEach((l) => l.classList.toggle('is-active', hashOf(l) === id));
      moveIndicator();
    };

    if ('IntersectionObserver' in window) {
      const io = new IntersectionObserver((entries) => {
        entries.forEach((en) => {
          if (en.isIntersecting) setActive(en.target.dataset.spy || en.target.id);
        });
      }, { rootMargin: '-48% 0px -51% 0px' });
      $$('main section[id]').forEach((s) => io.observe(s));
    }
    window.addEventListener('resize', moveIndicator);
  }

  // -----------------------------------------------------------------
  // 5. Mobile menu
  // -----------------------------------------------------------------
  function setupMenu(lenis) {
    const btn = $('[data-menu-toggle]');
    const menu = $('[data-menu]');
    if (!btn || !menu) return;
    const set = (open) => {
      root.classList.toggle('menu-open', open);
      btn.setAttribute('aria-expanded', String(open));
      btn.setAttribute('aria-label', open ? 'Close menu' : 'Open menu');
      menu.setAttribute('aria-hidden', String(!open));
      menu.inert = !open;
      if (lenis) open ? lenis.stop() : lenis.start();
      if (open) { const nav = $('[data-nav]'); if (nav) nav.classList.remove('is-hidden'); }
    };
    window.__closeMenu = () => { if (root.classList.contains('menu-open')) set(false); };
    btn.addEventListener('click', () => set(!root.classList.contains('menu-open')));
    window.addEventListener('keydown', (e) => { if (e.key === 'Escape') window.__closeMenu(); });
    window.addEventListener('resize', () => { if (window.innerWidth >= 1024) window.__closeMenu(); });
  }

  // -----------------------------------------------------------------
  // Local time clock — <span data-clock="Africa/Tunis">
  // -----------------------------------------------------------------
  function setupClock() {
    const els = $$('[data-clock]');
    if (!els.length) return;
    const fmts = new Map();
    const tick = () => {
      els.forEach((el) => {
        const tz = el.getAttribute('data-clock') || undefined;
        try {
          if (!fmts.has(tz)) {
            fmts.set(tz, new Intl.DateTimeFormat('en-GB', { hour: '2-digit', minute: '2-digit', timeZone: tz }));
          }
          el.textContent = fmts.get(tz).format(new Date());
        } catch (_) {}
      });
    };
    tick();
    setInterval(tick, 10000);
  }

  // -----------------------------------------------------------------
  // Word rotator — <span data-rotator><span class="rotator__item">…
  // -----------------------------------------------------------------
  function setupRotator(motion) {
    if (!motion) return;
    $$('[data-rotator]').forEach((el) => {
      const items = $$('.rotator__item', el);
      if (items.length < 2) return;
      let i = 0;
      const fit = () => { el.style.width = items[i].offsetWidth + 'px'; };
      fit();
      setInterval(() => {
        const prev = items[i];
        i = (i + 1) % items.length;
        const next = items[i];
        prev.classList.remove('is-active');
        prev.classList.add('is-leaving');
        next.classList.remove('is-leaving');
        next.classList.add('is-active');
        setTimeout(() => prev.classList.remove('is-leaving'), 900);
        fit();
      }, 2600);
      window.addEventListener('resize', fit);
      if (document.fonts && document.fonts.ready) document.fonts.ready.then(fit);
    });
  }

  // -----------------------------------------------------------------
  // 6. Reveals
  // -----------------------------------------------------------------
  function setupReveals(motion) {
    const els = $$('[data-reveal], [data-split]').filter((el) => !el.hasAttribute('data-load'));
    if (!motion || !('IntersectionObserver' in window)) {
      els.forEach((el) => el.classList.add('is-in'));
      return;
    }
    const io = new IntersectionObserver((entries) => {
      entries.forEach((en) => {
        if (en.isIntersecting) {
          en.target.classList.add('is-in');
          io.unobserve(en.target);
        }
      });
    }, { rootMargin: '0px 0px -10% 0px', threshold: 0.01 });
    els.forEach((el) => io.observe(el));
  }

  // -----------------------------------------------------------------
  // 7. Counters — <span data-count="5" data-pad="2">05</span>
  // -----------------------------------------------------------------
  function setupCounters(motion) {
    const els = $$('[data-count]');
    if (!motion || !els.length || !('IntersectionObserver' in window)) return;
    const fmt = (el, v) => String(v).padStart(parseInt(el.dataset.pad || '0', 10), '0');
    const run = (el) => {
      const end = parseFloat(el.dataset.count) || 0;
      const t0 = performance.now();
      const dur = 1800;
      const step = (now) => {
        const p = Math.min(1, (now - t0) / dur);
        el.textContent = fmt(el, Math.round(end * (1 - Math.pow(1 - p, 4))));
        if (p < 1) requestAnimationFrame(step);
      };
      requestAnimationFrame(step);
    };
    const io = new IntersectionObserver((entries) => {
      entries.forEach((en) => {
        if (en.isIntersecting) { io.unobserve(en.target); run(en.target); }
      });
    }, { threshold: 0.6 });
    els.forEach((el) => { el.textContent = fmt(el, 0); io.observe(el); });
  }

  // -----------------------------------------------------------------
  // 8. Custom cursor
  // -----------------------------------------------------------------
  function setupCursor(motion) {
    if (!fine || !motion) return;
    const dot = $('[data-cursor-dot]');
    const ring = $('[data-cursor-ring]');
    const label = $('[data-cursor-label]');
    if (!dot || !ring) return;
    root.classList.add('has-cursor');
    let mx = -100, my = -100, rx = -100, ry = -100, seen = false;

    window.addEventListener('mousemove', (e) => {
      mx = e.clientX; my = e.clientY;
      if (!seen) { seen = true; rx = mx; ry = my; root.classList.add('cursor-on'); }
      dot.style.transform = 'translate3d(' + mx + 'px,' + my + 'px,0)';
    }, { passive: true });
    document.addEventListener('mouseleave', () => root.classList.remove('cursor-on'));
    document.addEventListener('mouseenter', () => { if (seen) root.classList.add('cursor-on'); });
    window.addEventListener('mousedown', () => ring.classList.add('is-down'));
    window.addEventListener('mouseup', () => ring.classList.remove('is-down'));

    const loop = () => {
      rx += (mx - rx) * 0.15;
      ry += (my - ry) * 0.15;
      ring.style.transform = 'translate3d(' + rx.toFixed(2) + 'px,' + ry.toFixed(2) + 'px,0)';
      requestAnimationFrame(loop);
    };
    requestAnimationFrame(loop);

    document.addEventListener('mouseover', (e) => {
      const labelled = e.target.closest('[data-cursor]');
      const link = e.target.closest('a, button, [role="button"]');
      const text = labelled ? labelled.getAttribute('data-cursor') : '';
      ring.classList.toggle('is-label', !!text);
      ring.classList.toggle('is-link', !text && !!link);
      if (label && text) label.textContent = text;
    });
  }

  // -----------------------------------------------------------------
  // 9. Magnetic hover
  // -----------------------------------------------------------------
  function setupMagnetic(motion) {
    if (!fine || !motion) return;
    $$('.magnetic').forEach((el) => {
      const s = parseFloat(el.getAttribute('data-magnetic') || '0.28');
      el.addEventListener('mousemove', (e) => {
        const r = el.getBoundingClientRect();
        const x = e.clientX - (r.left + r.width / 2);
        const y = e.clientY - (r.top + r.height / 2);
        el.style.transform = 'translate3d(' + (x * s).toFixed(1) + 'px,' + (y * s).toFixed(1) + 'px,0)';
      });
      el.addEventListener('mouseleave', () => { el.style.transform = ''; });
    });
  }

  // Spotlight — cards track the pointer in --mx / --my for a soft glow.
  function setupSpotlight() {
    if (!fine) return;
    $$('[data-spotlight]').forEach((el) => {
      el.addEventListener('pointermove', (e) => {
        const r = el.getBoundingClientRect();
        el.style.setProperty('--mx', (e.clientX - r.left).toFixed(0) + 'px');
        el.style.setProperty('--my', (e.clientY - r.top).toFixed(0) + 'px');
      });
    });
    const hero = $('[data-hero]');
    if (hero && !reduce) {
      hero.addEventListener('pointermove', (e) => {
        hero.style.setProperty('--px', ((e.clientX / window.innerWidth) * 2 - 1).toFixed(3));
        hero.style.setProperty('--py', ((e.clientY / window.innerHeight) * 2 - 1).toFixed(3));
      });
    }
  }

  // Copy-to-clipboard — <button data-copy="text" data-copied="Copied!">
  function setupCopy() {
    $$('[data-copy]').forEach((btn) => {
      const lbl = $('[data-copy-label]', btn);
      const original = lbl ? lbl.textContent : '';
      btn.addEventListener('click', async () => {
        const value = btn.getAttribute('data-copy') || '';
        try {
          await navigator.clipboard.writeText(value);
        } catch (_) {
          const ta = document.createElement('textarea');
          ta.value = value;
          ta.style.position = 'fixed';
          ta.style.opacity = '0';
          document.body.appendChild(ta);
          ta.select();
          try { document.execCommand('copy'); } catch (_) {}
          ta.remove();
        }
        btn.classList.add('is-copied');
        if (lbl) lbl.textContent = btn.getAttribute('data-copied') || 'Copied';
        setTimeout(() => {
          btn.classList.remove('is-copied');
          if (lbl) lbl.textContent = original;
        }, 1800);
      });
    });
  }

  // -----------------------------------------------------------------
  // 10. Scroll scenes (GSAP + ScrollTrigger)
  // -----------------------------------------------------------------
  function setupScenes(lenis) {
    const mm = gsap.matchMedia();

    // Hero — content drifts up and fades, background zooms: a slow
    // "camera pull-back" as the next section arrives.
    const hero = $('#home');
    const heroInner = $('[data-hero-inner]');
    const heroBg = $('[data-hero-bg]');
    if (hero && heroInner) {
      const st = { trigger: hero, start: 'top top', end: 'bottom top', scrub: true };
      gsap.to(heroInner, { yPercent: 22, opacity: 0.1, ease: 'none', scrollTrigger: st });
      if (heroBg) gsap.to(heroBg, { scale: 1.25, opacity: 0.4, ease: 'none', scrollTrigger: { ...st } });
    }

    // Statement — words light up one by one as you scroll.
    $$('[data-words]').forEach((el) => {
      const words = $$('.w', el);
      if (!words.length) return;
      gsap.fromTo(words, { opacity: 0.13 }, {
        opacity: 1,
        ease: 'none',
        stagger: 0.1,
        scrollTrigger: { trigger: el, start: 'top 82%', end: 'bottom 48%', scrub: 0.5 },
      });
    });

    // Generic parallax — data-parallax="0.15" (fraction of own height).
    $$('[data-parallax]').forEach((el) => {
      const amount = parseFloat(el.getAttribute('data-parallax')) || 0.12;
      gsap.fromTo(el, { yPercent: -amount * 100 }, {
        yPercent: amount * 100,
        ease: 'none',
        scrollTrigger: {
          trigger: el.closest('[data-parallax-root]') || el,
          start: 'top bottom',
          end: 'bottom top',
          scrub: true,
        },
      });
    });

    // Stacked work cards — each card recedes as the next slides over it.
    mm.add('(min-width: 900px) and (min-height: 800px)', () => {
      const items = $$('[data-stack-item]');
      items.forEach((item, i) => {
        const next = items[i + 1];
        if (!next) return;
        const card = $('.wcard', item);
        const shade = card && $('[data-shade]', card);
        const st = { trigger: next, start: 'top bottom', end: 'top 18%', scrub: true };
        gsap.to(card, { scale: 0.9, ease: 'none', scrollTrigger: st });
        if (shade) gsap.to(shade, { opacity: 0.72, ease: 'none', scrollTrigger: { ...st } });
      });
    });

    // Lab — pinned section, vertical scroll drives a horizontal track.
    mm.add('(min-width: 1024px) and (min-height: 700px)', () => {
      const pin = $('[data-hscroll]');
      const track = $('[data-hscroll-track]');
      if (!pin || !track) return;
      root.classList.add('has-hscroll');
      const progress = $('[data-hscroll-progress]');
      const distance = () => Math.max(0, track.scrollWidth - window.innerWidth);
      const tl = gsap.timeline({
        scrollTrigger: {
          trigger: pin,
          start: 'top top',
          end: () => '+=' + distance(),
          pin: true,
          scrub: 0.8,
          invalidateOnRefresh: true,
          anticipatePin: 1,
          // Refresh before the triggers below it so their start/end
          // positions account for the pin spacer.
          refreshPriority: 1,
        },
      });
      tl.to(track, { x: () => -distance(), ease: 'none' }, 0);
      if (progress) tl.fromTo(progress, { scaleX: 0 }, { scaleX: 1, ease: 'none' }, 0);
      return () => root.classList.remove('has-hscroll');
    });

    // Marquee — skews with scroll velocity, springs back when idle.
    const bands = $$('[data-marquee]');
    if (lenis && bands.length) {
      let target = 0;
      let current = 0;
      lenis.on('scroll', (l) => { target = clamp(l.velocity * 0.3, -7, 7); });
      gsap.ticker.add(() => {
        current += (target - current) * 0.12;
        target *= 0.9;
        const v = Math.abs(current) < 0.01 ? '0deg' : current.toFixed(2) + 'deg';
        bands.forEach((b) => b.style.setProperty('--skew', v));
      });
    }

    ScrollTrigger.sort();
    if (document.fonts && document.fonts.ready) document.fonts.ready.then(() => ScrollTrigger.refresh());
    window.addEventListener('load', () => ScrollTrigger.refresh());
  }
})();
''';
