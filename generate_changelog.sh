# Set the version number (passed as an argument)
version_number=$1

# Create the CHANGELOG.md file
echo "# Changelog" >CHANGELOG.md
echo "" >>CHANGELOG.md
echo "All notable changes to this project will be documented in this file." >>CHANGELOG.md
echo "" >>CHANGELOG.md
echo "## [Unreleased]" >>CHANGELOG.md
echo "" >>CHANGELOG.md
echo "## [${version_number}] - $(date +'%Y-%m-%d')" >>CHANGELOG.md
echo "### Added" >>CHANGELOG.md
#! add new features here
echo "- Feature 1: Description of the new feature." >>CHANGELOG.md
echo "" >>CHANGELOG.md
echo "### Improved" >>CHANGELOG.md
# ! add improvements here
echo "- Improvement 1: Description of the improvement." >>CHANGELOG.md
echo "" >>CHANGELOG.md
echo "### Fixed" >>CHANGELOG.md
# ! add bug fixes here
echo "- Bug fix 1: Description of the bug fix." >>CHANGELOG.md
echo "- Bug fix 2: Description of the second bug fix." >>CHANGELOG.md
echo "" >>CHANGELOG.md
echo "### Download" >>CHANGELOG.md
echo "- [Download for Android](https://github.com/alhosainy/writey/releases/download/v${version_number}/app-arm64-v8a-release.apk)" >>CHANGELOG.md
echo "- [Download for Windows](https://github.com/alhosainy/writey/releases/download/v${version_number}/writey.rar)" >>CHANGELOG.md
echo "- [Web Version](https://alhosainy.github.io/writey/)" >>CHANGELOG.md
echo "" >>CHANGELOG.md
echo "[Unreleased]: #Unreleased" >>CHANGELOG.md
echo "[${version_number}]: #${version_number}" >>CHANGELOG.md
