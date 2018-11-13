/*
Copyright (c) 2015-2018, Hüssenbergnetz/Matthias Fehring
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

Page {
    id: changelogPage

    property alias model: changelogList.model
    property string bugTrackerBase: ""

    SilicaListView {
        id: changelogList
        anchors.fill: parent
        anchors.bottomMargin: Theme.paddingLarge

        header: Column {
            id: headerContainer
            width: changelogPage.width

            PageHeader {
                //% "Changelog"
                title: qsTrId("btsc-changelog")
            }

            Row {
                width: parent.width

                Column {
                    width: parent.width/4

                    Image {
                        width: 32; height: 32;
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "image://theme/icon-m-add"
                    }

                    Label {
                        width: parent.width
                        truncationMode: TruncationMode.Fade
                        color: Theme.secondaryColor
                        font.pixelSize: Theme.fontSizeExtraSmall
                        horizontalAlignment: Text.AlignHCenter
                        //% "New"
                        text: qsTrId("btsc-new")
                    }
                }

                Column {
                    width: parent.width/4

                    Image {
                        width: 32; height: 32;
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "image://theme/icon-m-favorite"
                    }

                    Label {
                        width: parent.width
                        truncationMode: TruncationMode.Fade
                        color: Theme.secondaryColor
                        font.pixelSize: Theme.fontSizeExtraSmall
                        horizontalAlignment: Text.AlignHCenter
                        //% "Improved"
                        text: qsTrId("btsc-improved")
                    }
                }

                Column {
                    width: parent.width/4

                    Image {
                        width: 32; height: 32;
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "image://theme/icon-m-crash-reporter"
                    }

                    Label {
                        width: parent.width
                        truncationMode: TruncationMode.Fade
                        color: Theme.secondaryColor
                        font.pixelSize: Theme.fontSizeExtraSmall
                        horizontalAlignment: Text.AlignHCenter
                        //% "Fixed"
                        text: qsTrId("btsc-fixed")
                    }
                }

                Column {
                    width: parent.width/4

                    Image {
                        width: 32; height: 32;
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "image://theme/icon-s-high-importance"
                    }

                    Label {
                        width: parent.width
                        truncationMode: TruncationMode.Fade
                        color: Theme.secondaryColor
                        font.pixelSize: Theme.fontSizeExtraSmall
                        horizontalAlignment: Text.AlignHCenter
                        //% "Note"
                        text: qsTrId("btsc-note")
                    }
                }
            }
        }

        VerticalScrollDecorator { page: changelogPage; flickable: changelogList }

        delegate: ChangelogDelegate { trackerUrl: changelogPage.bugTrackerBase }
    }
}


