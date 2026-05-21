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

- Position: top-right of the nav, after the existing nav links
- Label: `Give →`
- Style: uses the existing `.give-btn` CSS class (already defined, `background: var(--bark)`, `color: var(--cream)`) — no new CSS needed
- Behavior: clicking scrolls to `#give` on the page (same-page anchor link)
- Bilingual: EN `Give →` / RU `Пожертвовать →`

---

## Give Section

### Layout
- Two-column grid on desktop (left: copy, right: widget), single column on mobile
- Background: `var(--page-bg)` — matches the rest of the page
- Padding: consistent with other sections (80px vertical)
- Section anchor: `id="give"`

### Left Column — Copy
- Eyebrow (uppercase, forest green, flanked by lines): `Give`
- Heading: `Support the ministry.`
- Body: `Thank you for supporting Grace Church. Your gift sustains our efforts to serve others and care for everything that makes this church home.`
- Scripture blockquote (gold left border, italic, earth tone):
  > "Each of you should give what you have decided in your heart to give, not reluctantly or under compulsion, for God loves a cheerful giver."
  > — 2 Corinthians 9:7

### Right Column — GiveButter Widget
The actual GiveButter embed goes here. The widget is styled to match the site:

**Widget header (bark brown background):**
- Title: `Grace Evangelical Church` — Fraunces serif, weight 400, cream color
- Subtitle: `All donations go directly to the church` — small, gold-soft, slightly dimmed

**Widget body:**
- Preset amounts: $25 / $50 / $100 (default selected) / $250
- Custom amount input field
- Frequency toggle: One-time (default) / Monthly
- Give Now button — full width, bark brown, cream text
- Payment method icons (SVG): Card, Bank, Apple Pay, Google Pay

**Widget footer:**
- Lock SVG icon + `Secure & encrypted · Powered by GiveButter`
- Small (10px), dimmed (opacity 0.65), tan background — present but unobtrusive

### Bilingual support
All static copy (eyebrow, heading, body, scripture reference) uses the existing `data-en` / `data-ru` pattern. The GiveButter widget itself is not translated (it's a third-party embed).

---

## GiveButter Integration

GiveButter provides an embeddable widget via a `<script>` tag + a `<div>` placeholder. The embed replaces our mocked-up widget UI at runtime.

- **Campaign:** `grace-slavic-church-rchpdv`
- **Embed type:** Inline widget (not a redirect, not a popup)
- **One fund:** General donation — no fund selector tabs
- **Script source:** GiveButter's CDN embed script

The mockup widget (amount buttons, frequency toggle, etc.) is purely for design preview — at implementation, GiveButter's actual embed renders inside the widget container. The header (`Grace Evangelical Church` + subtitle) and footer (lock icon + branding text) are our own HTML wrapped around the embed.

**Open question:** Whether GiveButter's free plan allows removal of their branding in the footer. If yes, the footer can be simplified to just `Secure & encrypted`. If no, keep as-is.

---

## Placement on the Page

The Give section is inserted **after the Rebuild section** and **before the Prayer Request section**. This ordering is intentional — the Rebuild context (fire, ongoing construction) provides emotional motivation right before the giving opportunity.

---

## Mobile

- Two-column grid collapses to single column
- Widget takes full width
- Nav "Give →" button remains visible (already handled by existing mobile nav CSS)

---

## What's Not in Scope

- A modal/popup give experience (decided against in favor of the inline section)
- Fund selector tabs (one general fund only)
- Custom payment processing (fully delegated to GiveButter)
- Recurring donation management UI (handled by GiveButter)
