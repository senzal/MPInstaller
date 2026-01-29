# BlishHUD Marker Pack Installer

A simple, automated installer for BlishHUD/TacO marker packs for Guild Wars 2. This tool makes it easy to distribute custom marker packs to users with a one-click installation process.

## Features

- **Automatic Detection**: Finds BlishHUD markers folder automatically
- **Zero Configuration**: Works out of the box for end users
- **Universal Compatibility**: Works with any TacO/BlishHUD marker pack
- **Clear Feedback**: Provides detailed success/error messages
- **Safe**: Never overwrites user settings, only adds marker files

## For End Users (Installing a Marker Pack)

### Easy Method (Recommended)

1. Download the marker pack distribution zip
2. Extract all files to a folder
3. Double-click `INSTALL.bat`
4. Follow the on-screen instructions
5. Done!

### Alternative Method

1. Extract all files to a folder
2. Right-click `Install-MarkerPack.ps1`
3. Select "Run with PowerShell"
4. Follow the on-screen instructions

### Requirements

- Windows operating system
- BlishHUD installed and run at least once (to create the markers folder)
- PowerShell (built into Windows)

### Troubleshooting

**"Could not find BlishHUD markers folder"**
- Make sure BlishHUD is installed
- Launch BlishHUD at least once to create the markers folder
- Check that BlishHUD is installed in the standard location

**"No zip file found"**
- Make sure the marker pack `.zip` file is in the same folder as the installer scripts
- Only one `.zip` file should be in the folder

**Markers don't appear in-game**
- Launch Guild Wars 2 and BlishHUD
- Open the Pathing/Markers module in BlishHUD
- Enable the marker categories you want to use
- Try restarting BlishHUD if they still don't appear

## For Marker Pack Creators (Distributing Your Pack)

### Quick Start

1. **Download the installer files:**
   - `INSTALL.bat`
   - `Install-MarkerPack.ps1`

2. **Create your distribution package:**
   ```
   YourMarkerPack/
   ├── YourMarkerPack.zip       (your marker pack)
   ├── INSTALL.bat              (one-click installer)
   ├── Install-MarkerPack.ps1   (PowerShell script)
   └── README.txt               (optional: your custom instructions)
   ```

3. **Zip everything together** and distribute!

### Detailed Instructions

#### Step 1: Prepare Your Marker Pack

Your marker pack should be a `.zip` file containing:
- `.xml` marker files (TacO format)
- `.taco` files (optional)
- `Data/` folder (if your markers use custom textures/models)

Example structure inside your zip:
```
MyMarkerPack.zip
├── MyPack_WorldBosses.xml
├── MyPack_HeroPoints.xml
└── Data/
    └── (textures, models, etc.)
```

#### Step 2: Download Installer Files

Download these files from this repository:
- `INSTALL.bat` - Batch file launcher (easiest for users)
- `Install-MarkerPack.ps1` - PowerShell installer script

#### Step 3: Create Distribution Package

1. Create a new folder for your distribution
2. Copy your marker pack `.zip` file into it
3. Copy `INSTALL.bat` and `Install-MarkerPack.ps1` into the same folder
4. (Optional) Add a custom `README.txt` with specific instructions for your pack

**Important**: Only include ONE `.zip` file - the installer will automatically use the first `.zip` it finds.

#### Step 4: (Optional) Customize the README

Create a `README.txt` file tailored to your marker pack:

```txt
========================================
[Your Pack Name] - BlishHUD Marker Pack
========================================

INSTALLATION:
1. Double-click INSTALL.bat
2. Follow the instructions
3. Done!

INCLUDED MARKERS:
- [List your marker categories]
- [What they do]

USAGE:
[Specific instructions for your markers]

========================================
```

#### Step 5: Create Distribution Zip

Zip all files together:
```
MyMarkerPack-v1.0.zip
├── MyMarkerPack.zip
├── INSTALL.bat
├── Install-MarkerPack.ps1
└── README.txt (optional)
```

This is what you share with users!

### Handling Different Marker Pack Names

The installer is **completely agnostic** to marker pack names. It will:
- Find ANY `.zip` file in the same directory (auto-detect mode)
- Or use a specific zip file if configured in `INSTALL.bat`
- Work with any naming convention

**Examples that all work:**
- `MyMarkerPack.zip`
- `CustomMarkers_v3.zip`
- `gw2_markers_2024.zip`
- `WorldBosses.zip`

#### Auto-Detect Mode (Default)

Leave the installer as-is. It will automatically find and install the first `.zip` file in the folder.

#### Specify Exact Zip File

If you have multiple zip files or want to ensure a specific file is installed, edit `INSTALL.bat`:

1. Open `INSTALL.bat` in a text editor
2. Find the line: `SET MARKER_PACK_NAME=`
3. Change it to: `SET MARKER_PACK_NAME=YourPackName_v1.2.zip`
4. Save the file

Now when users run `INSTALL.bat`, it will install exactly that zip file.

**Example:**
```bat
SET MARKER_PACK_NAME=MyMarkerPack_v1.2.zip
```

This is useful for:
- Including multiple versions in your distribution
- Having a specific naming convention
- Providing different marker packs in one download

### Testing Your Distribution

Before sharing your marker pack:

1. **Test the installer:**
   - Extract your distribution zip to a test folder
   - Run `INSTALL.bat`
   - Verify it installs correctly

2. **Check the markers:**
   - Launch Guild Wars 2 and BlishHUD
   - Open Pathing/Markers module
   - Verify your markers appear and work correctly

3. **Test on a clean system** (if possible):
   - Have a friend test the installer
   - Make sure instructions are clear

### Distribution Methods

**GitHub Releases**: Create a repository and use releases
```bash
git tag v1.0
git push origin v1.0
# Create release and upload your distribution zip
```

**Direct Download**: Host on Google Drive, Dropbox, etc.

**Community Forums**: Share on GW2 communities (Reddit, Discord, forums)

## Technical Details

### What the Installer Does

1. Searches for a `.zip` file in the script directory
2. Detects BlishHUD markers folder in common locations:
   - `Documents\Guild Wars 2\addons\blishhud\markers`
   - `Documents\Guild Wars 2\addons\BlishHUD\markers`
   - `%APPDATA%\Blish HUD\markers`
3. Extracts the zip to a temporary folder
4. Copies all contents to the BlishHUD markers folder
5. Cleans up temporary files
6. Shows success message and next steps

### Security Note

The installer:
- Only copies files to the BlishHUD markers folder
- Never modifies system settings
- Never runs external executables
- Source code is fully visible and auditable

## License

This installer is provided as-is for the Guild Wars 2 community. Feel free to use, modify, and distribute it with your marker packs.

## Credits

Created for the Guild Wars 2 community to simplify marker pack distribution.

## Support

For issues with the installer, please open an issue on GitHub.

For issues with specific marker packs, contact the marker pack creator.

---

**Happy mapping!** 🗺️
