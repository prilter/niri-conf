import Quickshell.Io
import QtQuick

Text {
    id: ramText
    text: "RAM: --%"
    color: "#c2d39f"
    font.pixelSize: 13
    font.family: "Ubuntu Mono"
    
    property int percent: 0
    
    function updateRam() {
        ramProc.running = true
    }
    
    function getRamText() {
        if (percent === 0) return "RAM: --"
        return "RAM: " + percent + "%"
    }
    
    function getRamColor() {
        if (percent < 80) return "#c2d39f"  // NORMAL
        return "#ff0000"                    // CRITICAL
    }
    
    Process {
        id: ramProc
        command: ["bash", "-c", 
            "total=$(grep 'MemTotal' /proc/meminfo | awk '{print $2}'); " +
            "used=$(vmstat -s | grep 'used memory' | awk '{print $1}'); " +
            "echo $((used * 100 / total))"
        ]
        running: false
        
        stdout: SplitParser {
            onRead: data => {
                var p = parseInt(data.trim())
                if (!isNaN(p)) {
                    ramText.percent = p
                    ramText.text = ramText.getRamText()
                    ramText.color = ramText.getRamColor()
                }
            }
        }
    }
    
    Timer {
        interval: 3000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: ramText.updateRam()
    }
}

