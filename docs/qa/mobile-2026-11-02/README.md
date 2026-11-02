# Mobile and responsive QA — November 2, 2026

PR #9, `fix/mobile-polish-20261102`. Starting head: `bed867933dd1b6c809ef21624186d2e8cdf05e3a`; main baseline: `64ee2454f50166a6bd869fa7a5a2ddf54947e64b`.

Tested `index.html` SHA-256: `39207a4432e8df31ca8c360b875c87f97885bcea7be3ddaa0073a9eb4e2be779`.

## Result and changes

The phone hero has distinct spacing for the church name, slogan, headline, buttons and verse. Prayer/contact forms, cards and footer fit narrow screens. Navigation collapses through 1400px; content breakpoints stay unchanged. Between 1401 and 1800px, the full logo carries the church wordmark and the horizontal menu uses a 16px gap. Wider screens retain the extra church-name text.

The original header squeezed the logo at 1165px to 51px in English and 0px in Russian with fallback fonts. With the intended font families, it squeezed to 21px/0px. Russian navigation extended beyond the viewport. The final logo is 93px wide in the collapsed header and 194px wide in the desktop header. Both languages fit at 1401px, 1440px, 1800px, 1801px and 1920px.

Additional phone tap areas now measure at least 44px in both dimensions, including secondary sermon links, contact email, footer, banner, giving fallback and back-to-top controls. Gallery controls are 48px. Browser hit testing exposed the photo intercepting close/previous/next taps on phones; adding a stacking level to the existing controls fixes it without changing gallery JavaScript.

## Browser checks

Playwright with installed Chromium, serving the repository on loopback. Full-page scroll and capture in each case, including lazy images and reveal-on-scroll content. Viewport height was 844px unless noted. Reduced motion was used for consistent captures; normal motion was tested separately.

| Width | English | Russian | Navigation |
| --- | --- | --- | --- |
| 320 | Pass | Pass | Collapsed |
| 375 | Pass | Pass | Collapsed |
| 390 | Pass | Pass | Collapsed |
| 430 | Pass | Pass | Collapsed |
| 768 | Pass | Pass | Collapsed |
| 960 | Pass | Pass | Collapsed |
| 1165 | Pass | Pass | Collapsed |
| 1440 | Pass | Pass | Horizontal |

The 16 cases passed with the site's fallback fonts and again with local Fontsource Inter/Fraunces fixtures. Actual element rectangles and document widths showed no horizontal overflow. At widths through 960px, all visible measured links, buttons, form fields and gallery tiles met 44px minimum dimensions. Desktop content section widths and heights matched main at 1440px in both languages.

At every matrix width, both languages passed form filling/focus, validity/reset checks and repeated gallery open/next/previous/Escape/close checks. Collapsed widths also passed three menu open/close cycles, aria-expanded/body-scroll-lock consistency, Escape/focus return, anchor closing/target clearance, scrolling to the last menu item, and resizing to desktop. Additional checks passed at 320×568 and 768×390, and on both sides of the 1400px and 1800px boundaries. A touch-emulated phone context passed menu taps. Normal hero animations completed and back-to-top returned to the top.

No uncaught page errors and no POST requests during interaction checks. Forms were never submitted. Long English/Russian sermon titles were rendered through the existing renderer using local test data to check both populated table and featured-card layouts at all eight widths; no production feed data was changed.

## Preservation

An HTML parser comparison against main confirmed all text and HTML attributes are unchanged except the intended `aria-controls` addition. This includes all bilingual copy, service at 11 AM, Sunday school at 10 AM, Christmas Market December 19, 2026 at the church / Time TBD, links, form attributes, media references, integrations and SEO. Form submission, language replacement, sermon and gallery JavaScript are unchanged. Inline JavaScript syntax and `git diff --check` passed. Unrelated PR #6 is not included.

## Evidence

Full-page screenshots, at native viewport width, are linked below. JPEG copies keep repository size lower; lossless PNG originals and test scripts remain under `/workspace/scratch/grace-qa` in the selected execution environment.

| Width | English full page | Russian full page |
| --- | --- | --- |
| 320 | [EN](en-320-full.jpg) | [RU](ru-320-full.jpg) |
| 375 | [EN](en-375-full.jpg) | [RU](ru-375-full.jpg) |
| 390 | [EN](en-390-full.jpg) | [RU](ru-390-full.jpg) |
| 430 | [EN](en-430-full.jpg) | [RU](ru-430-full.jpg) |
| 768 | [EN](en-768-full.jpg) | [RU](ru-768-full.jpg) |
| 960 | [EN](en-960-full.jpg) | [RU](ru-960-full.jpg) |
| 1165 | [EN](en-1165-full.jpg) | [RU](ru-1165-full.jpg) |
| 1440 | [EN](en-1440-full.jpg) | [RU](ru-1440-full.jpg) |

Phone details: [EN hero 320](en-320-hero.png), [RU hero 320](ru-320-hero.png), [EN hero 390](en-390-hero.png), [RU hero 390](ru-390-hero.png), [EN menu](menu-en-390.png), [RU menu](menu-ru-390.png), [gallery controls](gallery-controls-320.png), [EN prayer](prayer-en-390.png), [RU prayer](prayer-ru-390.png), [EN contact](contact-en-390.png), [RU contact](contact-ru-390.png).

Machine-readable evidence: [layout measurements](layout.json), [interaction results](interactions.json), [desktop comparison and populated sermon fixtures](content-qa.json).

## Limits and next review

The selected environment's existing network policy blocks Google Fonts, the Google Maps embed, Givebutter, sermon feed/proxy endpoints and YouTube thumbnails (`ERR_TUNNEL_CONNECTION_FAILED`). No policy or security configuration was changed. Font-family coverage used local npm Fontsource fixtures solely in the browser test process; production font links remain unchanged. These fixtures are representative rather than a verification of the exact Google-hosted font revision. Russian headings retain their existing serif fallback for Cyrillic.

Live widget rendering and third-party network behavior are therefore unverified. The existing giving fallback and sermon failure state were checked; populated sermons were checked with fixtures. Existing Russian prayer placeholders and a sermon failure message that can retain the initial language are unchanged. Form delivery was intentionally not tested. Chromium viewport/touch emulation does not establish physical-device Safari or safe-area behavior.

Keep PR #9 as a draft for review. No merge, Hostinger upload or explicit production deployment was performed.
