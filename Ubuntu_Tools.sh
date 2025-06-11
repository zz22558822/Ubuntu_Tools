#!/bin/bash

# 標題顯示
title() {
    echo "╔══════════════════════════════════════════════════╗"
    echo "║              Ubuntu Tools 綜合工具箱   v1.1      ║"
    echo "║                                                  ║"
    echo "║                 僅適配 24.04 LTS                 ║"
    echo "║                                    By. Chek      ║"
    echo "╚══════════════════════════════════════════════════╝"
    echo
}

# 顯示選單
show_menu() {
    echo "請選擇要執行的操作："
    echo "——————————————————————————————————————————————————"
    echo "0.  apt 更新"
    echo "1.  安裝基礎軟體"
    echo "2.  安裝 Docker"
    echo "3.  Grype 一鍵掃描產出報告"
    echo "4.  Vaultwarden 一鍵安裝 + Nginx 反向代理"
    echo "5.  SpeedTest-X 一鍵安裝"
    echo "6.  AdGuard Home 一鍵安裝 + 53 Port 占用排除"
    echo "7.  Portainer v2.19.4 繁體中文版 一鍵安裝"
    echo "8.  StirlingPDF 一鍵安裝 (更改圖示請瀏覽教學)"
    echo "9.  LibreNMS 繁體中文版 一鍵安裝 (Ubuntu 24.04)"
    echo "10. LAMP 一鍵安裝"
    echo "11. LAMP + WordPress 一鍵安裝"
    echo "12. Nginx 反向代理 SSL自簽"
    echo "13. Hardware System 硬體管理系統 一鍵安裝"
    echo "14. Excel Chat 簡易訊息聊天  一鍵安裝"
    echo "——————————————————————————————————————————————————"
}

# 讀取用戶輸入
read_option() {
    read -p "選擇: " choice
    case "$choice" in
        0) echo "  ▷  執行 apt 更新" ; show_ ; step_0 ; show_ ;;
        1) echo "  ▷  安裝基礎軟體" ; show_ ; step_1 ; show_ ;;
        2) echo "  ▷  安裝 Docker" ; show_ ; step_2 ; show_ ;;
        3) echo "  ▷  Grype 一鍵掃描產出報告" ; show_ ; step_3 ; show_ ;;
        4) echo -e "  ▷  Vaultwarden 一鍵安裝 + Nginx 反向代理\\n  ▷  Port: 80、443" ; show_ ; step_4 ; show_ ;;
        5) echo -e "  ▷  SpeedTest-X 一鍵安裝\\n  ▷  Port: 8080" ; show_ ; step_5 ; show_ ;;
        6) echo -e "  ▷  AdGuard Home 一鍵安裝 + 53 Port 占用排除\\n  ▷  Port: 53、80" ; show_ ; step_6 ; show_ ;;
        7) echo -e "  ▷  Portainer v2.19.4 繁體中文版 一鍵安裝\\n  ▷  Port: 443、8000" ; show_ ; step_7 ; show_ ;;
        8) echo -e "  ▷  StirlingPDF 一鍵安裝\\n  ▷  Port: 80" ; show_ ; step_8 ; show_ ;;
        9) echo -e "  ▷  LibreNMS 繁體中文版 一鍵安裝 (Ubuntu 24.04)\\n  ▷  Port: 80、443" ; show_ ; step_9 ; show_ ;;
        10) echo -e "  ▷  LAMP 一鍵安裝\\n  ▷  Port: 80、443" ; show_ ; step_10 ; show_ ;;
        11) echo -e "  ▷  LAMP + WordPress 一鍵安裝\\n  ▷  Port: 80、443" ; show_ ; step_11 ; show_ ;;
        12) echo -e "  ▷  Nginx 反向代理 SSL自簽\\n  ▷  Port: 80、443" ; show_ ; step_12 ; show_ ;;
        13) echo -e "  ▷  Hardware System 硬體管理系統 一鍵安裝\\n  ▷  Port: 80、443" ; show_ ; step_13 ; show_ ;;
        14) echo -e "  ▷  Excel Chat 簡易訊息聊天  一鍵安裝\\n  ▷  Port: 80、443" ; show_ ; step_14 ; show_ ;;
        *) echo " × 無效選擇，請重新輸入！" ; sleep 1 ; clear ; title ; show_menu ; read_option ;;
    esac
}

# 顯示分隔
show_() {
    echo "——————————————————————————————————————————————————"
}

# 0. apt 更新
step_0() {
    echo
    sudo apt update && sudo apt upgrade -y
}

# 1. 安裝基礎軟體
step_1() {
    packages=("openssh-server" "vim" "gufw" "curl" "hardinfo")

    # 加入 VM-Tools 預設為 n
    while true; do
        read -p "是否在 VMware 環境中？ (Y/N 預設): " vm_choice
        vm_choice=${vm_choice:-n}  # 若用戶未輸入，則預設為 n
        vm_choice=$(echo "$vm_choice" | tr '[:upper:]' '[:lower:]')  # 轉換為小寫
        if [[ "$vm_choice" == "y" || "$vm_choice" == "n" ]]; then
            break
        else
            echo "無效選擇，請輸入 'Y' 或 'N'"
        fi
    done

    if [[ "$vm_choice" == "y" ]]; then
        echo "◆ 加入安裝 VMware Tools"
        packages+=("open-vm-tools" "open-vm-tools-desktop")
    fi

    # 加入圖形驅動 預設為 n
    while true; do
        read -p "是否需要更新圖形驅動？ (Y/N 預設): " gfx_choice
        gfx_choice=${gfx_choice:-n}  # 若用戶未輸入，則預設為 n
        gfx_choice=$(echo "$gfx_choice" | tr '[:upper:]' '[:lower:]')  # 轉換為小寫
        if [[ "$gfx_choice" == "y" || "$gfx_choice" == "n" ]]; then
            break
        else
            echo "無效選擇，請輸入 'Y' 或 'N'"
        fi
    done

    if [[ "$gfx_choice" == "y" ]]; then
        echo "◆ 加入更新圖形驅動"
        sudo ubuntu-drivers autoinstall
    fi

    echo "安裝基礎軟體: ${packages[@]}..."
    sudo apt install -y "${packages[@]}"
}

# 2. 安裝 Docker
step_2() {
    # Docker 安裝
    # # Docker 舊版安裝方法
    # sudo apt install -y curl docker.io
    # # Docker-Compose V1 安裝
	# sudo apt remove -y docker-compose
	# COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .tag_name)
	# sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" \
	#   -o /usr/local/bin/docker-compose
	# sudo chmod +x /usr/local/bin/docker-compose

    # 清理已安裝 Docker
    sudo systemctl stop docker docker.socket containerd 2>/dev/null || true
    sudo apt purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 2>/dev/null || true
    sudo rm -rf /var/lib/docker 2>/dev/null
    sudo rm -rf /var/lib/containerd 2>/dev/null
    sudo rm -f /etc/apt/keyrings/docker.asc 2>/dev/null
    sudo rm -f /etc/apt/keyrings/docker.gpg 2>/dev/null
    sudo rm -f /etc/apt/sources.list.d/docker.list 2>/dev/null
    sudo apt autoremove -y
    sudo apt clean

    # Docker-Compose V2 安裝
    sudo apt update -y
    sudo apt install -y ca-certificates curl gnupg lsb-release
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    gpg --no-default-keyring --keyring /etc/apt/keyrings/docker.gpg --list-keys # 驗證用 可刪除
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    cat /etc/apt/sources.list.d/docker.list
    sudo apt update -y
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    # Docker 開機啟用
    sudo systemctl start docker
    sudo systemctl enable docker
    # Docker 加入群組
    sudo groupadd docker 2>/dev/null  # 如果群組已存在，避免錯誤訊息
    sudo usermod -aG docker "$USER"
    # 讓變更立即生效，避免卡在 newgrp
    sudo su - $USER -c "echo 'Docker 安裝完成，群組變更已生效。'"
}

# 3. Grype 一鍵掃描產出報告
step_3() {
    sudo mkdir -p Grype
    sudo chmod -R 755 Grype
    sudo bash -c "cd Grype && wget -qO- https://raw.githubusercontent.com/zz22558822/grype_scan_script/main/grype_scan_script.sh | bash"
}

# 4. Vaultwarden 一鍵安裝 + Nginx 反向代理
step_4() {
    sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/Vaultwarden_Install/main/Vaultwarden_Install.sh)"
}


# 5. SpeedTest-X 一鍵安裝
step_5() {
    while true; do
        read -p "請選擇安裝版本 (A: Apache、D: Docker 預設): " install_choice
        install_choice=${install_choice:-d}  # 若用戶未輸入，則預設為 d
        install_choice=$(echo "$install_choice" | tr '[:upper:]' '[:lower:]')  # 轉換為小寫
        if [[ "$install_choice" == "a" || "$install_choice" == "d" ]]; then
            break
        else
            echo "無效選擇，請輸入 'A' 或 'D'！"
        fi
    done

    if [[ "$install_choice" == "a" ]]; then
        echo "◆  安裝 Apache版本 SpeedTest-X"
        sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/SpeedTest-X_install/main/SpeedTest-X_Install_Apache.sh)"
        # 在這裡加上安裝並啟用的步驟
    elif [[ "$install_choice" == "d" ]]; then
        echo "◆  安裝 Docker版本 SpeedTest-X"
        sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/SpeedTest-X_install/main/SpeedTest-X_Install_Docker.sh)"
    fi
}

# 6. AdGuard Home 一鍵安裝 + 53 Port 占用排除
step_6() {
    sudo bash -c "$(wget -qO- https://github.com/zz22558822/AdGuard-Home-install/releases/download/upload/install_adguardhome.sh)"
}

# 7. Portainer v2.19.4 繁體中文版 一鍵安裝
step_7() {
    sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/Portainer_zh_TW_Install/main/Portainer_zh_TW_Install.sh)"
}

# 8. StirlingPDF 一鍵安裝 (更改圖示需瀏覽教學)
step_8() {
    sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/StirlingPDF_Install/main/StirlingPDF_Install.sh)"
    echo -e "\\n◎  教學檔案: https://raw.githubusercontent.com/zz22558822/StirlingPDF_Install/main/安裝教學.txt"
}

# 9. LibreNMS 繁體中文版 一鍵安裝 (Ubuntu 24.04)
step_9() {
    sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/LibreNMS_Install/master/LibreNMS_Install.sh)"
}

# 10. LAMP 一鍵安裝
step_10() {
    sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/LAMP/main/一鍵安裝LAMP.sh)"
}

# 11. LAMP + WordPress 一鍵安裝
step_11() {
    sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/LAMP/main/WordPress/一鍵安裝LAMP%2BWordPress.sh)"
    show_
    echo
    sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/LAMP/main/WordPress/WordPress_Max_Upload.sh)"
    show_
    sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/LAMP/main/WordPress/WordPress_SSL.sh)"
    show_
    echo -e "\\n◎  教學檔案: https://raw.githubusercontent.com/zz22558822/LAMP/main/WordPress/WordPress%20架設教學.txt\\n"
}

# 12. Nginx 反向代理 SSL自簽
step_12() {
    sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/Nginx_Re_Proxy_install/main/Nginx_Re_Proxy_install.sh)"
}

# 13. Hardware System 硬體管理系統 一鍵安裝
step_13() {
    while true; do
        read -p "請選擇環境是否使用 venv 安裝 (Y: venv、N: 無venv 預設): " install_choice
        install_choice=${install_choice:-n}  # 若用戶未輸入，則預設為 n
        install_choice=$(echo "$install_choice" | tr '[:upper:]' '[:lower:]')  # 轉換為小寫
        if [[ "$install_choice" == "y" || "$install_choice" == "n" ]]; then
            break
        else
            echo "無效選擇，請輸入 'Y' 或 'N'！"
        fi
    done

    if [[ "$install_choice" == "y" ]]; then
        echo "◆  安裝 venv版本 Hardware System"
        sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/Hardware_System/main/SQL/Hardware_System_install_venv.sh)"
        # 在這裡加上安裝並啟用的步驟
    elif [[ "$install_choice" == "n" ]]; then
        echo "◆  安裝 無venv版本 Hardware System"
        sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/Hardware_System/main/SQL/Hardware_System_install.sh)"
    fi
    show_
    echo -e "\\n◎  教學檔案: https://github.com/zz22558822/Hardware_System\\n"
}

# 14. Excel Chat 簡易訊息聊天  一鍵安裝
step_14() {
    sudo bash -c "$(wget -qO- https://raw.githubusercontent.com/zz22558822/Excel_Chat/main/Excel_Chat_install.sh)"
    show_
    echo -e "\\n◎  教學檔案: https://github.com/zz22558822/Excel_Chat\\n"
}




# 執行主程式
clear
title
show_menu
read_option
