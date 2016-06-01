# KhanAcademyBadges-iOS
iOS App

The goal of this project is to create a a small iPhone application written in Objective-C that queries Khan Academy for a list of badges.

![Demo](https://github.com/sp71/KhanAcademyDemo/blob/master/demo.gif)

# Objective
- Build a small iPhone application that queries Khan Academy for a list of badges.
- The resulting badges are displayed in a UICollectionView.
- Image downloads are prioritized and dynamically loaded based upon the current visible cells shown
- This is a not a fully featured app.

# Services
- The application will interface with the Khan Academy API (http://api-explorer.khanacademy.org/group/api/v1/badges).
- Application does not use any third party services

# Requirements
Initial launch:
- The first screen should be a collection of all the badges
- Tapping any single badge should bring up a detail view for that badge
  - Preferably with a larger image and more verbose description.

# Specifications
- Language: Objective-C
- Development environment: Xcode 7.0 and above.
- Target: iOS 9.0 and above.
- Memory: Full ARC support.
- Interface Builder: XIBs and Storyboard are allowed.
