/*
Copyright (c) 2015-2025, Hüssenbergnetz/Matthias Fehring
https://github.com/Huessenbergnetz/HBN_SFOS_Components
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

ListItem {
    id: root
    width: parent.width
    contentHeight: Math.max(contentRow.height, Theme.itemSizeLarge)
    contentWidth: parent.width

    property string avatarPath
    property color theColor: root.highlighted ? Theme.highlightColor : Theme.primaryColor

    enabled: serviceImages.visibleChildren.length

    showMenuOnPressAndHold: true

    menu: root.enabled ? contextMenu : null

    onClicked: root.menuOpen ? closeMenu() : openMenu()

    Row {
        id: contentRow
        spacing: Theme.paddingMedium
        anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; right: parent.right; rightMargin: Theme.horizontalPageMargin }

        Image {
            id:contribImage
            source: model.image ? avatarPath + "/" + model.image : "image://theme/icon-l-people"
            width: Theme.iconSizeLarge
            height: Theme.iconSizeLarge
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
                color: theColor
            }

            Label {
                text: model.role
                font.pixelSize: Theme.fontSizeExtraSmall
                width: parent.width
                wrapMode: Text.WordWrap
                color: theColor
            }

            Row {
                id: serviceImages
                spacing: Theme.paddingMedium

                Image {
                    source: visible ? "image://hbnsc/icon-s-browser?" + theColor : ""
                    visible: model.website !== undefined
                    width: Theme.iconSizeSmall; height: Theme.iconSizeSmall
                }

                Image {
                    source: visible ? "image://hbnsc/icon-s-bitbucket?" + theColor : ""
                    visible: model.bitbucket !== undefined
                    width: Theme.iconSizeSmall; height: Theme.iconSizeSmall
                }

                Image {
                    source: visible ? "image://hbnsc/icon-s-facebook?" + theColor : ""
                    visible: model.facebook !== undefined
                    width: Theme.iconSizeSmall; height: Theme.iconSizeSmall
                }

                Image {
                    source: visible ? "image://hbnsc/icon-s-github?" + theColor : ""
                    visible: model.github !== undefined
                    width: Theme.iconSizeSmall; height: Theme.iconSizeSmall
                }

                Image {
                    source: visible ? "image://hbnsc/icon-s-linkedin?" + theColor : ""
                    visible: model.linkedin !== undefined
                    width: Theme.iconSizeSmall; height: Theme.iconSizeSmall
                }

                Image {
                    source: visible ? "image://hbnsc/icon-s-tmo?" + theColor : ""
                    visible: model.tmo !== undefined
                    width: Theme.iconSizeSmall; height: Theme.iconSizeSmall
                }

                Image {
                    source: visible ? "image://hbnsc/icon-s-x?" + theColor : ""
                    visible: model.twitter !== undefined || model.x !== undefined
                    width: Theme.iconSizeSmall; height: Theme.iconSizeSmall
                }

                Image {
                    source: visible ? "image://hbnsc/icon-s-weibo?" + theColor : ""
                    visible: model.weibo !== undefined
                    width: Theme.iconSizeSmall; height: Theme.iconSizeSmall
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
                text: "Bitbucket"
                visible: model.bitbucket !== undefined
                onClicked: Qt.openUrlExternally("https://bitbucket.org/" + model.bitbucket)
            }
            MenuItem {
                text: "Facebook"
                visible: model.facebook !== undefined
                onClicked: Qt.openUrlExternally("https://www.facebook.com/" + model.facebook)
            }
            MenuItem {
                text: "GitHub"
                visible: model.github !== undefined
                onClicked: Qt.openUrlExternally("https://github.com/" + model.github)
            }
            MenuItem {
                text: "Google+"
                visible: model.googleplus !== undefined
                onClicked: Qt.openUrlExternally("https://plus.google.com/" + model.googleplus)
            }
            MenuItem {
                text: "LinkedIn"
                visible: model.linkedin !== undefined
                onClicked: Qt.openUrlExternally("http://www.linkedin.com/profile/view?id=" + model.linkedin)
            }
            MenuItem {
                text: "TMO"
                visible: model.tmo !== undefined
                onClicked: Qt.openUrlExternally("https://talk.maemo.org/member.php?u=" + model.tmo)
            }
            MenuItem {
                text: "X"
                visible: model.twitter !== undefined || model.x !== undefined
                onClicked: Qt.openUrlExternally("https://x.com/" + (model.twitter ? model.twitter : model.x))
            }
            MenuItem {
                text: "Sina Weibo"
                visible: model.weibo !== undefined
                onClicked: Qt.openUrlExternally("http://www.weibo.com/" + model.weibo)
            }
        }
    }
}
