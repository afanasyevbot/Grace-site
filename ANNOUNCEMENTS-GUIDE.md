# How to update announcements on the website

The "News" section on the homepage pulls from a Google Doc. To update announcements, just edit the Doc — the site updates itself within about a minute.

## One-time setup (do this once)

### 1. Create the Google Doc

1. Go to https://docs.google.com/document/create
2. Title it "Grace Evangelical Church — Announcements" (or anything — the title isn't shown on the site)
3. Add a starter announcement so you can test. Example:

   ```
   Easter Sunday service
   Join us on April 20 at 10:30 AM for our special Easter service, followed by a
   potluck lunch. Bring a dish to share if you'd like.

   Mid-week prayer
   Wednesday, 6:30 PM in the active wing. Come pray for our church family and
   for those on our heart.

   Building update
   Construction on the east wing is progressing well. Thank you for your
   continued prayers as we rebuild.
   ```

### 2. Publish the Doc to the web

1. In the Doc: **File → Share → Publish to web**
2. Click **Publish** (confirm the dialog)
3. Copy the URL it gives you. It will look like:
   `https://docs.google.com/document/d/e/LONG_STRING_OF_CHARACTERS/pub`

### 3. Wire the URL into the site

1. Open `index.html` in a text editor
2. Search for: `GOOGLE_DOC_URL`
3. You'll find a line like: `const GOOGLE_DOC_URL = '';`
4. Paste your URL inside the single quotes:
   `const GOOGLE_DOC_URL = 'https://docs.google.com/document/d/e/YOUR_URL/pub';`
5. Save the file and re-upload to Netlify (or wherever you're hosting)

That's it. Setup is done once. From now on, just edit the Doc.

## Weekly updates (the easy part)

1. Open the Google Doc on your phone, iPad, or computer
2. Edit it — add new announcements at the top, remove old ones, change event dates
3. Save (Google Docs auto-saves)
4. Wait about a minute, refresh the website — your changes are live

**No re-uploading. No logins to the website. No HTML editing.** Just the Doc.

## Formatting tips

The site respects basic Google Doc formatting:

- **Headings** — use Google Docs heading styles (Heading 1, 2, 3). Heading 3 in italic gold looks especially nice for event titles.
- **Bold** — `**bold text**` or use Cmd+B / Ctrl+B
- **Lists** — bulleted and numbered lists render correctly
- **Links** — paste URLs and they'll become clickable
- **Horizontal lines** — Insert → Horizontal line. Useful for separating announcements.

## Sharing editing access

If multiple people should be able to update announcements:

1. In the Doc: **Share** button (top-right)
2. Add their Google email addresses
3. Give them "Editor" access
4. Anyone you share with can now update announcements

## What NOT to put here

- Personal prayer requests with names or medical details
- Confidential member information
- Anything with addresses, phone numbers, or emails of individual members
- Anything you wouldn't want a stranger to read

The Doc is **publicly readable** because it's published to the web. Keep sensitive info in a private space (group text, members-only email list, etc.).

## Troubleshooting

**Announcements show "Could not load announcements"**
- Check that the Doc is still published (File → Share → Publish to web → confirm)
- Check that `GOOGLE_DOC_URL` in `index.html` is the correct URL (ends in `/pub`, not the regular edit URL)

**Changes aren't showing up on the site**
- Google takes up to ~1 minute to publish changes. Wait and refresh.
- Try a hard refresh in your browser (Cmd+Shift+R or Ctrl+Shift+R)

**Formatting looks weird**
- Simpler is better. Plain paragraphs and headings work best. Avoid tables, images, or complex formatting.

## To turn announcements off temporarily

- Either delete all content from the Doc (site will show empty announcements area)
- Or unpublish the Doc (File → Share → Publish to web → Stop publishing)
- Or in `index.html`, change `GOOGLE_DOC_URL = 'https://...'` back to `GOOGLE_DOC_URL = ''` — the site will show "Announcements coming soon."
