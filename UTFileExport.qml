import QtQuick 2.0
import QtQuick.Controls 2.2

Item {

    id:root

    property string url
    signal done

    Button{
        id:btnExport
        text: "Export File"
        onClicked:  picker.show()
        ToolTip{
            id:toolTip
            //delay: 1000
            timeout: 2000
            visible:text.length > 0
        }
    }


    UTFileExportHandler{
        id: picker
        url:root.url
        onDone: {

            toolTip.text = "Operation done"
            root.done()
        }

    }
}
