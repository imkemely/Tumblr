# Project 5 - *Tumblr Feed*

Submitted by: **Kemely Alfonso Martinez**

**Tumblr Feed** is an app that displays a scrollable feed of blog posts from the "Humans of New York" Tumblr blog, featuring images and story summaries in a clean, user-friendly interface.

Time spent: **6** hours spent in total

## Required Features

The following **required** functionality is completed:

- [x] App has a configured table view and table view cell
- [x] App populates the table view with data fetched from an API

## Optional Features

The following **optional** features are implemented:

- [ ] App fetches posts from a different Tumblr blog
- [ ] App has a refresh control to update the table view

## Additional Features

The following **additional** features are implemented:

- [x] Custom programmatic table view cell with Auto Layout constraints
- [x] Professional UI design with rounded image corners
- [x] Proper image aspect ratio handling with content mode
- [x] Error handling for network requests and missing data
- [x] Memory-efficient image loading using NukeExtensions
- [x] Cell reuse optimization for smooth scrolling
- [x] Safe area layout support for modern iPhone designs
- [x] Clean separation of concerns with custom cell class

## Video Walkthrough

Here's a walkthrough of implemented user stories:

(https://youtube.com/shorts/yA2NGOXtYzw?feature=share)

The video demonstrates:
- App launching and loading Tumblr posts
- Smooth scrolling through the feed
- Images loading asynchronously from the API
- Post summaries displaying properly
- Professional UI layout with images and text

## Notes

Describe any challenges encountered while building the app:

- **Initial Setup Challenges**: Encountered issues with table view outlet connections in Interface Builder, which caused runtime crashes. Solved by implementing the table view programmatically with Auto Layout constraints.

- **API Integration**: Had to debug the proper import statements for the Nuke image loading library, switching from `import Nuke` to `import NukeExtensions` to access the correct image loading methods.

- **Scrolling Issues**: Initially had problems with table view scrolling due to incorrect frame-based layout. Fixed by implementing proper Auto Layout constraints with safe area guides.

- **Cell Layout**: Learned to create custom table view cells programmatically, implementing proper Auto Layout constraints for image and label positioning.

- **Memory Management**: Implemented proper cell reuse patterns and image cleanup in `prepareForReuse()` to prevent memory leaks and display issues.

## License

    Copyright 2025 Kemely Alfonso Martinez

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
