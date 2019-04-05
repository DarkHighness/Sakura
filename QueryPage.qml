import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import "Utils.js" as Util

Item {
    id: root
    width: 780
    height: 420

    Material.theme: Material.Light
    Material.primary: "#212121"
    Material.accent: Material.Blue

    TextField {
        id: inputNameField
        height: 36
        text: qsTr("")
        bottomPadding: 6
        topPadding: 6
        antialiasing: true
        font.pointSize: 12
        font.capitalization: Font.Capitalize
        placeholderText: "等待搜索中..."
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.horizontalCenter: parent.horizontalCenter

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 40
            color: "white"
            border.color: inputNameField.enabled ? Material.accent : "transparent"
            radius: 3
            antialiasing: true
        }

        onAccepted: {
            Util.query("netease",inputNameField.text)
        }

        RoundButton {
            id: searchBottom
            x: 337
            y: 30
            width: 36
            height: 36
            antialiasing: true
            anchors.right: parent.right
            anchors.rightMargin: -46
            anchors.verticalCenter: parent.verticalCenter
            icon.source: "baseline-search-24px.svg"
            onClicked: {
                Util.query("netease",inputNameField.text)
            }
        }
    }

    ListView {
        id: songView
        width: 780
        antialiasing: true
        anchors.top: parent.top
        anchors.topMargin: 60
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 35
        delegate: Item {
            id: songDelegate
            width: 780
            height: 30

            property string purl: url
            property string pname: name
            property string partist: artist

            Text {
                text: name
                elide: Text.ElideRight
                anchors.left: parent.left
                anchors.leftMargin: 40
                anchors.right: parent.right
                anchors.rightMargin: 530
                verticalAlignment: Text.AlignVCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                color: "white"
            }
            Text {
                width: 223
                text: artist
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 280
                color: "white"
            }
            RoundButton{
                    id: queryPlayButton
                    width: 24
                    height: 24
                    anchors.right: parent.right
                    anchors.rightMargin: 130
                    anchors.verticalCenter: parent.verticalCenter
                    display: AbstractButton.IconOnly
                    antialiasing: true
                    icon.source: "baseline-play_arrow-24px.svg"
                    onClicked: {
                        Util.play(purl,pname,partist)
                    }
            }
            RoundButton{
                id: queryLikeButton
                width: 24
                height: 24
                anchors.right: parent.right
                anchors.rightMargin: 80
                anchors.verticalCenter: parent.verticalCenter
                display: AbstractButton.IconOnly
                antialiasing: true
                icon.source: "baseline-favorite_border-24px.svg"
            }
            RoundButton{
                id: queryDownloadButton
                width: 24
                height: 24
                anchors.right: parent.right
                anchors.rightMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                display: AbstractButton.IconOnly
                    antialiasing: true
                    icon.source: "baseline-arrow_downward-24px.svg"
            }
        }
        model: ListModel {

        }
    }

}























/*##^## Designer {
    D{i:4;anchors_height:350;anchors_width:764;anchors_x:8;anchors_y:62}
}
 ##^##*/
