/*
Copyright (c) 2015-2017, Matthias Fehring
https://github.com/Buschtrommel/BT_SFOS_Components
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
    id: changelogDelegate

    width: parent.width
    height: col.height

    property string trackerUrl: ""

    Column {
        id: col
        anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; right: parent.right; rightMargin: Theme.horizontalPageMargin }

        Item {
            width: parent.width
            height: Theme.itemSizeSmall

            Text {
                width: parent.width/2
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.highlightColor
                anchors.left: parent.left
                text: model.version
                textFormat: Text.StyledText
                linkColor: Theme.secondaryHighlightColor
                onLinkActivated: Qt.openUrlExternally(link)
            }

            Text {
                width: parent.width/2
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
                anchors.right: parent.right
                text: Qt.formatDateTime(new Date(model.date), Qt.DefaultLocaleShortDate)
                textFormat: Text.PlainText
            }
        }

        Repeater {
            width: parent.width
            model: entries

            Item {
                width: parent.width
                height: desc.height

                property string issueUrl: (model.issue && trackerUrl) ? " (<a href='" + trackerUrl + model.issue +"'>#" + model.issue + "</a>)" : ""

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
                    textFormat: Text.StyledText
                    linkColor: Theme.secondaryHighlightColor
                    color: Theme.primaryColor
                    wrapMode: Text.WordWrap
                    font.pixelSize: Theme.fontSizeSmall
                    onLinkActivated: { Qt.openUrlExternally(link) }
                    text:model.description + issueUrl
                }
            }
        }
    }
}
