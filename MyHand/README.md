# MyHand — Running the app

This repo contains the Swift source files for the app. You still need to create an Xcode project and add these files to a target.

## Prerequisites

- macOS with Xcode 15+
- iPad running iPadOS 17+ (Apple Pencil recommended)

## Setup in Xcode

1. Open Xcode and choose **File → New → Project…**.
2. Select **iOS → App**.
3. Product Name: **MyHand**.
4. Interface: **SwiftUI**. Language: **Swift**. Minimum iOS version: **17.0**.
5. Save the project in a separate folder (e.g., `MyHandProject`).

## Add the source files

1. In Finder, locate this repo’s `MyHand` folder.
2. In Xcode, right‑click the project navigator and choose **Add Files to “MyHand”…**.
3. Select all the `.swift` files under `MyHand/` and add them to the app target.
4. Make sure the files are included in your target’s **Target Membership**.

## Run

1. Connect your iPad (or use an iPad simulator for basic testing).
2. Select the iPad device in Xcode’s toolbar.
3. Click **Run** (▶︎).

## Notes

- The app entry point is `MyHandApp.swift`.
- Glyphs persist in the Application Support directory via `FileStorage`.
- Rendering/layout constants live in `HandwritingComposer`.
