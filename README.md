# Medivise 🩺

Medivise is a mobile app designed to tackle the growing challenge of polypharmacy, particularly among the elderly and those with multiple health conditions. 

## Links
- BE repository: [https://github.com/YesidLopezSierra/medivise](https://github.com/YesidLopezSierra/medivise)
- Swagger: http://34.29.156.157/docs
- Video demo: https://youtu.be/BcAlyUk3xZ0

## Features

- **Add Medications Easily**: Use your smartphone to snap a photo of your medication labels. Our OCR technology automatically extracts text and fills in medication details.
- **Check Drug-Drug Interactions**: Check for potential drug interactions within the app to ensure safety, whether you consult saved medications or enter new ones.
- **Monitor Food Interactions**: Get detailed information on how certain foods may interact with your medications to maintain an optimal diet that supports your treatment.
- **Automated Health Reports**: Generate detailed health reports in PDF format, including all your medication information. Share these with your doctor to enhance medical appointments.

## Setting Up the Project with Gemini API
To integrate the Gemini API in the iOS project:

### 1. Set Up Your API Key
- **Obtain an API Key**: Create an API key in Google AI Studio if you don't already have one.
- **Secure Your API Key**: Store your API key securely in a `GenerativeAI-Info.plist` file and exclude it from version control.


## Important
To locally run the iOS app and use the Gemini API, please add your API key in the file: https://github.com/YesidLopezSierra/medivise-ios/blob/main/GenerativeAI-Info.plist

## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

You need to have the following software installed on your machine:

- Xcode

You can download Xcode from the Mac App Store or from the [Apple Developer website](https://developer.apple.com/xcode/resources/).

### Clone the repository

Clone the repository to your local machine using Git:

```bash
git clone [https://github.com/YesidLopezSierra/medivise-ios.git](https://github.com/YesidLopezSierra/medivise-ios)
```

### Open in Xcode
Navigate to the project directory in Terminal.
Double click on the Medivise.xcodeproj file or open it directly from Xcode.

### Build and Run
Once the project is opened in Xcode, select your desired device or simulator from the target device menu.
Press the "Play" button or use the shortcut Cmd + R to build and run the project.
