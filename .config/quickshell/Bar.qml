import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import "elements"

PanelWindow {
    id: bar
    anchors {
        top: true
        left: true
        right: true
    }
    
    implicitHeight: 30
    color: "#161616"
    
    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        spacing: 15
        
        // Левая часть - пустое пространство
        Wifi {}
        
        // Центр - часы
        Item { Layout.fillWidth: true }
        Clock {
            Layout.alignment: Qt.AlignCenter
        }
        Item { Layout.fillWidth: true }
        
        RowLayout {
            spacing: 15
            Layout.alignment: Qt.AlignRight
            
            Ram {}
            Volume {}
            Text { 
              text: "|" 
              color: "#c2d39f"
            }
            Bat {}
          }
        }
      }

