/*
	Copyright (C) 2019-2021 Doug McLain

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import org.die.n8schicht.n8dmr

ApplicationWindow {
    id: main
	visible: true
	width: 1280
	height: 820
	minimumWidth: 1060
	minimumHeight: 680
	title: qsTr("N8DMR · Die N8schicht")
	color: "#0b1020"
	font.family: "Noto Sans"
	font.pixelSize: 13

	palette.window: "#0b1020"
	palette.button: "#182238"
	palette.buttonText: "#e8edf7"
	palette.base: "#11192a"
	palette.text: "#e8edf7"
	palette.windowText: "#e8edf7"
	palette.highlight: "#e0c34b"

	MessageDialog {
		id: errorDialog
		title: "Error"
	}
	MessageDialog {
		id: updateDialog
		title: "Updating..."
		text: "Check log tab for details"
	}
	MessageDialog {
		id: vocoderDialog
		title: "Kein DMR-Sprachcodec gefunden"
		text: "Du kannst dich verbinden, aber ohne Software-Vocoder oder AMBE-Hardware werden weder Empfang noch Aussendung von Sprache funktionieren. Prüfe unter Einstellungen den ausgewählten Vocoder."
	}

	Rectangle {
		id: header
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.right: parent.right
		height: 66
		color: "#0e1526"
		border.color: "#202b40"
		Image {
			id: brandIcon
			source: "qrc:/assets/n8schicht-icon.png"
			x: 22
			anchors.verticalCenter: parent.verticalCenter
			width: 38
			height: 38
		}
		Text {
			x: brandIcon.x + brandIcon.width + 11
			anchors.verticalCenter: parent.verticalCenter
			text: "N8DMR"
			font.pixelSize: 19
			font.bold: true
			color: "#f0f3fa"
		}
		Text {
			x: 137
			anchors.verticalCenter: parent.verticalCenter
			text: "DIE N8SCHICHT"
			font.pixelSize: 9
			font.bold: true
			font.letterSpacing: 1.2
			color: "#8491a9"
		}
		Rectangle {
			x: parent.width - statusText.width - 54
			anchors.verticalCenter: parent.verticalCenter
			width: 7; height: 7; radius: 4
			color: mainTab.connectbutton.text === "Disconnect" ? "#42d6a1" : "#e0bd47"
		}
		Text {
			id: statusText
			anchors.right: parent.right
			anchors.rightMargin: 24
			anchors.verticalCenter: parent.verticalCenter
			text: mainTab.connectbutton.text === "Disconnect" ? "Mit DMR-Netz verbunden" : "Nicht verbunden"
			font.pixelSize: 11
			color: "#aab5ca"
		}
	}

	Item {
		id: bar
		x: 12
		y: 84
		width: 206
		height: parent.height - 104
		property int currentIndex: 0
		Column {
			anchors.fill: parent
			spacing: 5
		Button {
			id: mainButton
			width: parent.width; height: 42
			text: qsTr("◉   Funkbetrieb")
			background: Rectangle { radius: 8; color: bar.currentIndex === 0 ? "#242b3c" : "transparent"; border.color: bar.currentIndex === 0 ? "#4e492e" : "transparent" }
			contentItem: Text { text: mainButton.text; font: mainButton.font; color: bar.currentIndex === 0 ? "#f1d45c" : "#a1acc0"; verticalAlignment: Text.AlignVCenter; leftPadding: 16 }
			onClicked: bar.currentIndex = 0
		}
		Button {
			id: settingsButton
			width: parent.width; height: 42
			text: qsTr("⚙   Einstellungen")
			background: Rectangle { radius: 8; color: bar.currentIndex === 1 ? "#242b3c" : "transparent" }
			contentItem: Text { text: settingsButton.text; font: settingsButton.font; color: bar.currentIndex === 1 ? "#f1d45c" : "#a1acc0"; verticalAlignment: Text.AlignVCenter; leftPadding: 16 }
			onClicked: bar.currentIndex = 1
		}
		Button {
			id: logButton
			width: parent.width; height: 42
			text: qsTr("≋   Funkprotokoll")
			background: Rectangle { radius: 8; color: bar.currentIndex === 2 ? "#242b3c" : "transparent" }
			contentItem: Text { text: logButton.text; font: logButton.font; color: bar.currentIndex === 2 ? "#f1d45c" : "#a1acc0"; verticalAlignment: Text.AlignVCenter; leftPadding: 16 }
			onClicked: bar.currentIndex = 2
		}
		Button {
			id: hostsButton
			width: parent.width; height: 42
			text: qsTr("⌁   DMR-Server")
			background: Rectangle { radius: 8; color: bar.currentIndex === 3 ? "#242b3c" : "transparent" }
			contentItem: Text { text: hostsButton.text; font: hostsButton.font; color: bar.currentIndex === 3 ? "#f1d45c" : "#a1acc0"; verticalAlignment: Text.AlignVCenter; leftPadding: 16 }
			onClicked: bar.currentIndex = 3
		}
		Button {
			id: aboutButton
			width: parent.width; height: 42
			text: qsTr("ⓘ   Über N8DMR")
			background: Rectangle { radius: 8; color: bar.currentIndex === 4 ? "#242b3c" : "transparent" }
			contentItem: Text { text: aboutButton.text; font: aboutButton.font; color: bar.currentIndex === 4 ? "#f1d45c" : "#a1acc0"; verticalAlignment: Text.AlignVCenter; leftPadding: 16 }
			onClicked: bar.currentIndex = 4
		}
		}
	}
	SwipeView {
		id: swiper
		x: 230
		y: 76
		width: parent.width - 250
		height: parent.height - 91
		currentIndex: bar.currentIndex
		interactive: false

		MainTab{
			id: mainTab
		}
		SettingsTab{
			id: settingsTab
		}
		LogTab{
			id: logTab
		}
		HostsTab{
			id: hostsTab
		}
		AboutTab{}
	}
	Text {
		anchors.left: parent.left
		anchors.leftMargin: 23
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 16
		text: "N8DMR  ·  DMR-Sprachclient"
		font.pixelSize: 9
		color: "#5e6b83"
	}
	DroidStar {
		id: droidstar
	}

	Connections {
		target: droidstar
		Component.onCompleted: {
			mainTab.comboMode.loaded = true;
			droidstar.process_settings();
			droidstar.process_mode_change("DMR");
			droidstar.set_protocol("DMR");
			settingsTab.comboVocoder.model = droidstar.get_vocoders();
			settingsTab.comboModem.model = droidstar.get_modems();
			settingsTab.comboPlayback.model = droidstar.get_playbacks();
			settingsTab.comboCapture.model = droidstar.get_captures();
			mainTab.data1.font.family = droidstar.get_monofont();
			mainTab.data2.font.family = droidstar.get_monofont();
			mainTab.data3.font.family = droidstar.get_monofont();
			mainTab.data4.font.family = droidstar.get_monofont();
			mainTab.data5.font.family = droidstar.get_monofont();
			mainTab.data6.font.family = droidstar.get_monofont();
		}
		function onSwtx_state(s){
			mainTab.swtxBox.checked = s;
			mainTab.swtxBox.enabled = !s;
		}
		function onSwrx_state(s){
			mainTab.swrxBox.checked = s;
			mainTab.swrxBox.enabled = !s;
		}
		function onMycall_changed(s){
			settingsTab.mycallEdit.text = s;
		}
		function onUrcall_changed(s){
			settingsTab.urcallEdit.text = s;
		}
		function onRptr1_changed(s){
			settingsTab.rptr1Edit.text = s;
		}
		function onRptr2_changed(s){
			settingsTab.rptr2Edit.text = s;
		}
		function onUpdate_devices(){
			settingsTab.comboVocoder.model = droidstar.get_vocoders();
			settingsTab.comboModem.model = droidstar.get_modems();
			settingsTab.comboPlayback.model = droidstar.get_playbacks();
			settingsTab.comboCapture.model = droidstar.get_captures();
		}

		function onMode_changed() {
			mainTab.comboHost.model = droidstar.get_hosts();
			droidstar.set_modelchange(true);
			mainTab.comboHost.currentIndex = mainTab.comboHost.find(droidstar.get_dmr_host());
			droidstar.set_modelchange(false);
			mainTab.comboMode.currentIndex = mainTab.comboMode.find("DMR");
			mainTab.comboHost.visible = true;
			mainTab.comboSlot.visible = true;
			mainTab.comboCC.visible = true;
			mainTab.element3.visible = false;
			mainTab.dmrtgidEdit.visible = true;
			mainTab.comboM17CAN.visible = false;
			mainTab.privateBox.visible = true;
			mainTab.sliderMicGain.value = 0.5;
			mainTab.dtmflabel.visible = false;
			mainTab.editIAXDTMF.visible = false;
			mainTab.dtmfsendbutton.visible = false;
			logTab.smsedit.visible = false;
			logTab.smsSendButton.visible = false;
		}
		function onUpdate_data() {
			mainTab.data1.text = droidstar.get_data1();
			mainTab.data2.text = droidstar.get_data2();
			mainTab.data3.text = droidstar.get_data3();
			mainTab.data4.text = droidstar.get_data4();
			mainTab.data5.text = droidstar.get_data5();
			mainTab.data6.text = droidstar.get_data6();
			mainTab.ambestatus.text = droidstar.get_ambestatustxt();
			mainTab.mmdvmstatus.text = droidstar.get_mmdvmstatustxt();
			mainTab.netstatus.text = droidstar.get_netstatustxt();
			++mainTab.uitimer.rxcnt;
		}
		function onUpdate_settings() {
			//console.log("update_settings comboHost == ", mainTab.comboHost.find(droidstar.get_host()));
			//console.log("update_settings comboModule == ", mainTab.comboModule.find(droidstar.get_module()));
			settingsTab.ipv6.checked = droidstar.get_ipv6();
			settingsTab.xrf2ref.checked = droidstar.get_xrf2ref();
			settingsTab.toggleTX.checked = droidstar.get_toggletx();
			if(droidstar.get_mode() === "REF"){
				mainTab.comboHost.currentIndex = mainTab.comboHost.find(droidstar.get_ref_host());
			}
			if(droidstar.get_mode() === "DCS"){
				mainTab.comboHost.currentIndex = mainTab.comboHost.find(droidstar.get_dcs_host());
			}
			if(droidstar.get_mode() === "XRF"){
				mainTab.comboHost.currentIndex = mainTab.comboHost.find(droidstar.get_xrf_host());
			}
			if(droidstar.get_mode() === "YSF"){
				mainTab.comboHost.currentIndex = mainTab.comboHost.find(droidstar.get_ysf_host());
			}
			if(droidstar.get_mode() === "FCS"){
				mainTab.comboHost.currentIndex = mainTab.comboHost.find(droidstar.get_fcs_host());
			}
			if(droidstar.get_mode() === "DMR"){
				mainTab.comboHost.currentIndex = mainTab.comboHost.find(droidstar.get_dmr_host());
			}
			if(droidstar.get_mode() === "P25"){
				mainTab.comboHost.currentIndex = mainTab.comboHost.find(droidstar.get_p25_host());
			}
			if(droidstar.get_mode() === "NXDN"){
				mainTab.comboHost.currentIndex = mainTab.comboHost.find(droidstar.get_nxdn_host());
			}
			if(droidstar.get_mode() === "M17"){
				mainTab.comboHost.currentIndex = mainTab.comboHost.find(droidstar.get_m17_host());
			}
			if(droidstar.get_mode() === "IAX"){
				mainTab.comboHost.currentIndex = mainTab.comboHost.find(droidstar.get_iax_host());
			}
			mainTab.comboModule.currentIndex = mainTab.comboModule.find(droidstar.get_module());
			settingsTab.callsignEdit.text = droidstar.get_callsign();
			settingsTab.dmridEdit.text = droidstar.get_dmrid();
			settingsTab.comboEssid.currentIndex = settingsTab.comboEssid.find(droidstar.get_essid());
			settingsTab.bmpwEdit.text = droidstar.get_bm_password();
			settingsTab.tgifpwEdit.text = droidstar.get_tgif_password();
			settingsTab.adnpwEdit.text = droidstar.get_adn_password();
			settingsTab.aslpwEdit.text = droidstar.get_asl_password();
			settingsTab.latEdit.text = droidstar.get_latitude();
			settingsTab.lonEdit.text = droidstar.get_longitude();
			settingsTab.locEdit.text = droidstar.get_location();
			settingsTab.descEdit.text = droidstar.get_description();
			settingsTab.urlEdit.text = droidstar.get_url();
			settingsTab.swidEdit.text = droidstar.get_swid();
			settingsTab.pkgidEdit.text = droidstar.get_pkgid();
			settingsTab.dmroptsEdit.text = droidstar.get_dmr_options();
			mainTab.dmrtgidEdit.text = droidstar.get_dmrtgid();
			settingsTab.mycallEdit.text = droidstar.get_mycall();
			settingsTab.urcallEdit.text = droidstar.get_urcall();
			settingsTab.rptr1Edit.text = droidstar.get_rptr1();
			settingsTab.rptr2Edit.text = droidstar.get_rptr2();
			settingsTab.txtimerEdit.text = droidstar.get_txtimeout();

			settingsTab.modemRXFreqEdit.text = droidstar.get_modemRxFreq();
			settingsTab.modemTXFreqEdit.text = droidstar.get_modemTxFreq();
			settingsTab.modemRXOffsetEdit.text = droidstar.get_modemRxOffset();
			settingsTab.modemTXOffsetEdit.text = droidstar.get_modemTxOffset();
			settingsTab.modemRXDCOffsetEdit.text = droidstar.get_modemRxDCOffset();
			settingsTab.modemTXDCOffsetEdit.text = droidstar.get_modemTxDCOffset();
			settingsTab.modemRXLevelEdit.text = droidstar.get_modemRxLevel();
			settingsTab.modemTXLevelEdit.text = droidstar.get_modemTxLevel();
			settingsTab.modemRFLevelEdit.text = droidstar.get_modemRFLevel();
			settingsTab.modemTXDelayEdit.text = droidstar.get_modemTxDelay();
			settingsTab.modemCWIdTXLevelEdit.text = droidstar.get_modemCWIdTxLevel();
			settingsTab.modemDStarTXLevelEdit.text = droidstar.get_modemDstarTxLevel();
			settingsTab.modemDMRTXLevelEdit.text = droidstar.get_modemDMRTxLevel();
			settingsTab.modemYSFTXLevelEdit.text = droidstar.get_modemYSFTxLevel();
			settingsTab.modemP25TXLevelEdit.text = droidstar.get_modemP25TxLevel()
			settingsTab.modemNXDNTXLevelEdit.text = droidstar.get_modemNXDNTxLevel();
			settingsTab.modemBaudEdit.text = droidstar.get_modemBaud();

			hostsTab.hostsTextEdit.text = droidstar.get_local_hosts();
		}
		function onUpdate_log(s) {
			logTab.logText.append(s);
		}
		function onOpen_vocoder_dialog() {
			vocoderDialog.open();
		}

		function onConnect_status_changed(c) {
			if(c === 0){
				if(mainTab.buttonTX.tx){
					mainTab.buttonTX.tx = false;
					droidstar.tx_clicked(false);
					mainTab.txtimer.running = false;
					
					
				}
				mainTab.connectbutton.text = "Connect";
				mainTab.comboMode.enabled = true;
				mainTab.comboHost.enabled = true;
				mainTab.comboModule.enabled = true;
				mainTab.buttonTX.enabled = false;
				
				mainTab.data1.text = "";
				mainTab.data2.text = "";
				mainTab.data3.text = "";
				mainTab.data4.text = "";
				mainTab.data5.text = "";
				mainTab.data6.text = "";
				mainTab.netstatus.text = "Not connected";
			}
			if(c === 1){
				mainTab.connectbutton.text = "Connecting";
				mainTab.comboMode.enabled = false;
				mainTab.comboHost.enabled = false;
				if(mainTab.comboMode.currentText != "REF"){
					mainTab.comboModule.enabled = false;
				}
				droidstar.set_debug(settingsTab.debugBox.checked);
			}
			if(c === 2){
				mainTab.connectbutton.text = "Disconnect";
				mainTab.comboMode.enabled = false;
				mainTab.comboHost.enabled = false;

				if(mainTab.comboMode.currentText != "REF"){
					mainTab.comboModule.enabled = false;
				}
				if(mainTab.comboMode.currentText === "YSF"){
					settingsTab.m171600.checked = true;
				}
				if(mainTab.comboMode.currentText === "FCS"){
					settingsTab.m171600.checked = true;
				}
				if(mainTab.comboMode.currentText === "M17"){
					if(settingsTab.mmdvmBox.checked){
						mainTab.comboModule.enabled = true;
						mainTab.comboHost.enabled = true;
					}

					settingsTab.m173200.checked = true;
				}

				mainTab.buttonTX.enabled = true;
				
				mainTab.agcBox.checked = true;
			}
			if(c === 3){
			}
			if(c === 4){
				idcheckDialog.open();
				onConnect_status_changed(0);
			}
			if(c === 5){
				errorDialog.text = droidstar.get_error_text();
				if(errorDialog.text == ""){
					errorDialog.text = "Banned!"
				}
				errorDialog.open();
				droidstar.connect_status_changed(0);
			}
		}
	}
}
