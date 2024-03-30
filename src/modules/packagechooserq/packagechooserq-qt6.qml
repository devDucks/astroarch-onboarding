/* === This file is part of Calamares - <https://calamares.io> ===
 *
 *   SPDX-FileCopyrightText: 2021 Anke Boersma <demm@kaosx.us>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 *
 *   Calamares is Free Software: see the License-Identifier above.
 *
 */

import io.calamares.core 1.0
import io.calamares.ui 1.0

import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    width:  parent.width
    height: parent.height

    Rectangle {
        anchors.fill: parent
        color: "#f2f2f2"

        ButtonGroup {
            id: switchGroup
        }

        Column {
            id: column
            anchors.centerIn: parent
            spacing: 5

            Rectangle {
                //id: rectangle
                width: 700
                height: 150
                color: "#ffffff"
                radius: 10
                border.width: 0
                Text {
                    width: 450
                    height: 104
                    anchors.centerIn: parent
                    text: qsTr("Kstars and Indi stable (recommended version)")
                    font.pointSize: 10
                    anchors.verticalCenterOffset: -10
                    anchors.horizontalCenterOffset: 100
                    wrapMode: Text.WordWrap
                }

                Switch {
                    id: element2
                    x: 500
                    y: 110
                    width: 187
                    height: 14
                    text: qsTr("Kstars stable")
                    checked: true
                    hoverEnabled: true
                    ButtonGroup.group: switchGroup

                    indicator: Rectangle {
                        implicitWidth: 40
                        implicitHeight: 14
                        radius: 10
                        color: element2.checked ? "#3498db" : "#B9B9B9"
                        border.color: element2.checked ? "#3498db" : "#cccccc"

                        Rectangle {
                            x: element2.checked ? parent.width - width : 0
                            y: (parent.height - height) / 2
                            width: 20
                            height: 20
                            radius: 10
                            color: element2.down ? "#cccccc" : "#ffffff"
                            border.color: element2.checked ? (element1.down ? "#3498db" : "#3498db") : "#999999"
                        }
                    }

                    onCheckedChanged: {
                        if ( checked ) {
                            config.packageChoice = "kstars_indi_stable"
                        }
                    }
                }

                Image {
                    id: image2
                    x: 8
                    y: 25
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    source: "images/kstars_indi.jpg"
                }
            }

            Rectangle {
                width: 700
                height: 150
                radius: 10
                border.width: 0
                Text {
                    width: 450
                    height: 104
                    anchors.centerIn: parent
                    text: qsTr("If you want to test some features not officially released or there are some fix to drivers that will be shipped only with the next indi release, you can move to bleeding edge and check them out")
                    font.pointSize: 10
                    anchors.verticalCenterOffset: -10
                    anchors.horizontalCenterOffset: 100
                    wrapMode: Text.WordWrap
                }

                Switch {
                    id: element1
                    x: 500
                    y: 110
                    width: 187
                    height: 14
                    text: qsTr("Kstars bleeding edge")
                    checked: false
                    hoverEnabled: true
                    ButtonGroup.group: switchGroup

                    indicator: Rectangle {
                        implicitWidth: 40
                        implicitHeight: 14
                        radius: 10
                        color: element1.checked ? "#3498db" : "#B9B9B9"
                        border.color: element1.checked ? "#3498db" : "#cccccc"

                        Rectangle {
                            x: element1.checked ? parent.width - width : 0
                            y: (parent.height - height) / 2
                            width: 20
                            height: 20
                            radius: 10
                            color: element1.down ? "#cccccc" : "#ffffff"
                            border.color: element1.checked ? (element1.down ? "#3498db" : "#3498db") : "#999999"
                        }
                    }

                    onCheckedChanged: {
                        if ( checked ) {
                            config.packageChoice = "kstars_indi_bleeding_edge"
                        }
                    }
                }

                Image {
                    id: image
                    x: 8
                    y: 25
                    height: 100
                    fillMode: Image.PreserveAspectFit
                    source: "images/kstars_indi_bleeding.jpg"
                }

            }

            Rectangle {
                width: 700
                height: 25
                color: "#f2f2f2"
                border.width: 0
                Text {
                    height: 25
                    anchors.centerIn: parent
                    text: qsTr("Default: Kstars stable")
                    font.pointSize: 10
                    wrapMode: Text.WordWrap
                }
            }
        }
    }

}
