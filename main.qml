import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtLocation 5.12
import QtQuick.Particles 2.12
import QtMultimedia 5.12

import "Utils.js" as Util

Window {
    id: root
    visible: true
    width: 800
    height: 600
    color: "#00000000"
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WA_TranslucentBackground

    Material.theme: Material.Light
    Material.primary: "#212121"
    Material.accent: Material.Blue


    Audio{
        id: player
        volume: volume.value
    }

    Rectangle{
        id: background
        anchors.fill: parent
        anchors.margins: 10
        radius: 10
        anchors.bottomMargin: 450
        z: -1
        border.width: 0
        color: Material.primary

        MouseArea{
            id: mouseArea
            anchors.fill: parent
            enabled: true
            property point clickPos: Qt.point(0,0)

            onPressed: clickPos = Qt.point(mouse.x,mouse.y)

            onPositionChanged: {
                var delta = Qt.point(mouse.x - clickPos.x,mouse.y - clickPos.y);
                root.x += delta.x;
                root.y += delta.y;
            }
        }
    }

    DropShadow{
        id: dropShadow
        anchors.fill: background
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 17
        color: "#80000000"
        source: background
    }

    Slider {
        id: progress
        stepSize: 1
        to: player.duration
        anchors.right: parent.right
        anchors.rightMargin: 120
        anchors.left: parent.left
        anchors.leftMargin: 220
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 453
        anchors.top: parent.top
        anchors.topMargin: 88
        value: player.position

        onMoved: {
            if(player.seekable)
                player.seek(value)
        }

        handle: Item {}

        background: Rectangle {
            id: volumeBack
            x: progress.leftPadding
            y: progress.topPadding + progress.availableHeight / 2 - height / 2
            implicitWidth: 200
            implicitHeight: 4
            width: progress.availableWidth
            height: implicitHeight
            radius: 2

            Rectangle {
                id: ctx
                width: progress.visualPosition * parent.width
                height: parent.height
                color: Material.accent
                radius: 2

                ParticleSystem{
                    id: backgroundParticle
                }

                Emitter{
                    id: backgroundParticleEmitter
                    y: 92
                    width: 30
                    height: 30
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: -10
                    system: backgroundParticle
                    emitRate: 8
                    lifeSpan: 500
                    lifeSpanVariation: 100
                    size: 32
                    endSize: 16
                    velocity: AngleDirection {
                        angle: 90
                        angleVariation: 15
                        magnitude: 50
                        magnitudeVariation: 30
                    }
                    acceleration: AngleDirection {
                        angle: 90
                        magnitude: 25
                    }
                    shape: EllipseShape{
                        fill: true
                    }
                }

                ImageParticle{
                    system: backgroundParticle
                    source: "star.png"
                    color: Material.accent
                    entryEffect: ImageParticle.Fade
                }
            }

        }

        DropShadow{
            id: volumeBackShadow
            anchors.fill: volumeBack
            horizontalOffset: 3
            verticalOffset: 3
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: volumeBack
        }

        Text {
            id: timeProgressDisplay
            x: 436
            y: 10
            color: "#ffffff"
            text: {
                return Util.formatSeconds(player.position / 1000 ) + " / " + Util.formatSeconds(player.duration / 1000 );
            }

            anchors.bottom: parent.bottom
            anchors.bottomMargin: 35
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            anchors.right: parent.right
            anchors.rightMargin: 6
            font.pixelSize: 12
        }
    }

    RoundButton {
        id: nextButton
        y: 100
        width: 36
        height: 36
        text: ""
        display: AbstractButton.IconOnly
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 465
        anchors.left: parent.left
        anchors.leftMargin: 160

        icon.source: "baseline-skip_next-24px.svg"
    }

    RoundButton {
        id: playButton
        y: 99
        width: 36
        height: 36
        text: ""
        display: AbstractButton.IconOnly
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 465
        anchors.left: parent.left
        anchors.leftMargin: 100
        icon.source: player.playbackState == Audio.PlayingState ? "baseline-pause-24px.svg" : "baseline-play_arrow-24px.svg"
        onClicked: {
            if(player.playbackState == Audio.PlayingState)
                player.pause()
            else
                player.play()
        }
    }

    RoundButton {
        id: previousButton
        y: 100
        width: 36
        height: 36
        text: ""
        display: AbstractButton.IconOnly
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 465
        anchors.left: parent.left
        anchors.leftMargin: 40

        icon.source: "baseline-skip_previous-24px.svg"
    }

    Dial {
        id: volume
        value: 0.6
        anchors.top: parent.top
        anchors.topMargin: 70
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 460
        anchors.right: parent.right
        anchors.rightMargin: 36
        anchors.left: parent.left
        anchors.leftMargin: 690
        antialiasing: true
        stepSize: 0.01
        to: 1

        background: Rectangle {
            x: volume.width / 2 - width / 2
            y: volume.height / 2 - height / 2
            width: Math.max(64, Math.min(volume.width, volume.height))
            height: width
            color: "transparent"
            radius: width / 2
            border.color: volume.pressed ? Material.accent : Material.primary
            border.width: 3
        }

        handle: Rectangle {
            id: handleItem
            x: volume.background.x + volume.background.width / 2 - width / 2
            y: volume.background.y + volume.background.height / 2 - height / 2
            width: 16
            height: 16
            color: Material.accent
            radius: 8
            antialiasing: true
            transform: [
                Translate {
                    y: -Math.min(volume.background.width, volume.background.height) * 0.4 + handleItem.height / 2
                },
                Rotation {
                    angle: volume.angle
                    origin.x: handleItem.width / 2
                    origin.y: handleItem.height / 2
                }
            ]
        }

        RoundButton {
            id: muteButton
            x: 44
            y: 18
            width: 24
            height: 24
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            antialiasing: true
            display: AbstractButton.IconOnly
            icon.source: "baseline-volume_up-24px.svg"
        }

        Text {
            id: volumeDisplay
            color: "#ffffff"
            text: parseInt(volume.value * 100)
            visible: volume.pressed
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: -10
            styleColor: "#ffffff"
            font.pixelSize: 12
        }
    }

    RoundButton {
        id: minButton
        x: 631
        width: 36
        height: 36
        text: ""
        display: AbstractButton.IconOnly
        anchors.top: parent.top
        anchors.topMargin: 22
        anchors.right: parent.right
        anchors.rightMargin: 120
        icon.source: "baseline-minimize-24px.svg"
    }

    RoundButton {
        id: maxButton
        x: 686
        width: 36
        height: 36
        text: ""
        display: AbstractButton.IconOnly
        anchors.right: parent.right
        anchors.rightMargin: 75
        anchors.top: parent.top
        anchors.topMargin: 22
        icon.source: "baseline-fullscreen-24px.svg"
        onClicked: bottomControls.visible = !bottomControls.visible
    }

    RoundButton {
        id: closeButton
        x: 732
        width: 36
        height: 36
        text: ""
        display: AbstractButton.IconOnly
        anchors.top: parent.top
        anchors.topMargin: 22
        anchors.right: parent.right
        anchors.rightMargin: 30
        icon.source: "baseline-close-24px.svg"
        onClicked: Qt.quit()
    }

    Text {
        id: songNameDisplay
        width: 300
        height: 40
        color: "#ffffff"
        text: "等待加载中..."
        elide: Text.ElideRight
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.top: parent.top
        anchors.topMargin: 35
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        font.pixelSize: 38

        Text {
            id: artistDisplay
            color: "#ffffff"
            text: ""
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 40
            font.pixelSize: 12
        }
    }

    BottomControls {
        id: bottomControls
        height: 420
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 165
    }

}































































































































































































































































































































































/*##^## Designer {
    D{i:9;anchors_height:30;anchors_x:154;anchors_y:92}D{i:8;anchors_height:30;anchors_x:154;anchors_y:92}
D{i:19;anchors_height:70;anchors_width:70;anchors_x:8;anchors_y:5}D{i:26;anchors_x:40;anchors_y:34}
}
 ##^##*/
