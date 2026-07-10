import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import SddmComponents 2.0

Rectangle {
    id: root
    color: "#071014"

    readonly property color panelColor: "#eaf2e9"
    readonly property color panelText: "#101820"
    readonly property color mutedText: "#5e6a65"
    readonly property color borderColor: "#d3ded6"
    readonly property color accentGreen: "#39d98a"
    readonly property color accentBlue: "#2aa8ff"
    readonly property color accentGold: "#f5c542"
    readonly property int fieldHeight: 46

    function submitLogin() {
        sddm.login(userBox.currentText, passwordBox.text, sessionButton.currentIndex);
    }

    Image {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        opacity: 0.42
    }

    Rectangle {
        anchors.fill: parent
        color: "#a8071014"
    }

    Rectangle {
        width: Math.max(parent.width * 0.65, 760)
        height: width
        radius: width / 2
        x: -width * 0.22
        y: parent.height * 0.52
        color: "#10342c"
        opacity: 0.72
    }

    Rectangle {
        width: Math.max(parent.width * 0.48, 620)
        height: width
        radius: width / 2
        x: parent.width - width * 0.76
        y: parent.height * 0.50
        color: "#134638"
        opacity: 0.60
    }

    Rectangle {
        width: 128
        height: 128
        radius: 64
        x: parent.width - width - 138
        y: 96
        color: accentGold
        opacity: 0.70
    }

    Rectangle {
        id: cardShadow
        width: authCard.width
        height: authCard.height
        radius: authCard.radius
        anchors.centerIn: authCard
        anchors.verticalCenterOffset: 18
        color: "#7a000000"
    }

    Rectangle {
        id: authCard
        width: Math.min(420, root.width - 48)
        height: 548
        radius: 22
        anchors.centerIn: parent
        color: panelColor
        border.color: "#2bf5f7ef"
        border.width: 1

        Column {
            id: content
            anchors.fill: parent
            anchors.margins: 34
            spacing: 18

            Item {
                width: parent.width
                height: 132

                Rectangle {
                    id: logoTile
                    width: 86
                    height: 86
                    radius: 24
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#101820"

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 1
                        radius: parent.radius - 1
                        color: "transparent"
                        border.color: "#24343a"
                        border.width: 1
                    }

                    Image {
                        anchors.centerIn: parent
                        width: 64
                        height: 64
                        source: config.logo
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Text {
                    anchors.top: logoTile.bottom
                    anchors.topMargin: 16
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "KokinOS"
                    color: panelText
                    font.family: "Noto Sans"
                    font.pixelSize: 34
                    font.bold: true
                }
            }

            Text {
                width: parent.width
                text: "Welcome back"
                color: mutedText
                horizontalAlignment: Text.AlignHCenter
                font.family: "Noto Sans"
                font.pixelSize: 14
            }

            StyledComboBox {
                id: userBox
                width: parent.width
                model: userModel
                textRole: "name"
            }

            StyledTextField {
                id: passwordBox
                width: parent.width
                placeholderText: "Password"
                echoMode: TextInput.Password
                focus: true
                onAccepted: root.submitLogin()
            }

            StyledComboBox {
                id: sessionButton
                width: parent.width
                model: sessionModel
                textRole: "name"
            }

            QQC2.Button {
                id: loginButton
                width: parent.width
                height: 48
                text: "Log In"
                onClicked: root.submitLogin()

                contentItem: Text {
                    text: loginButton.text
                    color: "#071014"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Noto Sans"
                    font.pixelSize: 15
                    font.bold: true
                }

                background: Rectangle {
                    radius: 12
                    color: loginButton.down ? "#2ec678" : root.accentGreen
                    border.color: "#269f63"
                    border.width: 1
                }
            }

            Text {
                width: parent.width
                text: "Gaming-ready Fedora Atomic for creators and players"
                color: mutedText
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
                font.family: "Noto Sans"
                font.pixelSize: 12
                lineHeight: 1.18
            }
        }
    }

    Text {
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 24
        text: Qt.formatDateTime(new Date(), "dddd, MMMM d")
        color: "#b8c7c0"
        font.family: "Noto Sans"
        font.pixelSize: 14
    }

    Text {
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 24
        text: Qt.formatTime(new Date(), "h:mm AP")
        color: "#f5f7ef"
        font.family: "Noto Sans"
        font.pixelSize: 22
        font.bold: true
    }

    component StyledTextField: QQC2.TextField {
        id: control
        height: root.fieldHeight
        color: root.panelText
        selectionColor: root.accentBlue
        selectedTextColor: "#ffffff"
        placeholderTextColor: "#7b8782"
        font.family: "Noto Sans"
        font.pixelSize: 14
        leftPadding: 16
        rightPadding: 16
        verticalAlignment: TextInput.AlignVCenter

        background: Rectangle {
            radius: 12
            color: "#f8fbf5"
            border.color: control.activeFocus ? root.accentBlue : root.borderColor
            border.width: control.activeFocus ? 2 : 1
        }
    }

    component StyledComboBox: QQC2.ComboBox {
        id: control
        height: root.fieldHeight
        font.family: "Noto Sans"
        font.pixelSize: 14
        leftPadding: 16
        rightPadding: 40

        contentItem: Text {
            text: control.displayText
            color: root.panelText
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            font: control.font
        }

        indicator: Canvas {
            x: control.width - width - 16
            y: control.topPadding + (control.availableHeight - height) / 2
            width: 12
            height: 8
            contextType: "2d"

            onPaint: {
                context.clearRect(0, 0, width, height);
                context.moveTo(0, 0);
                context.lineTo(width, 0);
                context.lineTo(width / 2, height);
                context.closePath();
                context.fillStyle = "#5e6a65";
                context.fill();
            }
        }

        background: Rectangle {
            radius: 12
            color: "#f8fbf5"
            border.color: control.activeFocus ? root.accentBlue : root.borderColor
            border.width: control.activeFocus ? 2 : 1
        }

        delegate: QQC2.ItemDelegate {
            width: control.width
            height: 40
            text: typeof name !== "undefined" ? name : modelData
            font: control.font
            highlighted: control.highlightedIndex === index
        }

        popup: QQC2.Popup {
            y: control.height + 6
            width: control.width
            implicitHeight: contentItem.implicitHeight
            padding: 6

            contentItem: ListView {
                clip: true
                implicitHeight: Math.min(contentHeight, 220)
                model: control.popup.visible ? control.delegateModel : null
                currentIndex: control.highlightedIndex
                QQC2.ScrollIndicator.vertical: QQC2.ScrollIndicator { }
            }

            background: Rectangle {
                radius: 12
                color: "#f8fbf5"
                border.color: root.borderColor
                border.width: 1
            }
        }
    }
}
