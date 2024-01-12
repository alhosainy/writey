# Set the version number (passed as an argument)
version_number=$1

# Create the changelog.md file
echo "# Changelog" >changelog.md
echo "" >>changelog.md
echo "All notable changes to this project will be documented in this file." >>changelog.md
echo "" >>changelog.md
echo "## [Unreleased]" >>changelog.md
echo "" >>changelog.md
echo "## [${version_number}] - $(date +'%Y-%m-%d')" >>changelog.md
echo "### Added" >>changelog.md
#! add new features here
echo "- Feature 1: Description of the new feature." >>changelog.md
echo "" >>changelog.md
echo "### Improved" >>changelog.md
# ! add improvements here
echo "- Improvement 1: Description of the improvement." >>changelog.md
echo "" >>changelog.md
echo "### Fixed" >>changelog.md
# ! add bug fixes here
echo "- Bug fix 1: Description of the bug fix." >>changelog.md
echo "- Bug fix 2: Description of the second bug fix." >>changelog.md
echo "" >>changelog.md
echo "### Download" >>changelog.md
echo "- [Download for Android](https://github.com/alhosainy/writey/releases/download/v${version_number}/app-arm64-v8a-release.apk)" >>changelog.md
echo "- [Download for Windows](https://github.com/alhosainy/writey/releases/download/v${version_number}/writey.rar)" >>changelog.md
echo "- [Web Version](https://alhosainy.github.io/writey/)" >>changelog.md
echo "" >>changelog.md
echo "[Unreleased]: #Unreleased" >>changelog.md
echo "[${version_number}]: #${version_number}" >>changelog.md
