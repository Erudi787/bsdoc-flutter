@echo off
"C:\\Users\\Elwison Denampo\\AppData\\Local\\Android\\Sdk\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HC:\\Users\\Elwison Denampo\\Documents\\GitHub\\flutter\\packages\\flutter_tools\\gradle\\src\\main\\scripts" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=21" ^
  "-DANDROID_PLATFORM=android-21" ^
  "-DANDROID_ABI=x86" ^
  "-DCMAKE_ANDROID_ARCH_ABI=x86" ^
  "-DANDROID_NDK=C:\\Users\\Elwison Denampo\\AppData\\Local\\Android\\Sdk\\ndk\\26.3.11579264" ^
  "-DCMAKE_ANDROID_NDK=C:\\Users\\Elwison Denampo\\AppData\\Local\\Android\\Sdk\\ndk\\26.3.11579264" ^
  "-DCMAKE_TOOLCHAIN_FILE=C:\\Users\\Elwison Denampo\\AppData\\Local\\Android\\Sdk\\ndk\\26.3.11579264\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=C:\\Users\\Elwison Denampo\\AppData\\Local\\Android\\Sdk\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=C:\\flutter_projects\\bsdoc_flutter\\flutter_app\\build\\app\\intermediates\\cxx\\Debug\\4c406i3c\\obj\\x86" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=C:\\flutter_projects\\bsdoc_flutter\\flutter_app\\build\\app\\intermediates\\cxx\\Debug\\4c406i3c\\obj\\x86" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-BC:\\flutter_projects\\bsdoc_flutter\\flutter_app\\build\\.cxx\\Debug\\4c406i3c\\x86" ^
  -GNinja ^
  -Wno-dev ^
  --no-warn-unused-cli
