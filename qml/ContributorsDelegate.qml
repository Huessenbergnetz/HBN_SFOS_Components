/*
Copyright (c) 2015-2016, Buschtrommel
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
    property string placeHolderPath

    enabled: (model.website !== undefined || model.twitter !== undefined || model.github !== undefined || model.bitbucket !== undefined || model.linkedin !== undefined || model.weibo !== undefined || model.tmo !== undefined)

    showMenuOnPressAndHold: true

    menu: root.enabled ? contextMenu : null

    onClicked: root.menuOpen ? hideMenu() : showMenu()

    Row {
        id: contentRow
        spacing: 10
        anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; right: parent.right; rightMargin: Theme.horizontalPageMargin }

        Image {
            id:contribImage
            source: model.image ? avatarPath + "/" + model.image : placeHolderPath
            sourceSize.height: 86
            sourceSize.width: 86
            width: 86
            height: 86
            anchors.verticalCenter: parent.verticalCenter
        }

        Column {
            spacing: 1
            width: parent.width - contribImage.width

            Label {
                text: model.name
                font.pixelSize: Theme.fontSizeSmall
                width: parent.width
                wrapMode: Text.WordWrap
                color: root.highlighted ? Theme.highlightColor : Theme.primaryColor
            }

            Label {
                text: model.role
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
                    source: "icons/icon-s-browser.png"
                    visible: model.website !== undefined
                }

                Image {
                    sourceSize.width: 32; sourceSize.height: 32
                    source: "icons/icon-s-twitter.png"
                    visible: model.twitter !== undefined
                }

                Image {
                    sourceSize.width: 32; sourceSize.height: 32
                    source: "icons/icon-s-github.png"
                    visible: model.github !== undefined
                }

                Image {
                    sourceSize.width: 32; sourceSize.height: 32
                    source: "icons/icon-s-bitbucket.png"
                    visible: model.bitbucket !== undefined
                }

                Image {
                    sourceSize.width: 32; sourceSize.height: 32
                    source: "icons/icon-s-linkedin.png"
                    visible: model.linkedin !== undefined
                }

                Image {
                    sourceSize.width: 32; sourceSize.height: 32
                    source: "icons/icon-s-weibo.png"
                    visible: model.weibo !== undefined
                }

                Image {
                    sourceSize.width: 32; sourceSize.height: 32
                    source: "icons/icon-s-tmo.png"
                    visible: model.tmo !== undefined
                }
            }
        }
    }

    Component {
        id: contextMenu
        ContextMenu {
            MenuItem {
                //% "Website"
                text: qsTrId("btsc-website")
                visible: model.website !== undefined
                onClicked: Qt.openUrlExternally(model.website)
            }
            MenuItem {
                text: "Twitter"
                visible: model.twitter !== undefined
                onClicked: Qt.openUrlExternally("https://twitter.com/" + model.twitter)
            }
            MenuItem {
                text: "GitHub"
                visible: model.github !== undefined
                onClicked: Qt.openUrlExternally("https://github.com/" + model.github)
            }
            MenuItem {
                text: "Bitbucket"
                visible: model.bitbucket !== undefined
                onClicked: Qt.openUrlExternally("https://bitbucket.org/" + model.bitbucket)
            }
            MenuItem {
                text: "LinkedIn"
                visible: model.linkedin !== undefined
                onClicked: Qt.openUrlExternally("http://www.linkedin.com/profile/view?id=" + model.linkedin)
            }
            MenuItem {
                text: "Sina Weibo"
                visible: model.weibo !== undefined
                onClicked: Qt.openUrlExternally("http://www.weibo.com/" + model.weibo)
            }
            MenuItem {
                text: "TMO"
                visible: model.tmo !== undefined
                onClicked: Qt.openUrlExternally("https://talk.maemo.org/member.php?u=" + model.tmo)
            }
        }
    }
}
