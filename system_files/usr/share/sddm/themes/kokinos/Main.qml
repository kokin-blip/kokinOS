import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import SddmComponents 2.0

Rectangle {
    id: root
    color: "#101820"

    Image {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
    }

    Rectangle {
        anchors.fill: parent
        color: "#66000000"
    }

    Column {
        anchors.centerIn: parent
        spacing: 18
        width: 360

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: config.logo
            width: 120
            height: 120
            fillMode: Image.PreserveAspectFit
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "KokinOS"
            color: "#f5f7ef"
            font.pixelSize: 40
            font.bold: true
        }

        QQC2.ComboBox {
            id: userBox
            width: parent.width
            model: userModel
            textRole: "name"
        }

        QQC2.TextField {
            id: passwordBox
            width: parent.width
            placeholderText: "Password"
            echoMode: TextInput.Password
            focus: true
            onAccepted: sddm.login(userBox.currentText, passwordBox.text, sessionButton.currentIndex)
        }

        QQC2.ComboBox {
            id: sessionButton
            width: parent.width
            model: sessionModel
            textRole: "name"
        }

        QQC2.Button {
            width: parent.width
            text: "Log In"
            onClicked: sddm.login(userBox.currentText, passwordBox.text, sessionButton.currentIndex)
        }
    }
}
