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

ListItem {
    id: root
    width: parent.width
    contentHeight: Math.max(contentRow.height, Theme.itemSizeLarge)
    contentWidth: parent.width

    property string avatarPath
    property string website: model.website ? model.website : ""
    property string twitter: model.twitter ? model.twitter : ""
    property string github: model.github ? model.github : ""
    property string bitbucket: model.bitbucket ? model.bitbucket : ""
    property string linkedin: model.linkedin ? model.linkedin : ""
    property string weibo: model.weibo ? model.weibo : ""

    enabled: (website || twitter || github || bitbucket || linkedin || weibo)

    showMenuOnPressAndHold: true

    menu: root.enabled ? contextMenu : null

    onClicked: root.menuOpen ? hideMenu() : showMenu()

    Row {
        id: contentRow
        spacing: 10
        anchors { left: parent.left; leftMargin: Theme.paddingLarge; right: parent.right; rightMargin: Theme.paddingLarge }

        Image {
            id:contribImage
            source: model.image ? avatarPath + "/" + model.image : "images/placeholder.png"
            sourceSize.height: 86
            sourceSize.width: 86
            width: 86
            height: 86
        }

        Column {
            spacing: 1
            width: parent.width - contribImage.width

            Label {
                text: qsTranslate("ContributorsModel", model.name)
                font.pixelSize: Theme.fontSizeSmall
                width: parent.width
                wrapMode: Text.WordWrap
                color: root.highlighted ? Theme.highlightColor : Theme.primaryColor
            }

            Label {
                text: qsTranslate("ContributorsModel", model.role)
                font.pixelSize: Theme.fontSizeExtraSmall
                width: parent.width
                wrapMode: Text.WordWrap
                color: root.highlighted ? Theme.highlightColor : Theme.primaryColor
            }

            Row {
                id: serviceImages
                spacing: Theme.paddingSmall

                Image {
                    sourceSize.width: 32; sourceSize.height: 32
                    source: "images/icon-s-browser.png"
                    visible: root.website
                }

                Image {
                    sourceSize.width: 32; sourceSize.height: 32
                    source: "images/icon-s-twitter.png"
                    visible: root.twitter
                }

                Image {
                    sourceSize.width: 32; sourceSize.height: 32
                    source: "images/icon-s-github.png"
                    visible: root.github
                }

                Image {
                    sourceSize.width: 32; sourceSize.height: 32
                    source: "images/icon-s-bitbucket.png"
                    visible: root.bitbucket
                }

                Image {
                    sourceSize.width: 32; sourceSize.height: 32
                    source: "images/icon-s-linkedin.png"
                    visible: root.linkedin
                }

                Image {
                    sourceSize.width: 32; sourceSize.height: 32
                    source: "images/icon-s-weibo.png"
                    visible: root.weibo
                }
            }
        }
    }

    Component {
        id: contextMenu
        ContextMenu {
            MenuItem {
                text: qsTr("Website")
                visible: root.website
                onClicked: Qt.openUrlExternally(root.website)
            }
            MenuItem {
                text: "Twitter"
                visible: root.twitter
                onClicked: Qt.openUrlExternally("https://twitter.com/" + root.twitter)
            }
            MenuItem {
                text: "GitHub"
                visible: root.github
                onClicked: Qt.openUrlExternally("https://github.com/" + root.github)
            }
            MenuItem {
                text: "Bitbucket"
                visible: root.bitbucket
                onClicked: Qt.openUrlExternally("https://bitbucket.org/" + root.bitbucket)
            }
            MenuItem {
                text: "LinkedIn"
                visible: root.linkedin
                onClicked: Qt.openUrlExternally("http://www.linkedin.com/profile/view?id=" + root.linkedin)
            }
            MenuItem {
                text: qsTr("Sina Weibo")
                visible: root.weibo
                onClicked: Qt.openUrlExternally("http://www.weibo.com/" + root.weibo)
            }
        }
    }
}
