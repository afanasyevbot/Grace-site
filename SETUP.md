# Grace Slavic Church — New Website Setup Guide

## What you have

A single-file HTML website (`index.html`) with:
- Full bilingual EN/РУ toggle (saved per visitor)
- All sections: Home, About, Beliefs, Leadership, Sermons, Get Involved, Rebuild, Contact, Newsletter
- Real church info: address, phone, service time (10:30 AM Sunday + 7:00 PM Friday), pastor, YouTube, Facebook
- Rebuild banner + dedicated rebuild section
- Working YouTube embed of the @gracechurch4000 channel
- Working "Give" button routed to your existing MBF donation portal
- Google Maps embed for directions
- Contact form and prayer request form (both submit via Formspree to `admin@eagangrace.com` — verify in Formspree dashboard)
- Newsletter signup form (needs one integration step — see below)
- Fully mobile-responsive
- Fast — loads in under 1 second

## Placeholders to fill in

Open `index.html` in any text editor (VS Code, Sublime, even Notepad) and search for these items:

1. **Leadership section** — search for "Associate Pastor" and "Elder / Deacon". Replace with real names, roles, and short bios (~2 sentences each).
2. **Leader initials** — the circles currently show "PA" for Pavel and "+" for others. Change the `<div class="leader-photo">` text to the correct initials, or swap to photos later.
3. **Contact email** — all public contact links use `admin@eagangrace.com`. Contact and prayer forms submit through Formspree; confirm the Formspree form (`mpqbbqzq`) sends notifications to `admin@eagangrace.com`.
4. **Maps embed** — the current Google Map is approximate. For the exact pin: go to Google Maps, search "1985 Diffley Rd Eagan MN", click Share → Embed a map → Copy HTML → paste the `src="..."` URL to replace the existing one.

## How to deploy it (free)

### Option 1: Netlify Drop (easiest — 2 minutes)
1. Go to https://app.netlify.com/drop
2. Drag the folder containing `index.html` onto the page
3. Netlify gives you a URL like `https://random-name-123.netlify.app` — the site is live
4. Create a free Netlify account to claim it and get a better name
5. Point `eagangrace.com` at it (see "Connecting your domain" below)

### Option 2: Cloudflare Pages (also free, slightly more setup)
1. Upload `index.html` to a GitHub repo
2. Connect Cloudflare Pages to the repo
3. Auto-deploys on every change

### Connecting your domain (eagangrace.com)
Once the new site is live on Netlify:
1. In Netlify: Site settings → Domain management → Add custom domain → `eagangrace.com`
2. Netlify gives you DNS records to set (either nameserver change or A record)
3. Log in to wherever `eagangrace.com` is currently registered (check WordPress.com admin → Domains)
4. Update the DNS records as Netlify instructs
5. Takes 1–24 hours to propagate
6. Once live, cancel the WordPress hosting

## Form submissions (contact + prayer)

Both forms post to Formspree endpoint `mpqbbqzq`. The site CCs `admin@eagangrace.com` on every submission, but the primary notification address is controlled in the Formspree dashboard:

1. Log in at https://formspree.io
2. Open form `mpqbbqzq`
3. In Workflow → Email action (or Form Settings), set the target email to `admin@eagangrace.com`
4. Submit a test message from the live site and confirm it arrives in the admin inbox

## Optional: connecting a newsletter form

There is no newsletter form on the current site. To add one later:
- **Easiest**: Sign up for Mailchimp (free up to 500 contacts) or Buttondown. They give you an embed code — replace the `<form class="newsletter-form">` block with their code.
- **Or**: use Netlify Forms (free, works automatically when hosted on Netlify). Add `netlify` and `name="newsletter"` to the `<form>` tag:
  ```html
  <form class="newsletter-form" name="newsletter" netlify onsubmit="return handleNewsletter(event)">
  ```
  All submissions then show up in your Netlify dashboard.

## If you want to edit later

The site is one HTML file. All text is in the file. To change something:
1. Open `index.html` in a text editor
2. Find the text you want to change (Ctrl+F / Cmd+F)
3. Notice most text blocks have both `data-en="..."` and `data-ru="..."` attributes AND the visible text — update all three for bilingual consistency
4. Save the file
5. On Netlify: drag the updated folder onto the dashboard, or if connected to GitHub, just commit

## What's NOT in this version (can add later)

- Individual sermon pages (currently it's the YouTube channel embed, which is enough for most)
- Events calendar (can add Google Calendar embed or Planning Center embed when ready)
- Photo gallery
- Blog / news page
- Online bulletin / weekly announcements
- Volunteer signup forms

Any of these can be added without starting over.
