
# LearnConnect

LearnConnect is a modern video-based education platform that allows users to register for courses, manage their profiles, and watch course videos. It is designed with modern software architecture and optimized for performance and user experience.

## Features

- **User Management**:
  - User registration and login with email and password.
  - User profile viewing.

- **Course Management**:
  - Listing available courses.
  - Enrolling users in courses.

- **Video Player**:
  - Watching videos of enrolled courses.
  - Local saving of video progress for seamless playback.

- **Dark Mode Support**:
  - Toggle dark mode for a better viewing experience.

---

## Architecture and Technologies

The project is developed using modern development practices:

- **Platform**:
  - iOS: Swift
  - Android: Kotlin
- **Architecture**: MVVM (Model-View-ViewModel)
- **Database**: CoreData (for offline video progress and data management)
- **Testing**: Unit tests for critical functionalities
- **Backend Integration**:

    **Firebase services for:**
  - Authentication

    **Supabase for:**
  - Real-time database
  - Cloud messaging
  - Crashlytics for error reporting

---

## Setup and Installation

### Prerequisites

1. Install [Xcode](https://developer.apple.com/xcode/) (for iOS) or Android Studio (for Android).
2. Ensure you have the latest version of Swift (for iOS) or Kotlin (for Android).
3. Install Firebase CLI for backend configuration.

### Steps

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/learnconnect.git
   cd learnconnect
   ```

2. Install dependencies:
   - **iOS**:

    You should need to download swiftgen form brew and run the following command

    ```bash
    cd LearnConnect/LearnConnect/PackagesSPM/Resources
    swift package --allow-writing-to-package-directory generate-code-for-resources
    ```

3. Configure Firebase:
   - Add the respective `GoogleService-Info.plist` (iOS) or `google-services.json` (Android) files into the project as per the environment (Dev, Beta, Production).

---

## Performance Optimization

- Video loading times are optimized to be under 2 seconds.
- Offline data management ensures smooth operation in limited connectivity.

---

## Testing

Unit tests are implemented for critical functionalities:

- **Authentication**: Verifies secure user login and registration.
- **Course Enrollment**: Tests the user flow for enrolling in courses.

To run the tests:

```bash
xcodebuild test -scheme LearnConnectTests
```

---

## Design

The app's design is based on the [Figma community file](https://www.figma.com/design/eMU757gaTm6Gdv4hTBWFdG/Online-Learning-App-Design-(Community)).

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
