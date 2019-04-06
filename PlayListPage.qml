import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

import "Utils.js" as Util

Item {
    implicitWidth: 780
    implicitHeight: 620

    id: playListPage

    property ListView view : playListView

    ListView {
        id: playListView
        width: 780
        spacing: 1
        cacheBuffer: 30
        antialiasing: true
        anchors.top: parent.top
        anchors.topMargin: 49
        anchors.right: parent.right
        anchors.rightMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40
        delegate: Item {
            id: playListDelegate
            width: 780
            height: 30

            property string purl: url
            property string pname: name
            property string partist: artist
            property int pindex: index

            Text {
                text: name
                font.pixelSize: 16
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
                font.pixelSize: 16
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
                    id: playListPlayButton
                    width: 36
                    height: 36
                    anchors.right: parent.right
                    anchors.rightMargin: 130
                    anchors.verticalCenter: parent.verticalCenter
                    display: AbstractButton.IconOnly
                    antialiasing: true
                    icon.source: "baseline-play_arrow-24px.svg"
                    onClicked: {
                        Util.playAt(pindex,partist,pname)
                    }
            }
            RoundButton{
                id: playListLikeButton
                width: 36
                height: 36
                anchors.right: parent.right
                anchors.rightMargin: 80
                anchors.verticalCenter: parent.verticalCenter
                display: AbstractButton.IconOnly
                antialiasing: true
                icon.source: "baseline-favorite_border-24px.svg"
            }
            RoundButton{
                id: playListRemoveButton
                width: 36
                height: 36
                anchors.right: parent.right
                anchors.rightMargin: 30
                anchors.verticalCenter: parent.verticalCenter
                display: AbstractButton.IconOnly
                    antialiasing: true
                    icon.source: "baseline-remove-24px.svg"
            }
        }
        model: ListModel {

        }
    }

    Text {
        color: "#ffffff"
        text: qsTr("歌曲名称")
        anchors.left: parent.left
        anchors.leftMargin: 45
        anchors.top: parent.top
        anchors.topMargin: 27
        font.pixelSize: 16
    }

    Text {
        color: "#ffffff"
        text: qsTr("歌手")
        anchors.top: parent.top
        anchors.topMargin: 27
        anchors.left: parent.left
        anchors.leftMargin: 380
        font.pixelSize: 16
    }
}







/*##^## Designer {
    D{i:9;anchors_x:45;anchors_y:52}D{i:10;anchors_x:235;anchors_y:70}
}
 ##^##*/
