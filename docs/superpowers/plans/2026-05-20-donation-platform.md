# Donation Platform Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Embed a GiveButter donation widget natively into the Grace Church site — a "Give" nav button that scrolls to a new Give section containing the styled widget.

**Architecture:** All changes are in a single static HTML file (`index.html`). CSS goes in the existing `<style>` block. HTML section goes between `#rebuild` and `#prayer`. GiveButter renders via their custom element (`<givebutter-widget>`) loaded by their CDN script added before `</body>`.

**Tech Stack:** Vanilla HTML/CSS, GiveButter embed, no build system.

**Spec:** `docs/superpowers/specs/2026-05-20-donation-platform-design.md`

---

## File Map

| File | Change |
|---|---|
| `index.html:1344` | Insert Give section CSS after `.rebuild` styles |
| `index.html:1736` | Add mobile Give rule to existing media query |
| `index.html:2402` | Insert Give nav `<li>` after Contact item |
| `index.html:2787` | Insert Give section HTML after `</section>` (end of rebuild) |
| `index.html:3204` | Add `.give-inner > *` to `revealSelectors` array |
| `index.html:3314` | Add GiveButter `<script>` before `</script>` closing tag |

---

## Task 1: Add Give Section CSS

**File:** `index.html` — inside the `<style>` block

- [ ] **Step 1: Insert the Give section CSS**

Find this exact line in `index.html` (line 1345):

```
  .rebuild .btn-primary:hover { background: transparent; color: var(--cream); }
```

Insert the following **after** that line and **before** the `/* ====== PRAYER REQUEST ======*/` comment:

```css
  /* ====== GIVE ====== */
  .give {
    background: #ece3cf;
    padding: 80px 40px;
  }
  .give-inner {
    max-width: 1100px;
    margin: 0 auto;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 64px;
    align-items: center;
  }
  .give-left h2 {
    font-size: 36px;
    color: var(--ink);
    font-weight: 700;
    line-height: 1.2;
    margin-bottom: 16px;
  }
  .give-left p {
    color: var(--muted);
    font-size: 15px;
    line-height: 1.75;
    margin-bottom: 24px;
  }
  .give-verse {
    border-left: 2px solid var(--gold);
    padding-left: 16px;
    font-style: italic;
    color: var(--earth);
    font-size: 14px;
    line-height: 1.65;
  }
  .give-widget {
    background: var(--ivory);
    border: 1px solid var(--tan-soft);
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 4px 24px rgba(61,47,33,.10);
  }
  .give-widget-head {
    background: var(--bark);
    padding: 18px 24px;
  }
  .give-widget-title {
    font-family: 'Fraunces', Georgia, serif;
    font-size: 18px;
    font-weight: 400;
    color: var(--cream);
    letter-spacing: -0.01em;
    margin-bottom: 4px;
  }
  .give-widget-sub {
    font-size: 11px;
    color: var(--gold-soft);
    opacity: 0.8;
  }
  .give-widget-body {
    padding: 24px;
  }
  .give-widget-foot {
    background: var(--tan-bg);
    padding: 8px 24px;
    font-size: 9px;
    color: var(--muted);
    opacity: 0.5;
    letter-spacing: 0.03em;
    text-align: center;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 5px;
  }
```

- [ ] **Step 2: Add mobile rule to existing media query**

Find the line (around line 1736 after your insertion):

```css
    .welcome, .rebuild { padding: 80px 24px; }
```

On the line immediately after it, add:

```css
    .give { padding: 60px 24px; }
    .give-inner { grid-template-columns: 1fr; gap: 40px; }
```

- [ ] **Step 3: Commit**

```bash
git add index.html
git commit -m "Add Give section CSS"
```

---

## Task 2: Add Give Nav Button

**File:** `index.html:2402` (line numbers shift slightly after Task 1's insertions — search by content)

- [ ] **Step 1: Insert the nav list item**

Find this exact block in `#navMenu`:

```html
      <li><a href="#contact" data-en="Contact" data-ru="Контакты">Contact</a></li>
      <li class="lang-toggle-wrap">
```

Replace it with:

```html
      <li><a href="#contact" data-en="Contact" data-ru="Контакты">Contact</a></li>
      <li class="give-wrap"><a href="#give" class="give-btn" data-en="Give →" data-ru="Пожертвовать →">Give →</a></li>
      <li class="lang-toggle-wrap">
```

- [ ] **Step 2: Verify nav renders**

Open `index.html` in a browser (or the dev server). The nav should show a gold "Give →" button to the right of "Contact" and to the left of the EN/RУ toggle. Click it — the page should smooth-scroll to the `#give` section (which doesn't exist yet, so it won't scroll anywhere meaningful yet — that's fine).

- [ ] **Step 3: Commit**

```bash
git add index.html
git commit -m "Add Give nav button"
```

---

## Task 3: Add Give Section HTML

**File:** `index.html` — between `</section>` (end of `#rebuild`) and `<!-- PRAYER REQUEST -->` comment

- [ ] **Step 1: Insert the Give section**

Find this exact block (search by content — line numbers shifted):

```html
</section>

<!-- ============ PRAYER REQUEST ============ -->
```

Replace it with:

```html
</section>

<!-- ============ GIVE ============ -->
<section class="give" id="give">
  <div class="give-inner">
    <div class="give-left">
      <div class="eyebrow" data-en="Give" data-ru="Пожертвовать">Give</div>
      <h2 data-en="Support the ministry." data-ru="Поддержите служение.">Support the ministry.</h2>
      <p data-en="Thank you for supporting Grace Church. Your gift sustains our efforts to serve others and care for everything that makes this church home." data-ru="Спасибо за поддержку церкви Благодать. Ваш дар помогает нам служить другим и заботиться обо всём, что делает нашу церковь домом.">Thank you for supporting Grace Church. Your gift sustains our efforts to serve others and care for everything that makes this church home.</p>
      <blockquote class="give-verse" data-en='"Each of you should give what you have decided in your heart to give, not reluctantly or under compulsion, for God loves a cheerful giver." — 2 Corinthians 9:7' data-ru='"Каждый уделяй по расположению сердца, не с огорчением и не с принуждением; ибо доброхотно дающего любит Бог." — 2 Коринфянам 9:7'>"Each of you should give what you have decided in your heart to give, not reluctantly or under compulsion, for God loves a cheerful giver." — 2 Corinthians 9:7</blockquote>
    </div>
    <div class="give-widget">
      <div class="give-widget-head">
        <div class="give-widget-title">Grace Evangelical Church</div>
        <div class="give-widget-sub" data-en="All donations go directly to the church" data-ru="Все пожертвования идут напрямую в церковь">All donations go directly to the church</div>
      </div>
      <div class="give-widget-body">
        <givebutter-widget id="grace-slavic-church-rchpdv"></givebutter-widget>
      </div>
      <div class="give-widget-foot">
        <svg width="10" height="12" viewBox="0 0 12 14" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
          <rect x="1" y="5" width="10" height="8" rx="1.5" stroke="#7a6b5a" stroke-width="1.2"/>
          <path d="M3.5 5V3.5a2.5 2.5 0 0 1 5 0V5" stroke="#7a6b5a" stroke-width="1.2" stroke-linecap="round"/>
        </svg>
        Secure &amp; encrypted · Powered by GiveButter
      </div>
    </div>
  </div>
</section>

<!-- ============ PRAYER REQUEST ============ -->
```

- [ ] **Step 2: Commit**

```bash
git add index.html
git commit -m "Add Give section HTML"
```

---

## Task 4: Add GiveButter Script + Reveal Animation

**File:** `index.html` — two edits

- [ ] **Step 1: Add GiveButter CDN script**

Find the closing `</script>` tag of the main JS block (last `</script>` before `</body>`):

```html
</script>

</body>
```

Insert the GiveButter script between them:

```html
</script>

<script src="https://givebutter.com/js/widget.js"></script>

</body>
```

- [ ] **Step 2: Add Give section to reveal selectors**

Find this line in the JS:

```js
    '.rebuild-inner > *',
```

Add the Give selector on the next line:

```js
    '.rebuild-inner > *',
    '.give-inner > *',
```

- [ ] **Step 3: Commit**

```bash
git add index.html
git commit -m "Add GiveButter embed script and reveal animation"
```

---

## Task 5: Verify End-to-End

- [ ] **Step 1: Open the site in a browser**

If using a local server: `python3 -m http.server 8080` from the project root, then open `http://localhost:8080`.

- [ ] **Step 2: Check the nav**

The nav should show `Give →` as a gold button between "Contact" and the EN/RУ toggle. On mobile (resize to <768px), the button should appear in the hamburger menu.

- [ ] **Step 3: Click "Give →"**

Page should smooth-scroll to the Give section. The section should show:
- Left column: "Give" eyebrow, "Support the ministry." heading, body text, scripture blockquote with gold left border
- Right column: dark widget header with Fraunces "Grace Evangelical Church" title, the GiveButter widget rendering inside, subtle footer

- [ ] **Step 4: Interact with the GiveButter widget**

The GiveButter widget should be fully functional — amount selection, custom input, one-time/monthly toggle, and the Give Now button should open GiveButter's payment flow. If the widget renders blank, check the browser console for script errors (likely the `<givebutter-widget>` custom element not registering — confirm the script URL is correct from the GiveButter dashboard).

- [ ] **Step 5: Test language toggle**

Switch to RУ. The eyebrow, heading, body, and scripture should switch to Russian. The GiveButter widget itself stays in English (expected).

- [ ] **Step 6: Check mobile layout**

At ≤768px: the two-column layout should stack with copy above widget, both full width.

- [ ] **Step 7: Commit if any fixes were made**

```bash
git add index.html
git commit -m "Fix Give section — [describe what was fixed]"
```

---

## Notes

- The `#give` anchor is automatically picked up by the existing `sectionObserver` JS (line ~3239) that highlights the active nav link — no extra code needed.
- The Russian translations in Task 3 are machine-translated and should be verified by a native Russian speaker before launch.
- If GiveButter's script loads asynchronously and the widget renders with a flash of unstyled content, that is expected and controlled by GiveButter — not something to fix on our side.
