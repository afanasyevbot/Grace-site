# Grace Evangelical Church — Website

A modern, responsive, bilingual (EN/РУ) website for Grace Evangelical Church, Eagan MN.

## Files

- `index.html` — the entire site, single file. All HTML, CSS, and JS in one document for easy deployment.
- `logo-full.svg` — full logo lockup (heart + Grace wordmark + cross + subtext). Use in letterheads, printed materials, About pages.
- `logo-compact.svg` — same mark without subtext. For headers, tight spaces.
- `logo-single-color.svg` — cream single-color version for dark backgrounds or single-ink printing.
- `favicon.svg` — heart + cross pair. Used as the browser tab icon. Already wired into `index.html`.

## Design system

### Colors (defined as CSS variables at the top of the `<style>` block in index.html)

- `--bark` `#3d2f21` — primary dark brown
- `--bark-soft` `#5a4736` — softer brown
- `--sage` `#7d8a6a` — muted green accent
- `--sage-soft` `#a8b197` — light sage
- `--sage-bg` `#e8ebe0` — pale sage background
- `--cream` `#f5f1e8` — primary light background
- `--ivory` `#faf7ef` — lightest background
- `--gold` `#b89968` — accent gold (used sparingly)
- `--gold-soft` `#d4b98a` — lighter gold
- `--ink` `#2a2117` — body text
- `--muted` `#7a6b5a` — muted text

### Typography

- **Fraunces** (serif, Google Fonts) — headings, display text, emphasis
- **Inter** (sans, Google Fonts) — body, UI, navigation
- Both loaded from Google Fonts in the `<head>`

### Layout

- Single-page site with anchor-link sections
- All sections full-width, most content inside a `max-width: 1200px` container
- Mobile breakpoints at 960px and 700px

## Section order

1. Rebuild banner (top)
2. Header (sticky)
3. Hero — "Centered around Christ" with animated orb
4. Service strip (dark bark)
5. Welcome / mission
6. Beliefs (dark bark) — 6 creedal articles
7. Leadership — Pastor + 3 deacons
8. Sermons — auto-loads from YouTube @gracechurch4000 RSS
9. Get Involved — Small Groups hero + 5 ministry cards
10. Rebuild (dark bark) — Romans 8:28
11. Contact — form + map
12. Newsletter
13. Footer (dark bark)

## Dynamic features

- **Bilingual toggle** — every piece of text has `data-en` and `data-ru` attributes. Toggling the EN/РУ button swaps the display. Language preference is saved in localStorage.
- **Sermon table** — auto-populates from YouTube channel `@gracechurch4000` via RSS (through `api.allorigins.win` CORS proxy). No manual updates needed.
- **Hero animations** — staggered fade-ins, breathing orb. Respects `prefers-reduced-motion`.

## What's still placeholder / pending

1. **Deacon bios** — search for "Bio to be added." (3 occurrences in the Leadership section)
2. **Leader headshots** — currently showing initials (PA, SK, AA, VB). Replace `.leader-photo` divs with `<img>` tags pointing to photos when available.
3. **Church email address** — search for `info@eagangrace.com` (used in the contact form). Confirm or update.
4. **Google Maps embed** — the `<iframe src="...">` in the Contact section uses an approximate pin. To get exact: Google Maps → search "1985 Diffley Rd Eagan MN" → Share → Embed a map → copy HTML → replace existing iframe src.
5. **Giving platform** — currently still points at the legacy MBF donation link. Pending leadership decision on Tithely vs. keeping MBF.
6. **Newsletter signup** — form currently shows a success message only. To make real: add `netlify` and `name="newsletter"` attributes to the `<form>` tag (if hosting on Netlify), or swap in Mailchimp/Buttondown embed code.
7. **Contact form** — opens visitor's email client on submit. To capture real submissions: add `netlify` and `name="contact"` to the `<form>` tag.

## Editing text

All user-facing text is in the HTML as plain strings with `data-en` and `data-ru` attributes. Example:

```html
<h2 data-en="We exist to glorify Christ" data-ru="Мы существуем, чтобы прославлять Христа">We exist to glorify Christ</h2>
```

To change the English, update both `data-en="..."` AND the visible text between the tags. To change Russian, update `data-ru="..."`. They should match.

## Deployment

### Easy path: Netlify Drop

1. Go to https://app.netlify.com/drop
2. Drag the entire site folder onto the page
3. Netlify gives you a URL like `https://grace-church.netlify.app`
4. Create a free account to claim it
5. Point `eagangrace.com` at it via DNS

### Connecting the existing domain

1. In Netlify: Site settings → Domain management → Add custom domain → `eagangrace.com`
2. Follow Netlify's DNS instructions (either nameserver change at your registrar, or A/CNAME records)
3. Takes a few hours to propagate
4. Once live, cancel the WordPress hosting

## Browser support

- Modern browsers (Chrome, Safari, Firefox, Edge — last 2 versions)
- Mobile iOS Safari, Android Chrome
- SVG logos and favicon work in all modern browsers; for IE11 or older browsers a PNG fallback would be needed (not included)

## Performance

- Loads under 1 second on fast connections
- No build step, no framework dependencies
- External resources: Google Fonts (Fraunces, Inter), YouTube RSS (via proxy)
- Fully static — no backend server required

## Accessibility

- Semantic HTML, proper heading hierarchy
- Alt text on informational images
- `aria-hidden` on decorative SVG
- Respects `prefers-reduced-motion`
- Color contrast meets WCAG AA on all text

## Known limitations

- YouTube RSS feed is fetched through `api.allorigins.win` (free CORS proxy). If that service is down, the sermon table shows a fallback message but the rest of the site works fine.
- No CMS — content edits require opening the HTML file and updating text directly (or using the bilingual attributes).
- Forms are frontend-only placeholders; need Netlify Forms or similar to actually capture submissions.
