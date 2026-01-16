.PHONY: clean feature gen watch icons splash fix fmt lint test check apk ios android pod pod-update pod-clean help

# Default target: Run when you just type 'make'
help:
	@echo "--------------------------------------------------------------------------------"
	@echo "                           FLUTTER MAKEFILE HELP"
	@echo "--------------------------------------------------------------------------------"
	@echo "make clean     - Clean project and get dependencies"
	@echo "make check     - Run format, analyze, and test (Pre-commit)"
	@echo "make gen       - Run build_runner build (delete conflicting outputs)"
	@echo "make watch     - Run build_runner watch (delete conflicting outputs)"
	@echo "make feature   - Create a mason feature"
	@echo "make launcher  - Generate launcher icons"
	@echo "make splash    - Generate native splash screen"
	@echo "make pod       - Install iOS pods"
	@echo "make pod-clean - Nuke iOS Pods/Lockfile and reinstall (Fixes iOS issues)"
	@echo "make apk"
	@echo "make android"
	@echo "make ios"
	@echo "--------------------------------------------------------------------------------"

# --- Dependency Management ---
clean:
	@echo "Cleaning project..."
	flutter clean
	flutter pub get

# --- Code Generation (Build Runner) ---

gen:
	flutter pub run build_runner build --delete-conflicting-outputs

watch:
	flutter pub run build_runner watch --delete-conflicting-outputs

# --- Asset Generation ---

launcher:
	flutter pub run flutter_launcher_icons

splash:
	flutter pub run flutter_native_splash:create

# --- Quality Control ---

fmt:
	dart format .

fix:
	dart fix --apply

lint:
	flutter analyze

test:
	flutter test

# Run this before committing
check: fmt fix lint test

# --- iOS Helpers (Mac Only) ---

# Standard install
pod:
	cd ios && pod install

# Update repo and install
pod-update:
	cd ios && pod repo update && pod install

# The "Magic Fix" for iOS build errors
# Deletes Pods folder and Lockfile, then installs
pod-clean:
	rm -rf ios/Pods
	rm -f ios/Podfile.lock
	cd ios && pod install

# --- Builds ---

apk:
	flutter build apk --release

android:
	flutter build appbundle --release

ios:
	flutter build ipa --release