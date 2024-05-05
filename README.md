# Medivise 🩺

Medivise is designed to tackle the growing challenge of polypharmacy, particularly among the elderly and those with multiple health conditions. 

## Important
To locally run the iOS app and use the Gemini API, please add your API key in the file: https://github.com/saradrada/medivise-ios/blob/main/GenerativeAI-Info.plist

## Features

- **Add Medications Easily**: Use your smartphone to snap a photo of your medication labels. Our OCR technology automatically extracts text and fills in medication details.
- **Check Drug-Drug Interactions**: Check for potential drug interactions within the app to ensure safety, whether you consult saved medications or enter new ones.
- **Monitor Food Interactions**: Get detailed information on how certain foods may interact with your medications to maintain an optimal diet that supports your treatment.
- **Automated Health Reports**: Generate detailed health reports in PDF format, including all your medication information. Share these with your doctor to enhance medical appointments.

## How We Built It
Medivise was developed for a hackathon using a blend of advanced technologies:
- **Backend**: MongoDB hosted on Google Kubernetes Engine (GKE) for scalable, secure data management. Find the BE repository here: https://github.com/yesid-lopez/medivise
- **Drug Information Retrieval**: Integration with the Gemini API and Zilliz's Vector DB, leveraging a Retrieval-Augmented Generation (RAG) model.
- **Frontend**: Developed with Swift, focusing on an intuitive interface for easy navigation by older adults.
- **API Services**: FastAPI for responsive, asynchronous API services connecting the mobile interface with the backend.

## Setting Up the Project with Gemini API
To integrate the Gemini API in your iOS application, follow these steps:

### 1. Set Up Your API Key
- **Obtain an API Key**: Create an API key in Google AI Studio if you don't already have one.
- **Secure Your API Key**: Store your API key securely in a `GenerativeAI-Info.plist` file and exclude it from version control.
# medivise-ios
