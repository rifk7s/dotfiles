#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

log_info "Auditing manual application installations..."

# Helper function to check if an app is installed
check_app() {
    local app_name="$1"
    local source_hint="$2"
    
    if [[ -d "/Applications/${app_name}.app" ]] || [[ -d "${HOME}/Applications/${app_name}.app" ]] || [[ -d "/System/Applications/${app_name}.app" ]]; then
        printf "  %s[OK] %s%s (Installed)\n" "${GREEN}" "${app_name}" "${RESET}"
    else
        printf "  %s[  ] %s%s %s\n" "${YELLOW}" "${app_name}" "${RESET}" "-> ${source_hint}"
    fi
}

echo ""
printf "%s%s======================================================================%s\n" "${YELLOW}" "${BOLD}" "${RESET}"
printf "%s%s          APP STORE & MANUAL DOWNLOAD CHECKLIST                       %s\n" "${YELLOW}" "${BOLD}" "${RESET}"
printf "%s%s======================================================================%s\n" "${YELLOW}" "${BOLD}" "${RESET}"
echo "Your automated Homebrew configuration is successfully deployed."
echo "Here is the status of your remaining manual installations:"
echo ""

printf "%s%s[ MAC APP STORE ] (Manual Download):%s\n" "${BLUE}" "${BOLD}" "${RESET}"
check_app "WhatsApp" "Download from App Store"
check_app "Keeby" "Download from App Store"
check_app "Speedtest" "Download from App Store"
check_app "CleanMyKeyboard" "Download from App Store (or Web)"
check_app "Xcode" "Download from App Store (Optional)"
check_app "Keynote" "Download from App Store (Optional)"
echo ""

printf "%s%s[ MANUAL WEB DOWNLOADS (Core) ]:%s\n" "${BLUE}" "${BOLD}" "${RESET}"
check_app "Visual Studio Code" "Download from official site"
check_app "Zed" "Download from official site"
check_app "Figma" "Download from official site"
check_app "Dia" "Download Dia Browser from official site"
check_app "Discord" "Download from official site"
check_app "Telegram" "Download from official site"
check_app "zoom.us" "Download from official site"
check_app "Spotify" "Download from official site"
check_app "ChatGPT" "Download from OpenAI"
check_app "Claude" "Download from Anthropic"
check_app "logioptionsplus" "Download from Logitech (Logi Options+)"
check_app "Roblox" "Download from official site"
echo ""

printf "%s%s[ OPTIONAL / LARGE APPS ]:%s\n" "${BLUE}" "${BOLD}" "${RESET}"
check_app "Android Studio" "Download via Google Developer (Heavy)"
check_app "LM Studio" "Download from official site"
check_app "Wireshark" "Download from official site (Optional)"
check_app "VMware Fusion" "Download from Broadcom (Optional)"
check_app "Cisco Packet Tracer 9.0.0" "Download via NetAcad Login"
echo ""

printf "%s%s[ EXCLUDED / CRACKED / INTEL-ONLY APPS ]:%s\n" "${RED}" "${BOLD}" "${RESET}"
echo "  - R / RStudio (Intel-based, avoiding Rosetta 2)"
echo "  - Adobe Suite (Premiere, After Effects, Media Encoder)"
echo "  - Microsoft Office (Word, Excel, PowerPoint)"
echo "  - Cracked Apps (CleanShot X, Parallels, DisplayBuddy, Screen Studio, coconutBattery Plus, Ghost Buster Pro)"
echo "  - Minor Useless Bloatware ignored"
echo ""
printf "  %s[OK] Welcome to your new, clean, and 100%% legitimate workflow!%s\n" "${GREEN}" "${RESET}"
echo ""

printf "%s%s----------------------------------------------------------------------%s\n" "${YELLOW}" "${BOLD}" "${RESET}"
echo ""
