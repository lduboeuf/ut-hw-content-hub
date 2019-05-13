import QtQuick 2.9
import QtQuick.Controls 2.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Content Hub test")

    Label {
        anchors.margins: 24
        text: qsTr("Super cross platform app")
    }


    Loader {
          id: utFilePicker
          anchors.centerIn: parent
          source: (typeof UBUNTU_TOUCH !== "undefined") ? "UTFileHandler.qml" : ""
    }

    Connections{
        target: utFilePicker.item
        onFilesAdded: console.log("olala ok")
    }





}
