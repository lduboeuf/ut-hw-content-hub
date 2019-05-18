import QtQuick 2.9
import QtQuick.Controls 2.2
import Qt.labs.folderlistmodel 2.2


ApplicationWindow {
    visible: true
    width: 360
    height: 520
    title: qsTr("Content Hub test")


    Label {
        anchors.topMargin: 24
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Super cross platform app")
    }



    FolderListModel {
        id: folderModel
        folder: "file://" + dataDir
        nameFilters: ["*.ogg", "*.wav"]
    }

    Component {
        id: fileDelegate
        Item {
            width: folderList.width
            height: fName.implicitHeight * 2
            Text {id:fName; text: fileName }
            MouseArea {
                anchors.fill:parent
                onClicked: folderList.currentIndex = index
            }

        }


    }

    ListView {
        id:folderList
        topMargin: 24
        width: parent.width;
        height: 400

        model: folderModel
        delegate: fileDelegate

        header:Label {
            height: implicitHeight *2
            text: dataDir + ":"
        }

        highlight: Rectangle {
            color: 'grey'

        }

        onCurrentItemChanged: {
            var selectedFile =  folderModel.get(folderList.currentIndex, "fileURL")
            console.log("selected file:" + selectedFile)
            if (typeof UBUNTU_TOUCH !== "undefined"){

                var selectedFile = folderModel.get(folderList.currentIndex, "fileURL")

                utFileExport.setSource("UTFileExport.qml", {url: selectedFile})
            }
        }
    }


    Row {
        //width: parent.width
        height: 50
        spacing: 24
        anchors.centerIn: parent



        Item {
            id: importItem
            width:100
            height: 50


            //import
            Loader {
                id: utFilePicker
                anchors.fill: parent
                //anchors.left: btnContainer.left
                //anchors.centerIn: parent
                Component.onCompleted: {
                    if (typeof UBUNTU_TOUCH !== "undefined"){

                        //convert nameFilters for utFilePicker
                        var extensions = []
                        for (var j = 0; j < folderModel.nameFilters.length; j++){
                            var filter = folderModel.nameFilters[j]
                            var allowedExtension = filter.substring(filter.length-3,filter.length)
                            extensions.push(allowedExtension)

                        }
                        utFilePicker.setSource("UTFileImport.qml", {nameFilters: extensions})
                    }
                }
            }

            Connections{
                target: utFilePicker.item
                onFilesAdded: console.log("olala import ok")
            }
        }

        Item {
            id: exportItem
            width:100
            height: 50


            //export
            Loader {
                id: utFileExport
                anchors.fill: parent
                //anchors.margins: 24

            }

            Connections{
                target: utFileExport.item
                onDone: console.log("cool, import done")
            }

        }
    }



}
