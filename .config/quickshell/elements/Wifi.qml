import Quickshell.Io
import QtQuick

Text {
    id: wifiText
    text: getWifiText()
    color: "#c2d39f"
    font.pixelSize: 13
    font.family: "Ubuntu Mono"

    property string currentSsid: ""

    function getWifiText() {
      if (currentSsid === "") return "Disconnected"
      return currentSsid
    }

    Process {
      id: wifiProc
      command: ["bash", "-c", "nmcli -t -f active,ssid dev wifi | grep '^yes:' | cut -d: -f2"]
      running: true

      stdout: SplitParser {
        onRead: data => {
          var ssid = data.trim()
          if (ssid !== "") {
            wifiText.currentSsid = ssid
          } else {
            wifiText.currentSsid = "Disconnected"
          }
          wifiText.text = wifiText.getWifiText()
        }
      }
    }

    Timer {
      interval: 10000
      running: true
      repeat: true
      onTriggered: wifiProc.running = true
    }
  }

