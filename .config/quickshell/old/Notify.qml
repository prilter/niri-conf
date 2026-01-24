import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Io
import QtQuick

Scope {
    id: notifyScope
    
    property color m3surface: "#1e1e2e"
    property color m3surfaceContainer: "#2a2a37"
    property color m3onSurface: "#cdd6f4"
    property color m3onSurfaceVariant: "#9399b2"
    property color m3primary: "#89b4fa"
    property color m3error: "#f38ba8"
    property color m3outline: "#45475a"
    
    property var activeNotifications: []
    property int maxNotifications: 5
    property int defaultExpireTimeout: 5000
    property bool expire: true
    
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
    
    IpcHandler {
        target: "notifs"
        function clear(): void {
            for (var i = 0; i < activeNotifications.length; i++) {
                activeNotifications[i].close()
            }
            activeNotifications = []
        }
    }
    
    Component {
        id: notificationComponent
        
        PopupWindow {
            id: popupWindow
            
            property var notification
            property int notificationIndex: 0
            property bool isExpanded: false
            property bool isHovered: false
            
            width: 400
            height: Math.max(80, contentColumn.implicitHeight + 24)
            visible: true
            
            Rectangle {
                id: background
                anchors.fill: parent
                color: notifyScope.m3surfaceContainer
                radius: 16
                
                Rectangle {
                    id: accentBar
                    width: 4
                    height: parent.height
                    anchors.left: parent.left
                    radius: 16
                    color: {
                        if (notification.urgency === 2) return notifyScope.m3error
                        if (notification.urgency === 1) return notifyScope.m3primary
                        return notifyScope.m3outline
                    }
                }
                
                Column {
                    id: contentColumn
                    anchors {
                        left: accentBar.right
                        right: parent.right
                        top: parent.top
                        margins: 16
                        leftMargin: 12
                    }
                    spacing: 8
                    
                    Row {
                        width: parent.width
                        spacing: 12
                        
                        Rectangle {
                            width: 40
                            height: 40
                            radius: 20
                            color: notifyScope.m3surface
                            
                            Text {
                                anchors.centerIn: parent
                                text: {
                                    var appName = notification.appName || "N"
                                    return appName.charAt(0).toUpperCase()
                                }
                                font.pixelSize: 18
                                font.bold: true
                                color: notifyScope.m3primary
                            }
                        }
                        
                        Column {
                            width: parent.width - 100
                            spacing: 2
                            
                            Text {
                                text: notification.appName || "Notification"
                                font.pixelSize: 11
                                color: notifyScope.m3onSurfaceVariant
                                elide: Text.ElideRight
                                width: parent.width
                            }
                            
                            Text {
                                text: notification.summary || ""
                                font.pixelSize: 14
                                font.bold: true
                                color: notifyScope.m3onSurface
                                width: parent.width
                                wrapMode: Text.WordWrap
                                maximumLineCount: isExpanded ? 999 : 2
                                elide: Text.ElideRight
                            }
                        }
                        
                        Text {
                            text: Qt.formatTime(new Date(), "hh:mm")
                            font.pixelSize: 10
                            color: notifyScope.m3onSurfaceVariant
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    
                    Text {
                        text: notification.body || ""
                        font.pixelSize: 12
                        color: notifyScope.m3onSurfaceVariant
                        width: parent.width
                        wrapMode: Text.WordWrap
                        visible: notification.body !== ""
                        maximumLineCount: isExpanded ? 999 : 3
                        elide: Text.ElideRight
                    }
                }
                
                Rectangle {
                    width: 32
                    height: 32
                    radius: 16
                    color: closeMouse.containsMouse ? notifyScope.m3error : "transparent"
                    anchors {
                        top: parent.top
                        right: parent.right
                        margins: 8
                    }
                    
                    Text {
                        anchors.centerIn: parent
                        text: "×"
                        font.pixelSize: 20
                        font.bold: true
                        color: closeMouse.containsMouse ? notifyScope.m3onSurface : notifyScope.m3onSurfaceVariant
                    }
                    
                    MouseArea {
                        id: closeMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: closeNotification()
                    }
                    
                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    z: -1
                    hoverEnabled: true
                    
                    onEntered: {
                        isHovered = true
                        if (dismissTimer.running) dismissTimer.stop()
                    }
                    
                    onExited: {
                        isHovered = false
                        if (notifyScope.expire) dismissTimer.start()
                    }
                    
                    onClicked: {
                        isExpanded = !isExpanded
                    }
                }
            }
            
            Timer {
                id: dismissTimer
                interval: notifyScope.expire ? (notification.timeout > 0 ? notification.timeout : notifyScope.defaultExpireTimeout) : 0
                running: notifyScope.expire && visible
                onTriggered: closeNotification()
            }
            
            PropertyAnimation {
                target: popupWindow
                property: "opacity"
                from: 0
                to: 1
                duration: 200
                easing.type: Easing.OutCubic
                running: true
            }
            
            function closeNotification() {
                fadeOut.start()
            }
            
            PropertyAnimation {
                id: fadeOut
                target: popupWindow
                property: "opacity"
                from: 1
                to: 0
                duration: 200
                easing.type: Easing.InCubic
                onFinished: {
                    popupWindow.destroy()
                }
            }
        }
    }
}

