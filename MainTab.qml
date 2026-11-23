/*
    N8DMR desktop control panel.
    DMR network/audio operations are provided by the GPL-3.0 DroidStar engine.
*/
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: mainTab
    property alias comboMode: modeSelect
    property alias comboHost: hostSelect
    property alias comboModule: moduleSelect
    property alias comboSlot: slotSelect
    property alias comboCC: colorCodeSelect
    property alias comboM17CAN: canSelect
    property alias dmrtgidEdit: talkgroupField
    property alias privateBox: privateCall
    property alias connectbutton: connectButton
    property alias buttonTX: pttButton
    property alias btntxt: pttText
    property alias sliderMicGain: micGain
    property alias data1: infoCallsign
    property alias data2: infoSource
    property alias data3: infoDestination
    property alias data4: infoGateway
    property alias data5: infoStatus
    property alias data6: infoExtra
    property alias label1: hiddenLabel1
    property alias label2: hiddenLabel2
    property alias label3: hiddenLabel3
    property alias label4: hiddenLabel4
    property alias label5: hiddenLabel5
    property alias label6: hiddenLabel6
    property alias element3: hiddenLabel3
    property alias ambestatus: vocoderStatus
    property alias mmdvmstatus: modemStatus
    property alias netstatus: networkStatus
    property alias swtxBox: softwareTx
    property alias swrxBox: softwareRx
    property alias agcBox: agcControl
    property alias dtmflabel: hiddenDtmfLabel
    property alias editIAXDTMF: hiddenDtmfEdit
    property alias dtmfsendbutton: hiddenDtmfSend
    property alias txtimer: txTimer
    property alias uitimer: uiTimer
    property int rows: 18
    property bool tts: false

    ComboBox { id: modeSelect
        model: ["DMR"]
        currentIndex: 0
        visible: false
        property bool loaded: false
        onCurrentTextChanged: if (loaded) droidstar.process_mode_change(currentText) }
    ComboBox { id: moduleSelect
        model: ["A"]
        currentIndex: 0
        visible: false }
    ComboBox { id: canSelect
        model: ["1"]
        currentIndex: 0
        visible: false }
    CheckBox { id: softwareTx
        visible: false }
    CheckBox { id: softwareRx
        visible: false }
    CheckBox { id: agcControl
        visible: false
        checked: true }
    Text { id: hiddenLabel1
        visible: false }
    Text { id: hiddenLabel2
        visible: false }
    Text { id: hiddenLabel3
        visible: false }
    Text { id: hiddenLabel4
        visible: false }
    Text { id: hiddenLabel5
        visible: false }
    Text { id: hiddenLabel6
        visible: false }
    Text { id: hiddenDtmfLabel
        visible: false }
    TextField { id: hiddenDtmfEdit
        visible: false }
    Button { id: hiddenDtmfSend
        visible: false }
    Timer { id: txTimer
        interval: 1000
        repeat: true
        running: false }
    Timer {
        id: uiTimer
        interval: 25
            repeat: true
            running: true
        property int rxcnt: 0
        property int lastRxcnt: 0
        property int ticks: 0
        onTriggered: {
            ticks++
            if (ticks > 12) {
                if (rxcnt === lastRxcnt) outputBar.width = Math.max(0, outputBar.width - 10)
                lastRxcnt = rxcnt
                ticks = 0
            }
            const targetWidth = (outputTrack.width - 4) * droidstar.get_output_level() / 32767.0
            outputBar.width = targetWidth > outputBar.width ? targetWidth : Math.max(0, outputBar.width - 5)
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 22
        spacing: 16

        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 52
            ColumnLayout {
                spacing: 3
                Text { text: "DMR-SPRECHFUNK"
                    color: "#f1d45c"
                    font.pixelSize: 10
                    font.bold: true
                    font.letterSpacing: 1.4 }
                Text { text: "Funkplatz"
                    color: "#edf1fa"
                    font.pixelSize: 23
                    font.bold: true }
            }
            Item { Layout.fillWidth: true }
            Rectangle {
                radius: 18
                    color: "#15291f"
                    border.color: "#28533f"
                    implicitWidth: 126
                    implicitHeight: 29
                RowLayout {
                    anchors.centerIn: parent
                        spacing: 7
                    Rectangle { width: 7
                        height: 7
                        radius: 4
                        color: "#4dd29c" }
                    Text { text: connectButton.text === "Disconnect" ? "VERBUNDEN" : connectButton.text === "Connecting" ? "VERBINDET …" : "BEREIT"
                        color: "#77dcb5"
                        font.pixelSize: 9
                        font.bold: true
                        font.letterSpacing: .6 }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 14

            Rectangle {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumWidth: 410
                radius: 12
                    color: "#111a2a"
                    border.color: "#263149"
                ColumnLayout {
                    anchors.fill: parent
                        anchors.margins: 19
                        spacing: 13
                    RowLayout {
                        Layout.fillWidth: true
                        Text { text: "NETZWERK"
                            color: "#8592a9"
                            font.pixelSize: 9
                            font.bold: true
                            font.letterSpacing: 1.0 }
                        Item { Layout.fillWidth: true }
                        Text { text: "HOME BREW / MMDVM"
                            color: "#8494b4"
                            font.pixelSize: 8
                            font.bold: true
                            letterSpacing: .6 }
                    }
                    ComboBox {
                        id: hostSelect
                        Layout.fillWidth: true
                            Layout.preferredHeight: 42
                        model: []
                        currentIndex: -1
                        displayText: currentIndex < 0 ? "DMR-Server auswählen …" : currentText
                        font.pixelSize: 12
                        onCurrentTextChanged: if (!droidstar.get_modelchange() && currentText !== "") droidstar.process_host_change(currentText)
                    }
                    Rectangle { Layout.fillWidth: true
                        height: 1
                        color: "#263149" }
                    RowLayout {
                        Layout.fillWidth: true
                        Text { text: "SPRECHGRUPPE"
                            color: "#8592a9"
                            font.pixelSize: 9
                            font.bold: true
                            font.letterSpacing: 1.0 }
                        Item { Layout.fillWidth: true }
                        Text { text: "ZEITSCHLITZ"
                            color: "#8592a9"
                            font.pixelSize: 9
                            font.bold: true
                            font.letterSpacing: .8 }
                    }
                    RowLayout {
                        Layout.fillWidth: true
                            spacing: 9
                        TextField {
                            id: talkgroupField
                            Layout.fillWidth: true
                                Layout.preferredHeight: 45
                            text: "265"
                            font.pixelSize: 21
                                font.bold: true
                            color: "#f1d45c"
                            validator: IntValidator { bottom: 1
                                top: 16777215 }
                            selectByMouse: true
                            background: Rectangle { radius: 7
                                color: "#0b1220"
                                border.color: talkgroupField.activeFocus ? "#d0b64b" : "#303c54" }
                        }
                        ComboBox {
                            id: slotSelect
                            Layout.preferredWidth: 95
                                Layout.preferredHeight: 45
                            model: ["TS1", "TS2"]
                                currentIndex: 1
                            font.pixelSize: 12
                                font.bold: true
                            onCurrentIndexChanged: droidstar.set_slot(currentIndex)
                        }
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        Text { text: "COLOR CODE"
                            color: "#8592a9"
                            font.pixelSize: 9
                            font.bold: true
                            font.letterSpacing: .8 }
                        ComboBox {
                            id: colorCodeSelect
                            Layout.preferredWidth: 92
                                Layout.preferredHeight: 34
                            model: ["CC0", "CC1", "CC2", "CC3", "CC4", "CC5", "CC6", "CC7", "CC8", "CC9", "CC10", "CC11", "CC12", "CC13", "CC14", "CC15"]
                            currentIndex: 1
                            onCurrentIndexChanged: droidstar.set_cc(currentIndex)
                        }
                        Item { Layout.fillWidth: true }
                        CheckBox { id: privateCall
                            text: "Privater Ruf"
                            font.pixelSize: 10
                            onClicked: droidstar.set_dmr_pc(checked) }
                    }
                    Rectangle { Layout.fillWidth: true
                        height: 1
                        color: "#263149" }
                    RowLayout {
                        Layout.fillWidth: true
                        Text { text: "DEIN RUFZEICHEN"
                            color: "#8592a9"
                            font.pixelSize: 9
                            font.bold: true
                            font.letterSpacing: .8 }
                        Item { Layout.fillWidth: true }
                        Text { text: "DMR-ID"
                            color: "#8592a9"
                            font.pixelSize: 9
                            font.bold: true
                            font.letterSpacing: .8 }
                    }
                    RowLayout {
                        Layout.fillWidth: true
                        Text { text: settingsTab.callsignEdit.text || "In Einstellungen eintragen"
                            color: "#e6ebf6"
                            font.pixelSize: 12
                            font.bold: true }
                        Item { Layout.fillWidth: true }
                        Text { text: settingsTab.dmridEdit.text || "—"
                            color: "#b5c0d4"
                            font.pixelSize: 12
                            font.family: "monospace" }
                    }
                    Item { Layout.fillHeight: true
                        Layout.minimumHeight: 0 }
                    Button {
                        id: connectButton
                        Layout.fillWidth: true
                            Layout.preferredHeight: 43
                        text: "Connect"
                        font.pixelSize: 12
                            font.bold: true
                        contentItem: Text { text: connectButton.text === "Connect" ? "Mit DMR-Netz verbinden" : connectButton.text === "Disconnect" ? "Verbindung trennen" : "Verbinde …"
                            color: "#101625"
                            font: connectButton.font
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter }
                        background: Rectangle { radius: 7
                            color: connectButton.text === "Disconnect" ? "#d7bd4a" : "#e5cc59" }
                        onClicked: {
                            if (text === "Connect" && (settingsTab.callsignEdit.text.trim() === "" || settingsTab.dmridEdit.text.trim() === "")) {
                                errorDialog.text = qsTr("Bitte zuerst Rufzeichen und DMR-ID in den Einstellungen eintragen."); errorDialog.open(); return
                            }
                            if (text === "Connect" && (hostSelect.currentText === "" || talkgroupField.text.trim() === "")) {
                                errorDialog.text = qsTr("Bitte DMR-Server und Talkgroup auswählen.")
                                    errorDialog.open()
                                    return
                            }
                            if (text === "Connect" && hostSelect.currentText.indexOf("FreeDMR") === 0 && settingsTab.adnpwEdit.text.trim() === "") {
                                errorDialog.text = qsTr("Für den N8schicht-FreeDMR-Server benötigst du dein FreeRadioID-Passwort. Trage es in den Einstellungen ein.")
                                    errorDialog.open()
                                    return
                            }
                            droidstar.set_callsign(settingsTab.callsignEdit.text.toUpperCase())
                            droidstar.set_module("A")
                            droidstar.set_protocol("DMR")
                            droidstar.set_dmrtgid(talkgroupField.text)
                            droidstar.set_dmrid(settingsTab.dmridEdit.text)
                            droidstar.set_essid(settingsTab.comboEssid.currentText)
                            droidstar.set_bm_password(settingsTab.bmpwEdit.text)
                            droidstar.set_tgif_password(settingsTab.tgifpwEdit.text)
                            droidstar.set_adn_password(settingsTab.adnpwEdit.text)
                            droidstar.set_asl_password(settingsTab.aslpwEdit.text)
                            droidstar.set_latitude(settingsTab.latEdit.text)
                            droidstar.set_longitude(settingsTab.lonEdit.text)
                            droidstar.set_location(settingsTab.locEdit.text)
                            droidstar.set_description(settingsTab.descEdit.text)
                            droidstar.set_url(settingsTab.urlEdit.text)
                            droidstar.set_swid(settingsTab.swidEdit.text)
                            droidstar.set_pkgid(settingsTab.pkgidEdit.text)
                            droidstar.set_dmr_options(settingsTab.dmroptsEdit.text)
                            droidstar.set_dmr_pc(privateCall.checked)
                            droidstar.set_txtimeout(settingsTab.txtimerEdit.text)
                            droidstar.set_ipv6(settingsTab.ipv6.checked)
                            droidstar.set_vocoder(settingsTab.comboVocoder.currentText)
                            droidstar.set_modem(settingsTab.comboModem.currentText)
                            droidstar.set_playback(settingsTab.comboPlayback.currentText)
                            droidstar.set_capture(settingsTab.comboCapture.currentText)
                            droidstar.set_modemRxFreq(settingsTab.modemRXFreqEdit.text)
                            droidstar.set_modemTxFreq(settingsTab.modemTXFreqEdit.text)
                            droidstar.set_modemRxOffset(settingsTab.modemRXOffsetEdit.text)
                            droidstar.set_modemTxOffset(settingsTab.modemTXOffsetEdit.text)
                            droidstar.set_modemRxDCOffset(settingsTab.modemRXDCOffsetEdit.text)
                            droidstar.set_modemTxDCOffset(settingsTab.modemTXDCOffsetEdit.text)
                            droidstar.set_modemRxLevel(settingsTab.modemRXLevelEdit.text)
                            droidstar.set_modemTxLevel(settingsTab.modemTXLevelEdit.text)
                            droidstar.set_modemRFLevel(settingsTab.modemRFLevelEdit.text)
                            droidstar.set_modemTxDelay(settingsTab.modemTXDelayEdit.text)
                            droidstar.process_connect()
                        }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: false
                    Layout.preferredWidth: 300
                    Layout.fillHeight: true
                radius: 12
                    color: "#121b2d"
                    border.color: "#29344b"
                ColumnLayout {
                    anchors.fill: parent
                        anchors.margins: 18
                        spacing: 14
                    RowLayout {
                        Layout.fillWidth: true
                        Text { text: "SPRECHTASTE"
                            color: "#8592a9"
                            font.pixelSize: 9
                            font.bold: true
                            font.letterSpacing: 1.0 }
                        Item { Layout.fillWidth: true }
                        Text { text: "LEERTASTE"
                            color: "#697991"
                            font.pixelSize: 8
                            font.bold: true }
                    }
                    Item {
                        Layout.fillWidth: true
                            Layout.fillHeight: true
                            Layout.minimumHeight: 140
                        Rectangle { anchors.centerIn: parent
                            width: 158
                            height: 158
                            radius: 80
                            color: "#161f36"
                            border.width: 1
                            border.color: pttButton.down ? "#e5c83e" : "#273754" }
                        Rectangle { anchors.centerIn: parent
                            width: 120
                            height: 120
                            radius: 60
                            color: pttButton.down ? "#e2c647" : "#202c48"
                            border.width: 2
                            border.color: pttButton.down ? "#ffeb82" : "#415577" }
                        Text { anchors.centerIn: parent
                            text: pttButton.down ? "●" : "◉"
                            font.pixelSize: 48
                            color: pttButton.down ? "#171b25" : "#8cb9e5" }
                    }
                    Button {
                        id: pttButton
                        Layout.fillWidth: true
                            Layout.preferredHeight: 56
                        property bool tx: down
                        enabled: connectButton.text === "Disconnect"
                        background: Rectangle { radius: 8
                            color: !pttButton.enabled ? "#263047" : pttButton.down ? "#e5c83e" : "#293a5b"
                            border.color: pttButton.enabled ? "#465b7b" : "#30384a" }
                        contentItem: Text { id: pttText
                            text: pttButton.down ? "SENDEN …" : "ZUM SENDEN HALTEN"
                            color: !pttButton.enabled ? "#717d92" : pttButton.down ? "#101624" : "#ecf1fb"
                            font.pixelSize: 10
                            font.bold: true
                            font.letterSpacing: .7
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter }
                        onPressed: if (!settingsTab.toggleTX.checked) droidstar.press_tx()
                        onReleased: if (!settingsTab.toggleTX.checked) droidstar.release_tx()
                        onCanceled: if (!settingsTab.toggleTX.checked) droidstar.release_tx()
                    }
                    RowLayout { Layout.fillWidth: true
                        Text { text: "EINGANGSPEGEL"
                        color: "#8190a8"
                        font.pixelSize: 8
                        font.bold: true
                        font.letterSpacing: .8 }
                        Item { Layout.fillWidth: true }
                        Text { text: Math.round(micGain.value * 100) + "%"
                        color: "#c6cfdf"
                        font.pixelSize: 9 } }
                    Slider { id: micGain
                        Layout.fillWidth: true
                        from: 0
                        to: 1
                        value: 0.5
                        onMoved: droidstar.set_input_volume(value) }
                    Rectangle {
                        id: outputTrack
                        Layout.fillWidth: true
                            height: 6
                            radius: 3
                            color: "#202b41"
                        Rectangle { id: outputBar
                            width: 0
                            height: parent.height
                            radius: 3
                            color: "#51d4a2" }
                    }
                    RowLayout { Layout.fillWidth: true
                        Text { text: "RX"
                        color: "#8794a9"
                        font.pixelSize: 8
                        font.bold: true }
                        Item { Layout.fillWidth: true }
                        Text { text: "TX"
                        color: "#8794a9"
                        font.pixelSize: 8
                        font.bold: true } }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
                Layout.preferredHeight: 126
            radius: 12
                color: "#111a2a"
                border.color: "#263149"
            ColumnLayout {
                anchors.fill: parent
                    anchors.margins: 15
                    spacing: 10
                RowLayout { Layout.fillWidth: true
                    Text { text: "LETZTE DMR-ÜBERTRAGUNG"
                    color: "#8794aa"
                    font.pixelSize: 9
                    font.bold: true
                    font.letterSpacing: .9 }
                    Item { Layout.fillWidth: true }
                    Text { text: "LIVE-STATUS"
                    color: "#8794aa"
                    font.pixelSize: 9
                    font.bold: true
                    font.letterSpacing: .9 } }
                RowLayout {
                    Layout.fillWidth: true
                        Layout.fillHeight: true
                        spacing: 18
                    ColumnLayout { Layout.fillWidth: true
                        spacing: 3
                        Text { text: "Rufzeichen"
                        color: "#718099"
                        font.pixelSize: 8 }
                        Text { id: infoCallsign
                        text: "—"
                        color: "#e5eaf4"
                        font.pixelSize: 11
                        font.bold: true } }
                    ColumnLayout { Layout.fillWidth: true
                        spacing: 3
                        Text { text: "Quell-ID"
                        color: "#718099"
                        font.pixelSize: 8 }
                        Text { id: infoSource
                        text: "—"
                        color: "#e5eaf4"
                        font.pixelSize: 11
                        font.family: "monospace" } }
                    ColumnLayout { Layout.fillWidth: true
                        spacing: 3
                        Text { text: "Ziel / TG"
                        color: "#718099"
                        font.pixelSize: 8 }
                        Text { id: infoDestination
                        text: "—"
                        color: "#e5eaf4"
                        font.pixelSize: 11
                        font.family: "monospace" } }
                    ColumnLayout { Layout.fillWidth: true
                        spacing: 3
                        Text { text: "Master / Gateway"
                        color: "#718099"
                        font.pixelSize: 8 }
                        Text { id: infoGateway
                        text: "—"
                        color: "#e5eaf4"
                        font.pixelSize: 11 } }
                    ColumnLayout { Layout.fillWidth: true
                        spacing: 3
                        Text { text: "Netzwerk"
                        color: "#718099"
                        font.pixelSize: 8 }
                        Text { id: networkStatus
                        text: "Nicht verbunden"
                        color: "#e5eaf4"
                        font.pixelSize: 10 } }
                    ColumnLayout { Layout.fillWidth: true
                        spacing: 3
                        Text { text: "Vocoder / Modem"
                        color: "#718099"
                        font.pixelSize: 8 }
                        RowLayout { Text { id: vocoderStatus
                        text: "Vocoder bereit"
                        color: "#aebbd0"
                        font.pixelSize: 9 }
                        Text { text: "·"
                        color: "#53627c" }
                        Text { id: modemStatus
                        text: "Kein Hotspot"
                        color: "#aebbd0"
                        font.pixelSize: 9 } } }
                    Text { id: infoExtra
                        visible: false }
                }
            }
        }
    }
}
