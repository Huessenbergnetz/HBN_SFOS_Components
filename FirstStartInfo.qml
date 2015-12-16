/*
Copyright (c) 2015, Buschtrommel
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of BT_SFOS_Components nor the names of its
  contributors may be used to endorse or promote products derived from
  this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.2
import Sailfish.Silica 1.0

Item {
    id: root
    anchors.fill: parent
    z: 1000

    signal clicked()

    property string version
    property string name
    property string description
    property string helpPage
    property string donationHeader
    property string donationText
    property string paypalOrganization
    property string paypalItem
    property string paypalEmail
    property string paypalMessage
    property string paypalLabel

    property ListModel changeLogModel: null
    property string changeLogTracker

    Loader {
        anchors.fill: parent
        sourceComponent: parent.visible ? info : null
    }

    Component {
        id: info

        Rectangle {
            color: Theme.rgba("black", 0.8)
            anchors.fill: parent

            property string _RICHTEXT_STYLESHEET_PREAMBLE: "<html><style>a { text-decoration: none; color: '" + Theme.secondaryHighlightColor + "' }</style><body>";
            property string _RICHTEXT_STYLESHEET_APPENDIX: "</body></html>";

            SilicaFlickable {
                id: infoFlick
                anchors.fill: parent
                contentHeight: infoCol.height + Theme.paddingLarge

                VerticalScrollDecorator {}

                Column {
                    id: infoCol
                    anchors { left: parent.left; right: parent.right; top: parent.top; topMargin: Theme.paddingLarge }

                    Label {
                        id: title
                        anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingLarge; rightMargin: Theme.paddingLarge }
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        text: qsTr("Welcome to %1 %2", "First is app name, second is version number").arg(root.name).arg(root.version)
                        color: Theme.highlightColor
                    }

                    Text {
                        id: description
                        anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingLarge; rightMargin: Theme.paddingLarge }
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        textFormat: Text.RichText
                        color: Theme.primaryColor
                        font.pixelSize: Theme.fontSizeSmall
                        visible: root.description !== ""
                        text: _RICHTEXT_STYLESHEET_PREAMBLE + root.description + _RICHTEXT_STYLESHEET_APPENDIX
                    }

                    SectionHeader { text: qsTr("Last changes"); visible: clRepeater.count > 0 }

                    Repeater {
                        id: clRepeater
                        model: changeLogModel.get(0).entries
                        anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingLarge; rightMargin: Theme.paddingLarge }

                        Item {
                            anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingLarge; rightMargin: Theme.paddingLarge }
                            height: desc.height

                            property string issueUrl: (model.issue && root.changeLogTracker) ? " (<a href='" + root.changeLogTracker + model.issue +"'>#" + model.issue + "</a>)" : ""

                            Image {
                                id: typeIcon
                                width: 32; height: 32
                                source: model.type === 0 ? "image://theme/icon-m-add" : model.type === 1 ? "image://theme/icon-m-favorite" : model.type === 2 ? "image://theme/icon-m-crash-reporter" : "image://theme/icon-s-high-importance"
                                anchors { left: parent.left; top: parent.top; }
                            }

                            Text {
                                id: desc
                                width: parent.width - typeIcon.width - Theme.paddingSmall
                                anchors { left: typeIcon.right; leftMargin: Theme.paddingSmall; right: parent.right }
                                textFormat: Text.RichText
                                color: Theme.primaryColor
                                wrapMode: Text.WordWrap
                                font.pixelSize: Theme.fontSizeSmall
                                onLinkActivated: { Qt.openUrlExternally(link) }
                                text: _RICHTEXT_STYLESHEET_PREAMBLE + model.description + issueUrl + _RICHTEXT_STYLESHEET_APPENDIX
                            }
                        }
                    }

                    SectionHeader { text: root.donationHeader; visible: root.donationHeader }

                    Text {
                        anchors { left: parent.left; leftMargin: Theme.paddingLarge; right: parent.right; rightMargin: Theme.paddingLarge }
                        textFormat: Text.PlainText
                        color: Theme.primaryColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        onLinkActivated: { Qt.openUrlExternally(link) }
                        text: root.donationText
                        visible: root.donationText
                    }

                    PaypalChooser {
                        id: donation
                        organization: root.paypalOrganization
                        item: root.paypalItem
                        email: root.paypalEmail
                        message: root.paypalMessage
                        visible: root.paypalEmail
                        label: root.paypalLabel
                    }


                    Row {
                        anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingLarge; rightMargin: Theme.paddingLarge }


                        Button {
                            text: qsTr("Help")
                            visible: root.helpPage !== ""
                            onClicked: { root.clicked(); root.visible = false; pageStack.push(Qt.resolvedUrl(root.helpPage)) }
                        }

                        Button {
                            text: qsTr("Close")
                            onClicked: { root.clicked(); root.visible = false }
                        }
                    }
                }
            }
        }
    }
}
