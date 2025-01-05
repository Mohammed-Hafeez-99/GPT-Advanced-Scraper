+# Linux Installation Guide
+
+## Prerequisites
+
+- Debian-based Linux distribution (Ubuntu, Debian, etc.)
+- sudo privileges
+- Internet connection
+
+## Installation Steps
+
+1. Grant execution permission to the script:
+   ```bash
+   chmod +x run-for-linux.sh
+   ```
+
+2. Run the script:
+   ```bash
+   ./run-for-linux.sh
+   ```
+
+## What the Script Does
+
+- Updates package list
+- Installs Google Chrome (if not present)
+- Installs Python 3 and pip
+- Installs required Python packages
+- Runs the application
+
+## Troubleshooting
+
+If you encounter permission denied errors, ensure you've granted execution permission to the script using the command above.
