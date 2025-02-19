# Winget Auto-Install Script with Administrative Privileges

# Function to ensure the script is running as Administrator
function Ensure-Admin {
    if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Output "Restarting script with administrative privileges..."
        Start-Process -FilePath "powershell.exe" -ArgumentList ("-NoProfile", "-ExecutionPolicy Bypass", "-File", "$PSCommandPath") -Verb RunAs
        exit
    }
}

# Ensure the script is running with administrative privileges
Ensure-Admin

# List of applications to install
$applications = @(
    "7zip.7zip",             		# 7-Zip
    "Foxit.FoxitReader",    		# Foxit Reader
    "Google.Chrome",       		  	# Google Chrome
    "Mozilla.Firefox",       		# Firefox
    "Cyanfish.NAPS2",           	# NAPS2 (Not Another PDF Scanner)
    "Notepad++.Notepad++",   		# Notepad++
    "Python.Python.3.13",    		# Python
    "qBittorrent.qBittorrent", 		# qBittorrent
    "Starship.Starship",     		# Starship prompt
	"Telegram.TelegramDesktop", 	# Telegram
	"Microsoft.VCRedist.2015+.x64", # Visual C++
	"Microsoft.VCRedist.2015+.x86", # Visual C++
    "Git.Git",               		# Git	
    "Gyan.FFmpeg"           		# FFmpeg
)

# Install each application
foreach ($app in $applications) {
    Write-Output "Installing $app..."
    winget install --id=$app --silent --accept-source-agreements --accept-package-agreements -e
    if ($?) {
        Write-Output "$app installed successfully."
    } else {
        Write-Output "Failed to install $app."
    }
}

Write-Output "All installations completed."

# Wait for user to press any key to exit
Write-Output "Press any key to exit..."
$x = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
