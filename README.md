# LearnConnect-ios

## Getting Started

### Prerequisites

- Xcode
- CocoaPods or Swift Package Manager (SPM)
- SwiftLint
- Design file: <https://www.figma.com/design/eMU757gaTm6Gdv4hTBWFdG/Online-Learning-App-Design-(Community)?node-id=0-1&node-type=canvas&t=O5Ue7Pba2v4XDsp8-0>

### Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/your-repo/LearnConnect.git
    cd LearnConnect
    ```

2. Install dependencies:

    ```sh
    pod install
    ```

3. Open the project in Xcode:

    ```sh
    open LearnConnect.xcworkspace
    ```

### Configuration

Configure Firebase by setting the appropriate `GoogleService-Info.plist` file based on the build configuration. The script `.scripts/firebase.sh` handles this automatically.

### Build and Run

1. Select the appropriate scheme in Xcode.
2. Build and run the project using Xcode.

## Code Quality

This project uses SwiftLint for code quality and linting. The configuration is defined in `.swiftlint.yml` and `.swiftlint-ci.yml`.

### SwiftLint Configuration

- **Excluded Paths**:
  - Pods
  - Carthage
  - DerivedData
  - "*Tests"
  - .scripts
  - LearnConnect/Packages/Environments
  - LearnConnect/Packages/Resources
  - LearnConnect/Packages/Logger
  - LearnConnect/Packages/LDSStory

- **Disabled Rules**:
  - discarded_notification_center_observer
  - notification_center_detachment
  - unused_capture_list
  - inclusive_language

- **Analyzer Rules**:
  - unused_import

- **Opt-in Rules**:
  - array_init
  - attributes
  - closure_body_length
  - closure_end_indentation
  - closure_spacing
  - collection_alignment
  - convenience_type
  - direct_return
  - discouraged_object_literal
  - empty_collection_literal
  - empty_count
  - empty_string
  - enum_case_associated_values_count

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License.
