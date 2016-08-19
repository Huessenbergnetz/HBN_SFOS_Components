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

Page {
    id: about

    property string appTitle: ""
    property string appVersion: ""
    property alias appCover: appCoverImage.source

    property alias appDescription: description.text
    property url appHomepage: ""
    property alias appCopyright: copyright.text
    property alias appLicense: license.text

    property url privacyPolicyQmlFile: ""
    property ListModel changelogModel: null
    property string bugTrackerBaseUrl: ""
    property ListModel contributorsModel: null
    property string contributorsAvatarBasePath: ""

    property alias contactCompany: company.text
    property alias contactName: name.text
    property string contactStreet: ""
    property string contactHouseNo: ""
    property string contactZIP: ""
    property string contactCity: ""
    property alias contactCountry: country.text
    property string contactEmail: ""
    property string contactWebsite: ""

    property url bugUrl: ""
    property url translateUrl: ""

    property alias licensesModel: licensesRepeater.model

    property alias paypalOrganization: donation.organization
    property alias paypalItem: donation.item
    property alias paypalEmail: donation.email
    property alias paypalMessage: donation.message
    property alias paypalLabel: donation.label

    SilicaFlickable {
        id: aboutFlick
        anchors.fill: parent
        contentHeight: imgCol.height + aboutCol.height + contactCol.height + contributeCol.height + licensesCol.height + Theme.paddingLarge + 4 * Theme.paddingMedium
        VerticalScrollDecorator {}

        PullDownMenu {
            visible: appHomepage.toString().length > 0 || privacyPolicyQmlFile.toString().length > 0 || changelogModel !== null || contributorsModel !== null
            MenuItem {
                text: qsTr("Homepage")
                onClicked: Qt.openUrlExternally(appHomepage)
                visible: appHomepage.toString().length > 0
            }
            MenuItem {
                text: qsTr("Privacy Policy")
                onClicked: pageStack.push(privacyPolicyQmlFile)
                visible: privacyPolicyQmlFile.length > 0
            }
            MenuItem {
                text: qsTr("Changelog")
                onClicked: pageStack.push(Qt.resolvedUrl("Changelog.qml"), {model: changelogModel, bugTrackerBase: bugTrackerBaseUrl})
                visible: changelogModel !== null
            }
            MenuItem {
                text: qsTr("Contributors")
                onClicked: pageStack.push(Qt.resolvedUrl("Contributors.qml"), { avatarBasePath: contributorsAvatarBasePath, model: contributorsModel })
                visible: contributorsModel !== null
            }
        }


        Column {
            id: imgCol
            anchors { left: parent.left; right: parent.right }
            PageHeader { title: qsTr("About"); page: about }

            Image {
                id: appCoverImage
                visible: status === Image.Ready
                width: parent.width
                smooth: true
            }

        }

       Column {
           id: aboutCol
           anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: imgCol.bottom; topMargin: Theme.paddingMedium }
           spacing: Theme.paddingSmall

            Label {
                id: labelName
                textFormat: Text.PlainText
                text: appTitle + " " + appVersion
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.highlightColor
                wrapMode: Text.WordWrap
            }

            Text {
                id: description
                width: parent.width
                wrapMode: Text.WordWrap
                textFormat: Text.PlainText
                color: Theme.secondaryHighlightColor
                visible: text
            }

            Text {
                id: copyright
                width: parent.width
                wrapMode: Text.WordWrap
                textFormat: Text.PlainText
                color: Theme.primaryColor
                visible: text
            }

            Text {
                id: license
                width: parent.width
                textFormat: Text.StyledText
                color: Theme.primaryColor
                linkColor: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeSmall
                visible: text
                onLinkActivated: Qt.openUrlExternally(link)
                wrapMode: Text.WordWrap
            }
       }

       Column {
           id: contactCol
           anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; top: aboutCol.bottom; topMargin: Theme.paddingMedium }

            SectionHeader { text: qsTr("Contact") }

            Text {
                id: company
                width: parent.width - Theme.horizontalPageMargin
                wrapMode: Text.WordWrap
                textFormat: Text.PlainText
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                visible: text
            }

            Text {
                id: name
                width: parent.width - Theme.horizontalPageMargin
                wrapMode: Text.WordWrap
                textFormat: Text.PlainText
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                visible: text
            }

            Text {
                id: streetAndNo
                text: contactStreet + " " + contactHouseNo
                width: parent.width - Theme.horizontalPageMargin
                wrapMode: Text.WordWrap
                textFormat: Text.PlainText
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                visible: contactStreet
            }

            Text {
                id: zibAndCity
                text: contactZIP + " " + contactCity
                width: parent.width - Theme.horizontalPageMargin
                wrapMode: Text.WordWrap
                textFormat: Text.PlainText
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                visible: contactCity
            }

            Text {
                id: country
                width: parent.width - Theme.horizontalPageMargin
                wrapMode: Text.WordWrap
                textFormat: Text.PlainText
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                visible: text
            }

            Text {
                id: email
                width: parent.width - Theme.horizontalPageMargin
                text: "<a href='mailto:" + contactEmail + "'>" + contactEmail + "</a>"
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                textFormat: Text.StyledText
                linkColor: Theme.secondaryHighlightColor
                onLinkActivated: Qt.openUrlExternally(link)
                visible: contactEmail
                elide: Text.ElideRight
            }

            Text {
                id: website
                width: parent.width - Theme.horizontalPageMargin
                text: "<a href='http://" + contactWebsite + "'>" + contactWebsite + "</a>"
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                textFormat: Text.StyledText
                linkColor: Theme.secondaryHighlightColor
                onLinkActivated: Qt.openUrlExternally(link)
                visible: contactWebsite
                elide: Text.ElideRight
            }
        }

        Column {
            id: contributeCol
            anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; top: contactCol.bottom; topMargin: Theme.paddingMedium }

            SectionHeader { text: qsTr("Contribute"); visible: translateUrl.toString().length > 0 || bugUrl.toString().length > 0 || donation.visible }

            Row {
                id: contributeRow
                width: parent.width - Theme.paddingLarge
                spacing: Theme.paddingMedium

                Button {
                    width: (parent.width/2) - (parent.spacing/2)
                    text: qsTr("Translate")
                    onClicked: Qt.openUrlExternally(translateUrl)
                    visible: translateUrl.toString().length > 0
                }

                Button {
                    width: (parent.width/2) - (parent.spacing/2)
                    text: qsTr("Report bugs")
                    onClicked: Qt.openUrlExternally(bugUrl)
                    visible: bugUrl.toString().length > 0
                }
            }

            PaypalChooser {
                id: donation
                anchors { left: parent.left; leftMargin: -Theme.horizontalPageMargin; right: parent.right }
                organization: paypalOrganization
                item: paypalItem
                email: paypalEmail
                message: paypalMessage
                label: paypalLabel
                visible: label && email
            }
        }

        Column {
            id: licensesCol
            anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingLarge; top: contributeCol.bottom; topMargin: Theme.paddingMedium }
            spacing: Theme.paddingSmall

            SectionHeader { text: qsTr("3rd party licenses"); visible: licensesRepeater.count > 0 }

            Repeater {
                id: licensesRepeater
                width: parent.width

                Text {
                    text: qsTranslate("LicensesModel", model.text)
                    width: parent.width - Theme.horizontalPageMargin
                    wrapMode: Text.WordWrap
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    textFormat: Text.StyledText
                    linkColor: Theme.secondaryHighlightColor
                    onLinkActivated: Qt.openUrlExternally(link)
                }
            }
        }
    }
}
