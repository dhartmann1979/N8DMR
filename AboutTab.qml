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

Item {
	id: aboutTab
	Rectangle{
		id: helpText
		x: 20
		y: 20
		width: parent.width - 40
		height: parent.height - 40
		color: "#121a2a"
		Flickable{
			anchors.fill: parent
			contentWidth: parent.width
			contentHeight: aboutText.y + aboutText.height
			flickableDirection: Flickable.VerticalFlick
			clip: true
			Text {
				id: aboutText
				width: helpText.width
				wrapMode: Text.WordWrap
				color: "white"
				text: qsTr(	"\nN8DMR · DMR-Sprechfunk am PC\nGit build:\t" + droidstar.get_software_build() +
						   "\nPlatform:\t" + droidstar.get_platform() +
						   "\nQt version:\t" + droidstar.get_qt_version() +
						   "\nArch:\t" + droidstar.get_arch() +
						   "\nBuild ABI:\t" + droidstar.get_build_abi() +
						   "\n\nN8DMR basiert auf dem Open-Source-Projekt DroidStar von Doug McLain (AD8DP)." +
						   "\nUpstream: https://github.com/nostar/DroidStar" +
						   "\nN8DMR-Projekt: https://github.com/dhartmann1979/N8DMR" +
						   "\n\nCopyright (C) 2019-2026 Doug McLain AD8DP\n" +
							"This program is free software; " +
							"you can redistribute it and/or modify it under the terms of the GNU General " +
							"Public License as published by the Free Software Foundation; version 3 or later.\n\n" +
							"This program is distributed in the hope that it will be useful, but WITHOUT " +
							"ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS " +
							"FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.\n\n" +
							"You should have received a copy of the GNU General Public License along with this " +
							"program. If not, see <http://www.gnu.org/licenses/>")
			}
		}
	}
}
