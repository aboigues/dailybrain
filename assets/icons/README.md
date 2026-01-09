# Icons

This directory contains SVG icons used throughout the app.

## Required Icons

### Navigation
- `home.svg` - Home tab icon
- `ranking.svg` - Ranking tab icon
- `profile.svg` - Profile tab icon
- `settings.svg` - Settings icon

### Quiz UI
- `timer.svg` - Timer icon
- `question.svg` - Question mark icon
- `check.svg` - Correct answer checkmark
- `cross.svg` - Wrong answer X

### Streak & Achievements
- `fire.svg` - Streak flame icon
- `trophy.svg` - Achievement trophy
- `medal_gold.svg` - 1st place medal
- `medal_silver.svg` - 2nd place medal
- `medal_bronze.svg` - 3rd place medal

### Ads & Rewards
- `ad_video.svg` - Rewarded video icon
- `reward.svg` - Reward icon

## Format Guidelines

- **Format**: SVG (vector, scalable)
- **Size**: Optimize SVG files, remove unnecessary metadata
- **Color**: Prefer single-color SVGs that can be tinted programmatically
- **Naming**: Use snake_case

## Design System Compliance

Icons should follow the design system color palette defined in `lib/core/constants/colors.dart`.

Use `flutter_svg` package to render SVG icons with proper theming support.
