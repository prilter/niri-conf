import QtQuick

Text {
    id: clock
    text: Qt.formatDateTime(new Date(), "hh:mm:ss")
    color: "#cca53e"
    font.pixelSize: 14
    font.family: "Ubuntu Mono"

    Timer {
      interval: 1000
      running: true
      repeat: true
      onTriggered: {
        clock.text = Qt.formatDateTime(new Date(), "hh:mm:ss")
      }
    }
  }

