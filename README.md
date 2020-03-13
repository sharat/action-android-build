# Android Build docker action

This action provides a workaround to fix the issues with NDK dependencies in the code where the ubuntu runner comes with NDK 21.x but your code might need 20.x.
This image provides both 21 and 20 side by side.

This is not recommended for regular builds. Use starter workflows suggested by GitHub

## Example usage
```yaml
name: Android Build
uses: sharat/action-android-build
with:
  args: './gradlew assembleDebug'
```