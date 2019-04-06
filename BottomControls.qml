import QtQuick 2.12
import QtQuick.Window 2.12
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import QtLocation 5.12

Item {
    implicitWidth: 780
    implicitHeight: 620

    Rectangle{
        id: background
        anchors.fill: parent
        color: Material.primary
        border.width: 0
        radius: 10

        SwipeView {
            id: view
            currentIndex: 0
            anchors.fill: parent

            QueryPage {
                id: queryPage
            }

            Item {
                id: secondPage
            }
            Item {
                id: thirdPage
            }
            Item {
                id: forthPage
            }
        }

        PageIndicator {
            id: indicator
            anchors.bottomMargin: 10

            count: view.count
            currentIndex: view.currentIndex

            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
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
}
