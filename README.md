# notification_system with Flutter & nodeJS

CYCU IM 1121 服務導向架構與計算 final project

## 執行
```bash
cd projectName/
flutter run
```

## Flutter 專案移動後的操作步驟：
1. **Flutter 專案移動：** 將整個 Flutter 專案文件夾複製到新位置。
2. **Flutter 相關命令：** 在新位置下，打開終端或命令提示字元。
3. **Flutter 清除和重建：** 在終端中執行以下指令：
    
    ```bash
    flutter clean
    flutter pub get
    ```
    
    - **`flutter clean`**：這個指令會清除 **`build`** 目錄和其他暫存文件。
    - **`flutter pub get`**：這個指令會確保重新下載所有專案所需的依賴套件。
4. **重新建構程式：** 在移動後的專案位置，使用 **`flutter run`** 或其他相應的指令重新建構並運行程式。
   
## Android Studio 安裝環境注意事項
1. Tools > SDK Manager
2. 左側選單 android SDK > 中上選項 SDK tools > 中間清單 android SDK (command -line tools) install > apply

## 若要調整 Compile Sdk Version & Jdk
1. File > Project Structure
2. Modules > Properties
3. 選擇你要的 Compile Sdk Version
4. 選擇你要的 Source Compatibility （如：$JavaVersion.VERSION_17 : 17(Java17)）

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
