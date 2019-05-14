import QtQuick 2.0
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3 as Popups
import Ubuntu.Content 1.3

Popups.PopupBase {
    id: picker
    objectName: "contentPickerDialog"

    // Set the parent at construction time, instead of letting show()
    // set it later on, which for some reason results in the size of
    // the dialog not being updated.
    parent: QuickUtils.rootItem(this)

    property var activeTransfer: null
    property bool allowMultipleFiles
    property string  url

    signal done()
    signal reject()

    onDone: hide()
    onReject: hide()

    Rectangle {
        anchors.fill: parent

        ContentTransferHint {
            anchors.fill: parent
            activeTransfer: picker.activeTransfer
        }

        ContentPeerPicker {
            id: peerPicker
            anchors.fill: parent
            visible: true
            contentType: ContentType.Music
            handler: ContentHandler.Destination

            onPeerSelected: {

                peer.selectionType = ContentTransfer.Single
                picker.activeTransfer = peer.request()

            }

            onCancelPressed: {
                picker.reject()
            }
        }
    }

    Connections {
        id: stateChangeConnection
        target: picker.activeTransfer
        onStateChanged: {
            console.log(picker.activeTransfer.state);
            //export
            if (picker.activeTransfer.state === ContentTransfer.InProgress) {
                picker.activeTransfer.items = [ resultComponent.createObject(parent, {"url": url}) ];
                picker.activeTransfer.state = ContentTransfer.Charged;
            }else if (picker.activeTransfer.state === ContentTransfer.Charged ){
                picker.done()
            }





        }
    }

    Component {
            id: resultComponent
            ContentItem {}
        }




}
