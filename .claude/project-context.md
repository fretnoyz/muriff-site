# Muriff Site - Project Context

## Overview
Simple static HTML site for the "Muriff" Hornless Hereford Jazz Band. Hosted on GitHub Pages at www.muriff.com.

## Tech Stack
- Pure HTML (no build process)
- Tailwind CSS via CDN
- JavaScript for random band member selection
- Deployed via GitHub Pages from `main` branch

## Version Management
**IMPORTANT**: Always bump version before committing changes!

```bash
# Auto-detect version bump level from changes
./bump-version.sh auto

# Or manually specify
./bump-version.sh patch   # Bug fixes
./bump-version.sh minor   # New features
./bump-version.sh major   # Breaking changes
```

The script updates version footers in both `index.html` and `wwsd.html`.

## Development Workflow
1. Create feature branch (name: `claude/description-<session-id>`)
2. Make changes
3. Run `./bump-version.sh auto` (or specify bump type)
4. Commit with descriptive message
5. Push to feature branch
6. Create PR and merge to `main`
7. GitHub Pages auto-deploys from `main`

## Project Structure
```
.
├── index.html           # Main page - random band member feature
├── wwsd.html           # Square dance event page
├── images/             # Band member portraits and graphics
├── bump-version.sh     # Version management script
└── CNAME              # Custom domain config
```

## Style Guidelines
- Use Tailwind utility classes (not custom CSS)
- Custom colors defined in Tailwind config:
  - `muriff-bg`: #f9f1e7 (cream background)
  - `muriff-text`: #3b2f2f (dark brown text)
  - `muriff-secondary`: #775f4e (brown accent)
- Keep footer versions subtle (text-xs, gray-400)
- Maintain playful, quirky tone in content

## Common Tasks

### Add a new band member
Edit `index.html` bandMembers array, add image to `/images/`

### Update event details
Edit `wwsd.html` event section

### Change color scheme
Update Tailwind config in `index.html` head section

## Notes
- No build process - direct HTML editing
- Always test at www.muriff.com after merge
- Version number in footer confirms deployment
- Site uses responsive design (viewport meta tag)
