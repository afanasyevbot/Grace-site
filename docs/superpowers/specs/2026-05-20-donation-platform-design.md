# Donation Platform — Design Spec
**Date:** 2026-05-20
**Project:** grace-site (Grace Evangelical Church)

---

## Summary

Integrate GiveButter as a native donation experience directly into the church website. The goal is to let visitors give without leaving the site, using GiveButter's embeddable widget styled to match the existing site design.

---

## What We're Building

Two things:

1. **"Give" nav button** — added to the top-right navigation, scrolls to the Give section
2. **Give section** — a new full-width section on the page (`#give`) with the GiveButter widget embedded inline

---

## Nav Button

- Insert as `<li class="give-wrap">` in `#navMenu`, positioned between the Contact `<li>` and the `lang-toggle-wrap` `<li>`
- The HTML element is missing — the CSS class `.give-btn` (lines 207–216) and the `.give-wrap` mobile override (line 1766) already exist and require no new CSS
- Element: `<a href="#give" class="give-btn">Give →</a>` inside the `<li>`
- Behavior: same-page anchor scroll to `#give` (site already has `scroll-padding-top: 90px` on `html` to clear the sticky header)
- Bilingual: `data-en="Give →"` / `data-ru="Пожертвовать →"`

---

## Give Section

### Placement
Inserted **after** `#rebuild` and **before** `#prayer` in the HTML. The Rebuild section provides emotional context (fire, ongoing construction) immediately before the giving opportunity.

### CSS Class Naming
Follows the existing site pattern:

```
.give              — section element
.give-inner        — centered content wrapper
.give-left         — left column (copy)
.give-widget       — right column (widget wrapper)
.give-widget-head  — dark header bar (our HTML, wraps GiveButter embed)
.give-widget-body  — embed container
.give-widget-foot  — small footer with lock icon + branding
```

### Background
Section background: `#ece3cf` (the same value as the page body background — note: `--page-bg` is not a defined CSS variable in this codebase; use the hex directly)

### Layout
- Desktop: two-column CSS grid, `1fr 1fr`, 64px gap, items centered vertically
- Padding: `80px 40px` (consistent with `.rebuild` and `.welcome` sections)
- Mobile (below 768px): single column, copy above widget, widget full width

---

## Left Column — Copy

```
Eyebrow:   GIVE   (same pattern as other sections — uppercase, forest green, flanked by 40px lines)
Heading:   Support the ministry.
Body:      Thank you for supporting Grace Church. Your gift sustains our efforts to serve others
           and care for everything that makes this church home.
Quote:     "Each of you should give what you have decided in your heart to give, not reluctantly
           or under compulsion, for God loves a cheerful giver."
           — 2 Corinthians 9:7
```

Scripture quote styling: reuse the `.rebuild-verse` approach — italic, gold left border (2px solid `var(--gold)`), padding-left 16px, `var(--earth)` text color.

All static copy uses `data-en` / `data-ru` attributes, processed by the existing `setLang()` function. The GiveButter widget itself is not translated.

---

## Right Column — GiveButter Widget

### DOM Structure

```html
<div class="give-widget">
  <!-- Our header — sits above the embed -->
  <div class="give-widget-head">
    <div class="give-widget-title">Grace Evangelical Church</div>  <!-- Fraunces serif -->
    <div class="give-widget-sub">All donations go directly to the church</div>
  </div>

  <!-- GiveButter embed renders here -->
  <div class="give-widget-body">
    [GiveButter embed placeholder — see below]
  </div>

  <!-- Our footer — sits below the embed -->
  <div class="give-widget-foot">
    [lock SVG] Secure &amp; encrypted · Powered by GiveButter
  </div>
</div>
```

### Header Styles
- Background: `var(--bark)` (#3d2f21)
- Title: Fraunces serif, 18px, weight 400, `var(--cream)`, letter-spacing -0.01em
- Subtitle: Inter, 11px, `var(--gold-soft)`, opacity 0.8

### Footer Styles
- Background: `var(--tan-bg)`
- Font: 9px, `var(--muted)`, opacity 0.5, letter-spacing 0.03em
- Lock SVG icon inline before text (10px wide)
- Intentionally very subtle — present for compliance, not prominence

### GiveButter Embed

**Campaign URL:** `https://givebutter.com/grace-slavic-church-rchpdv`
**Campaign slug:** `grace-slavic-church-rchpdv`

**Standard GiveButter inline embed:**
```html
<script src="https://givebutter.com/js/widget.js"></script>
<givebutter-widget id="grace-slavic-church-rchpdv"></givebutter-widget>
```

If the GiveButter dashboard provides a different snippet, use that. The custom element (`<givebutter-widget>`) is GiveButter's current format as of 2025.

**One fund:** General donation only — no fund selector needed.

---

## GiveButter Footer Branding

**Decision:** Keep "Powered by GiveButter" — styled very small and dimmed so it's present but unobtrusive.

Footer copy: `Secure & encrypted · Powered by GiveButter`
Style: 9px, `var(--muted)`, opacity 0.5 — compliance only, not a design element.

---

## Mobile Behavior

At ≤768px:
- Grid collapses to single column
- Copy (`.give-left`) appears first (above widget) — matches the pattern of `.prayer-section` on mobile
- Widget takes full width
- Nav "Give" button: already handled by the existing `.give-wrap` mobile CSS

---

## What's Not in Scope

- A modal/popup give experience
- Fund selector tabs
- Custom payment processing
- Recurring donation management UI
- Translation of the GiveButter widget UI
