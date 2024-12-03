## SPEAKERS

A SwiftUI application that demonstrates how to retrieve AI speakers via the LOVO Genny API. This app showcases the ability to produce AI-generated speakers, in locale specific languages, for use within
various contexts including corporate training, education, audiobooks, YouTube, podcasts, social media, IVR customer support, advertisements and more.

## Features

- Consumes the LOVO Genny API speakers endpoint.
- Real-time AI speaker associated voice generation and playback.
- Displays speaker Name, Gender, Age Range, Country, Language and Image.
- Levarages Image pre-fetching and Image caching to ensure a smooth and responsive user experience.
- Paginated scrolling.

## Prerequisites

- Xcode 16 or higher installed on your machine. This is necessary as the test cases use the Swift Testing framework introduced in this version.
- A free API key from the [LOVO Developer Dashboard](https://docs.genny.lovo.ai/reference/intro/getting-started)

## Setup Instructions

1. Clone the repository:
   ```sh
   git clone https://github.com/relliott2016/AI-Speaker-Generation.git

2. Obtain a free API key:
   
- Visit the [LOVO Developer Dashboard](https://docs.genny.lovo.ai/reference/intro/getting-started).

4. Configure the Xcode Project:
- Open the project in Xcode.
- Substitute the "LOVO_GENNY_API_KEY" placeholder value "ADD_LOVO_GENNY_API_KEY_HERE" with your API key in the Xcode LovoAISpeakers target Info tab.
- Modify the Xcode target LovoAISpeakers Signing & Capabilities tab to include your own team and Bundle Identifier (if you are running on your device).
   
5. Build and Run:
- Build and run the app in the simulator or on your device.

## Testing
- The test cases in this project use the Swift Testing framework, which is available in Xcode 16 or higher.

## License

This project is licensed under the MIT License - see the [MIT License](LICENSE) file for details.

## Screenshots

<img src="https://github.com/relliott2016/AI-Speaker-Generation/blob/master/Screenshots/List.png" width=30% height=30%> <img src="https://github.com/relliott2016/AI-Speaker-Generation/blob/master/Screenshots/Detail%20-%20Listen.png" width=30% height=30%> <img src="https://github.com/relliott2016/AI-Speaker-Generation/blob/master/Screenshots/Detail%20-%20Stop.png" width=30% height=30%>
