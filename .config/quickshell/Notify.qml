import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Scope {
  id: notifyScope

  property var activeNotifications: []
  property int maxNotifications: 5

  NotificationServer {
    id: notificationServer

    onNotification: notif => {
      activeNotifications.push(notif)

      var popup = notificationComponent.createObject(notifyScope, {
        notification: notif,
        notificationIndex: activeNotifications.length - 1
      })

      if (activeNotifications.length > maxNotifications) {
        activeNotifications.shift()
      }
    }
  }

  Component {
    id: notificationComponent

    PopupWindow {
      id: popupWindow

      property var notification
      property int notificationIndex: 0

      implicitWidth: 400
      implicitHeight: contentColumn.implicitHeight + 24
      visible: true

      Rectangle {
        id: background
        anchors.fill: parent
        color: "#1e1e2e"
        border.color: "#89b4fa"
        border.width: 2
        radius: 10

        Column {
          id: contentColumn
          anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 12
          }
          spacing: 8

          Row {
            width: parent.width
            spacing: 8

            Rectangle {
              width: 32
              height: 32
              radius: 4
              color: "#313244"

              Text {
                anchors.centerIn: parent
                text: notification.appName ? notification.appName.charAt(0).toUpperCase() : "N"
                font.pixelSize: 16
                font.bold: true
                color: "#cdd6f4"
              }
            }

            Column {
              width: parent.width - 40
              spacing: 2

              Text {
                text: notification.appName || "Notification"
                font.pixelSize: 11
                color: "#9399b2"
              }

              Text {
                text: notification.summary || ""
                font.bold: true
                font.pixelSize: 14
                color: "#cdd6f4"
                width: parent.width
                wrapMode: Text.WordWrap
              }
            }
          }

          Text {
            text: notification.body || ""
            font.pixelSize: 12
            color: "#bac2de"
            width: parent.width
            wrapMode: Text.WordWrap
            visible: notification.body !== ""
          }
        }

        Rectangle {
          width: 24
          height: 24
          radius: 12
          color: closeMouse.containsMouse ? "#f38ba8" : "#313244"
          anchors {
            top: parent.top
            right: parent.right
            margins: 8
          }

          Text {
            anchors.centerIn: parent
            text: "×"
            font.pixelSize: 18
            font.bold: true
            color: "#cdd6f4"
          }

          MouseArea {
            id: closeMouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: closeNotification()
          }
        }
      }

      Timer {
        id: dismissTimer
        interval: 5000
        running: true
        onTriggered: closeNotification()
      }

      PropertyAnimation {
        target: popupWindow
        from: 0
        to: 1
        duration: 200
        running: true
      }

      function closeNotification() {
        fadeOut.start()
      }

      PropertyAnimation {
        id: fadeOut
        target: popupWindow
        from: 1
        to: 0
        duration: 150
        onFinished: {
          popupWindow.destroy()
        }
      }
    }
  }
}

