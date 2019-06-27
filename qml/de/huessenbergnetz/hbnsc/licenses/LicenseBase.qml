/*
Copyright (c) 2016, Buschtrommel
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of HBN_SFOS_Components nor the names of its
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

Page {
    id: licenseBase

    property alias componentName: pHeader.title
    property string componentAuthor
    property alias componentDescription: compDesc.text
    property string componentUrl: ""
    property alias licenseName: name.text
    property alias licenseModel: licenseRep.model
    property url licenseWebsite
    readonly property string _RICHTEXT_STYLESHEET_PREAMBLE: "<html><style>a { color: '" + Theme.secondaryHighlightColor + "' }</style><body>";
    readonly property string _RICHTEXT_STYLESHEET_APPENDIX: "</body></html>";

    SilicaFlickable {
        id: licenseBaseFlick

        anchors.fill: parent

        contentHeight: mainCol.height

        PullDownMenu {
            MenuItem {
                onClicked: Qt.openUrlExternally(licenseWebsite)
                //% "License website"
                text: qsTrId("btsc-license-web")
            }
            MenuItem {
                visible: componentUrl !== ""
                onClicked: Qt.openUrlExternally(componentUrl)
                //: %1 is the name of the 3rd party component
                //% "Visit %1"
                text: qsTrId("btsc-comp-web").arg(componentName)
            }
        }

        PushUpMenu {
            MenuItem {
                onClicked: Qt.openUrlExternally(licenseWebsite)
                //% "License website"
                text: qsTrId("btsc-license-web")
            }
            MenuItem {
                visible: componentUrl !== ""
                onClicked: Qt.openUrlExternally(componentUrl)
                //: %1 is the name of the 3rd party component
                //% "Visit %1"
                text: qsTrId("btsc-comp-web").arg(componentName)
            }
        }

        VerticalScrollDecorator { flickable: licenseBaseFlick; page: licenseBase }

        Column {
            id: mainCol
            width: parent.width
            spacing: Theme.paddingMedium

            PageHeader {
                id: pHeader
                page: licenseBase
                description: componentAuthor ? String("© %1").arg(componentAuthor) : ""
            }

            Text {
                id: compDesc
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                visible: text
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.WordWrap
            }

            Text {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.WordWrap
                //: %1 is the name of the 3rd party app/lib/component
                //% "%1 is available under the terms of the following license:"
                text: qsTrId("btsc-license-intro").arg(componentName)
            }

            Item {
                width: parent.width
                height: Theme.paddingLarge
            }

            Text {
                id: name
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                visible: text
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                wrapMode: Text.WordWrap
            }

            Repeater {
                id: licenseRep

                delegate: Text {
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    color: model.header ? Theme.highlightColor : Theme.primaryColor
                    font.pixelSize: model.header ? Theme.fontSizeMedium : Theme.fontSizeSmall
                    textFormat: model.format ? model.format : Text.PlainText
                    onLinkActivated: Qt.openUrlExternally(link)
                    text: (model.format === Text.RichText && model.hasLinks) ? licenseBase._RICHTEXT_STYLESHEET_PREAMBLE + model.text + licenseBase._RICHTEXT_STYLESHEET_APPENDIX : model.text
                    wrapMode: Text.WordWrap
                    linkColor: Theme.highlightColor
                }
            }

            Item {
                width: parent.width
                height: Theme.paddingLarge
            }
        }
    }
}

