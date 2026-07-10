import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import SddmComponents 2.0

Rectangle {
    id: root
    color: "#071014"

    readonly property color primaryText: "#f6faf8"
    readonly property color secondaryText: "#b8c6c1"
    readonly property color accentGreen: "#39d98a"
    readonly property color accentBlue: "#58baff"
    readonly property color errorRed: "#ff9b96"
    readonly property int fieldHeight: 44
    property date currentDate: new Date()
    property bool authenticating: false
    property string loginMessage: ""

    function submitLogin() {
        loginMessage = "";
        authenticating = true;
        sddm.login(userBox.currentText, passwordBox.text, sessionButton.currentIndex);
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.currentDate = new Date()
    }

    Connections {
        target: sddm

        function onLoginFailed() {
            root.authenticating = false;
            root.loginMessage = "The password was not accepted. Try again.";
            passwordBox.selectAll();
            passwordBox.forceActiveFocus();
        }
    }

    Image {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        opacity: 0.78
    }

    Rectangle {
        anchors.fill: parent
        color: "#76040b0e"
    }

    Rectangle {
        width: Math.max(parent.width * 0.58, 680)
        height: width
        radius: width / 2
        x: -width * 0.32
        y: parent.height * 0.58
        color: "#193b35"
        opacity: 0.44
    }

    Rectangle {
        width: Math.max(parent.width * 0.42, 540)
        height: width
        radius: width / 2
        x: parent.width - width * 0.62
        y: parent.height * 0.54
        color: "#1d5948"
        opacity: 0.34
    }

    Item {
        id: authStage
        width: 404
        height: 520
        anchors.centerIn: parent
        scale: Math.min(1, (root.width - 32) / width, (root.height - 48) / height)

        Rectangle {
            width: parent.width + 18
            height: parent.height + 18
            x: -9
            y: 14
            radius: 32
            color: "#66000000"
        }

        Rectangle {
            id: authCard
            anchors.fill: parent
            radius: 28
            color: "#c2182328"
            border.color: "#52ffffff"
            border.width: 1

            Rectangle {
                anchors.fill: parent
                anchors.margins: 1
                radius: 27
                color: "#181f3538"
            }

            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 2
                height: 1
                radius: 1
                color: "#a6ffffff"
            }

            Column {
                id: content
                anchors.fill: parent
                anchors.margins: 30
                spacing: 12

                Item {
                    width: parent.width
                    height: 116

                    Rectangle {
                        id: logoTile
                        width: 72
                        height: 72
                        radius: 22
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: "#5410191d"
                        border.color: "#5cffffff"
                        border.width: 1

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 2
                            radius: 20
                            color: "#24ffffff"
                        }

                        Image {
                            anchors.centerIn: parent
                            width: 54
                            height: 54
                            source: config.logo
                            fillMode: Image.PreserveAspectFit
                        }
                    }

                    Text {
                        anchors.top: logoTile.bottom
                        anchors.topMargin: 10
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "KokinOS"
                        color: root.primaryText
                        font.family: "Noto Sans"
                        font.pixelSize: 28
                        font.weight: Font.DemiBold
                    }
                }

                Text {
                    width: parent.width
                    height: 20
                    text: "Welcome back"
                    color: root.secondaryText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
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
                    onTextChanged: root.loginMessage = ""
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
                    height: 46
                    text: root.authenticating ? "Signing In..." : "Log In"
                    enabled: !root.authenticating
                    hoverEnabled: true
                    onClicked: root.submitLogin()

                    contentItem: Text {
                        text: loginButton.text
                        color: "#06110d"
                        opacity: loginButton.enabled ? 1 : 0.66
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Noto Sans"
                        font.pixelSize: 15
                        font.weight: Font.DemiBold
                    }

                    background: Rectangle {
                        radius: 13
                        color: loginButton.down ? "#2ac276"
                            : loginButton.hovered ? "#52e59b"
                            : root.accentGreen
                        opacity: loginButton.enabled ? 1 : 0.66
                        border.color: loginButton.activeFocus ? "#c9ffffff" : "#6439d98a"
                        border.width: loginButton.activeFocus ? 2 : 1

                        Behavior on color {
                            ColorAnimation { duration: 100 }
                        }
                    }
                }

                Text {
                    width: parent.width
                    height: 18
                    text: root.loginMessage
                    color: root.errorRed
                    opacity: text.length > 0 ? 1 : 0
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    elide: Text.ElideRight
                    font.family: "Noto Sans"
                    font.pixelSize: 12
                }

                Text {
                    width: parent.width
                    height: 28
                    text: "Gaming-ready. Developer-friendly."
                    color: "#8fa39b"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignBottom
                    font.family: "Noto Sans"
                    font.pixelSize: 12
                }
            }
        }
    }

    Text {
        anchors.left: parent.left
        anchors.leftMargin: 28
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 24
        text: Qt.formatDateTime(root.currentDate, "dddd, MMMM d")
        color: root.secondaryText
        opacity: root.height >= 650 ? 0.84 : 0
        font.family: "Noto Sans"
        font.pixelSize: 14
    }

    Text {
        anchors.right: parent.right
        anchors.rightMargin: 28
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        text: Qt.formatTime(root.currentDate, "h:mm AP")
        color: root.primaryText
        opacity: root.height >= 650 ? 0.94 : 0
        font.family: "Noto Sans"
        font.pixelSize: 20
        font.weight: Font.DemiBold
    }

    component StyledTextField: QQC2.TextField {
        id: control
        height: root.fieldHeight
        color: root.primaryText
        selectionColor: root.accentBlue
        selectedTextColor: "#071014"
        placeholderTextColor: "#90a49d"
        font.family: "Noto Sans"
        font.pixelSize: 14
        leftPadding: 16
        rightPadding: 16
        verticalAlignment: TextInput.AlignVCenter
        hoverEnabled: true

        background: Rectangle {
            radius: 13
            color: control.activeFocus ? "#42355054"
                : control.hovered ? "#34ffffff"
                : "#26ffffff"
            border.color: control.activeFocus ? root.accentBlue : "#3dffffff"
            border.width: control.activeFocus ? 2 : 1

            Behavior on color {
                ColorAnimation { duration: 100 }
            }
        }
    }

    component StyledComboBox: QQC2.ComboBox {
        id: control
        height: root.fieldHeight
        font.family: "Noto Sans"
        font.pixelSize: 14
        leftPadding: 16
        rightPadding: 40
        hoverEnabled: true

        contentItem: Text {
            text: control.displayText
            color: root.primaryText
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
                context.fillStyle = "#b8c6c1";
                context.fill();
            }
        }

        background: Rectangle {
            radius: 13
            color: control.activeFocus ? "#42355054"
                : control.hovered ? "#34ffffff"
                : "#26ffffff"
            border.color: control.activeFocus ? root.accentBlue : "#3dffffff"
            border.width: control.activeFocus ? 2 : 1

            Behavior on color {
                ColorAnimation { duration: 100 }
            }
        }

        delegate: QQC2.ItemDelegate {
            id: option
            width: control.width
            height: 40
            text: typeof name !== "undefined" ? name : modelData
            font: control.font
            highlighted: control.highlightedIndex === index

            contentItem: Text {
                text: option.text
                color: root.primaryText
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                font: option.font
            }

            background: Rectangle {
                radius: 9
                color: option.highlighted ? "#5239d98a" : "transparent"
            }
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
                radius: 14
                color: "#f0162024"
                border.color: "#4dffffff"
                border.width: 1
            }
        }
    }
}
