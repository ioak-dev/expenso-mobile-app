# Pulse

A new Flutter project.

---

## Prerequisites

1. **Flutter SDK**: Download and install Flutter SDK from the [official website](https://docs.flutter.dev/get-started/install).
2. **Android Studio**: Ensure Android Studio is installed on your system. [Download Android Studio](https://developer.android.com/studio).
3. **Dart and Flutter Plugins**: Install the required plugins in Android Studio.

---

## Steps to Set Up Flutter and Create a New Flutter Project

### Step 1: Download Flutter SDK

1. Download Flutter SDK from the [official website](https://docs.flutter.dev/get-started/install).
2. Extract the downloaded file to a suitable location, e.g., `C:\src\flutter` for Windows.
3. Add the Flutter directory to your system's **Environment Path**:
   - **Windows**: Add `flutter\bin` to the Path in System Environment Variables.

---

### Step 2: Download and Install Android Studio

1. Install **Android Studio** and complete the setup wizard to install required SDK tools.
2. Open Android Studio and verify the setup.

---

### Step 3: Install Flutter and Dart Plugins

1. Navigate to **File > Settings > Plugins** in Android Studio.
2. Search for and install the **Flutter** and **Dart** plugins.
3. Restart Android Studio to complete the installation.

---

### Step 4: Create a New Flutter Project

1. Open Android Studio.
2. On the welcome screen, select **"Create New Flutter Project"**.
3. Choose **Flutter Application** as the project type and click **Next**.
4. Enter the project details:
   - **Project Name**: Provide a name for your project (e.g., `pulse`).
   - **Flutter SDK Path**: Set the Flutter SDK path if it is not auto-detected.
   - **Project Location**: Choose a location to save the project.
5. Configure the project settings as needed and click **Finish**.

---

### Step 5: Set Up an Emulator in Android Studio

1. Open **Device Manager** in Android Studio.
2. Add a new virtual device:
   - Choose a device type.
   - Select and download the desired system image.
3. Start the emulator and ensure it runs correctly.

---

### Step 6: Run the Flutter Application

1. In Android Studio, select the emulator or a connected physical device from the device dropdown.
2. Click the **Run** button (green play icon) in the toolbar.
3. The Flutter application will build and launch on the selected device.

---

## Additional Notes

- **Hot Reload**: Use `Ctrl + R` (Windows) or `Command + R` (Mac) for quick reloads during development.
- **Flutter Doctor**: Run `flutter doctor` in your terminal to verify that all dependencies are correctly installed.

---

## Troubleshooting

1. **Flutter SDK Not Found**: Ensure the Flutter SDK path is correctly set under **File > Settings > Languages & Frameworks > Flutter**.
2. **Emulator Issues**:
   - Verify that required emulator images are downloaded in the **Device Manager**.
   - Restart the emulator or recreate it if issues persist.

---

## Conclusion

You have successfully set up Flutter and created your first Flutter project in Android Studio. Happy coding! 🎉
