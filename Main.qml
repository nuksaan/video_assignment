import QtQuick
import QtQuick.Window
import QtMultimedia 5.15
import QtQuick.Layouts
import QtQuick.Dialogs

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Video Player")

    Video {
        id: mediaPlayer
        anchors.fill: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            mediaPlayer.play()
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        onAccepted: {
            mediaPlayer.stop()
            mediaPlayer.source = fileDialog.currentFile
            mediaPlayer.play()
        }
        Component.onCompleted: visible = true
    }

    Rectangle {
        id: buttonBox
        width: 160
        height: 40
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle {
            id: playButton
            width: 80
            height: 40
            color: "green"
            radius: 5
            opacity: enabled && !mouseArea.pressed ? 1 : 0.3
            anchors.left: parent.left
            Text {
                anchors.centerIn: parent
                text: "Play"
                font.pixelSize: 14
                color: "white"
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: mediaPlayer.play()
            }
        }
        Rectangle {
            id: pauseButton
            width: 80
            height: 40
            color: "grey"
            radius: 5
            opacity: enabled && !mouseArea2.pressed ? 1 : 0.3

            anchors.right: parent.right


            Text {
                anchors.centerIn: parent
                text: "Pause"
                font.pixelSize: 14
                color: "white"
            }

            MouseArea {
                id: mouseArea2
                anchors.fill: parent
                onClicked: mediaPlayer.pause()
            }

        }
    }

    Rectangle {
           id: sliderBar
           color: "yellow"
           width: parent.width
           height: 10
           y: parent.height - 60

           Rectangle {
               id: sliderHandle
               color: "blue"
               width: 20
               height: 20
               radius: width/2
               x: (sliderBar.width - width) * (mediaPlayer.position / mediaPlayer.duration)
               y: (sliderBar.height - height) / 2
               MouseArea {
                   id: handleMouseArea
                   anchors.fill: parent
                   drag.target: sliderHandle
                   drag.axis: Drag.XAxis

                   onPressed: {
                       mediaPlayer.pause()
                   }


                   onReleased: {
                       mediaPlayer.position = (sliderHandle.x / (sliderBar.width - sliderHandle.width)) * mediaPlayer.duration
                       mediaPlayer.play()
                   }
               }
           }
       }

    Text {
        id: playbackNumber
        x: 10
        y: parent.height - 48
        text: formatTime(mediaPlayer.position)
        color: "slateblue"
        font.bold: true
    }

        function formatTime(ms) {
               var seconds = Math.floor(ms / 1000) % 60;
               var minutes = Math.floor(ms / 1000 / 60);

               return minutes.toString().padStart(2, '0') + ":" + seconds.toString().padStart(2, '0');
           }




}
