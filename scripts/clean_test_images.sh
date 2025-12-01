#!/bin/bash
set -e

echo "🧹 Cleaning up ALL test images (goldens & failures)..."

# Clear failures
find test -name "failures" -type d -exec rm -rf {} +
echo "✅ Failures removed."

# Clear goldens
find test -name "goldens" -type d -exec rm -rf {} +
echo "✅ Goldens removed."

echo "✨ Cleanup complete. Run 'flutter test --update-goldens' to regenerate baseline images."