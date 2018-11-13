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

BackgroundItem {
    id: lic
    width: parent.width
    height: Theme.itemSizeMedium

    onClicked: {
        if (model.licenseFile) {
            pageStack.push("licenses/"+model.licenseFile, {componentName: model.name, componentAuthor: model.author, componentDescription: model.description ? model.description : "", componentUrl: model.website ? model.website : ""})
        } else if (model.customLicenseFile) {
            pageStack.push(model.customLicenseFile)
        }
    }

    Item {
        anchors { left: parent.left; leftMargin: Theme.horizontalPageMargin; right: parent.right; rightMargin: Theme.horizontalPageMargin; verticalCenter: parent.verticalCenter}
        height: label.height + licenseText.height

        Label {
            id: label
            anchors { left: parent.left; right: parent.right }
            color: lic.highlighted ? Theme.highlightColor : Theme.primaryColor
            font.pixelSize: Theme.fontSizeSmall
            truncationMode: TruncationMode.Fade
            text: model.version
                        //: %1 is the name of the sofware, %2 is the version, %3 is the author's name
                        //% "%1 %2 by %3"
                      ? qsTrId("btsec-lic-item-text").arg(model.name).arg(model.version).arg(model.author)
                        //: %1 is the name of the sofware, %2 is the author's name
                        //% "%1 by %2."
                      : qsTrId("btsec-lic-item-without-version-text").arg(model.name).arg(model.author)
        }

        Label {
            id: licenseText
            anchors { left: parent.left; right: parent.right; top: label.bottom }
            color: lic.highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
            font.pixelSize: Theme.fontSizeSmall
            truncationMode: TruncationMode.Fade
            text: model.license
        }

    }

}

