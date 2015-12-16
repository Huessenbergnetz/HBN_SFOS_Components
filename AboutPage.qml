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
    property string appCover: ""
    property string appDescription: ""
    property string appHomepage: ""
    property string appCopyright: ""
    property string appLicense: ""

    property string privacyPolicyQmlFile: ""
    property ListModel changelogModel: null
    property string bugTrackerBaseUrl: ""
    property ListModel contributorsModel: null
    property string contributorsAvatarBasePath: ""

    property string contactCompany: ""
    property string contactName: ""
    property string contactStreet: ""
    property string contactHouseNo: ""
    property string contactZIP: ""
    property string contactCity: ""
    property string contactCountry: ""
    property string contactPhone: ""
    property string contactFax: ""
    property string contactEmail: ""
    property string contactWebsite: ""

    property string bugUrl: ""
    property string translateUrl: ""

    property alias licensesModel: licensesRepeater.model

    property string paypalOrganization: ""
    property string paypalItem: ""
    property string paypalEmail: ""
    property string paypalMessage: ""
    property string paypalLabel: ""


    property string _RICHTEXT_STYLESHEET_PREAMBLE: "<html><style>a { text-decoration: none; color: '" + Theme.secondaryHighlightColor + "' }</style><body>";
    property string _RICHTEXT_STYLESHEET_APPENDIX: "</body></html>";

    SilicaFlickable {
        id: aboutFlick
        anchors.fill: parent
        contentHeight: imgCol.height + aboutCol.height + contactCol.height + contributeCol.height + licensesCol.height + Theme.paddingLarge + 4 * Theme.paddingMedium
        VerticalScrollDecorator {}

        PullDownMenu {
            visible: appHomepage || privacyPolicyQmlFile || changelogModel !== null || contributorsModel !== null
            MenuItem {
                text: qsTr("Homepage")
                onClicked: Qt.openUrlExternally(appHomepage)
                visible: appHomepage
            }
            MenuItem {
                text: qsTr("Privacy Policy")
                onClicked: pageStack.push(Qt.resolvedUrl(privacyPolicyQmlFile))
                visible: privacyPolicyQmlFile
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
            PageHeader { title: qsTr("About") }

            Image {
                visible: appCover
                width: parent.width
                smooth: true
                source: appCover
            }

        }

       Column {
           id: aboutCol
           anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingLarge; top: imgCol.bottom; topMargin: Theme.paddingMedium }
           spacing: Theme.paddingSmall

            Label {
                id: labelName
                textFormat: Text.PlainText
                text: appTitle + " " + appVersion
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.highlightColor
            }

            Text {
                id: description
                text: appDescription
                width: parent.width
                wrapMode: Text.WordWrap
                textFormat: Text.PlainText
                color: Theme.secondaryHighlightColor
            }

            Text {
                id: copyright
                text: appCopyright
                width: parent.width
                wrapMode: Text.WordWrap
                textFormat: Text.PlainText
                color: Theme.primaryColor
                visible: appCopyright
            }

            Text {
                id: license
                text: _RICHTEXT_STYLESHEET_PREAMBLE + appLicense + _RICHTEXT_STYLESHEET_APPENDIX
                width: parent.width
                textFormat: Text.RichText
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                visible: appLicense
            }
       }

       Column {
           id: contactCol
           anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingLarge; top: aboutCol.bottom; topMargin: Theme.paddingMedium }

            SectionHeader { text: qsTr("Contact") }

            Text {
                id: company
                text: contactCompany
                width: parent.width
                wrapMode: Text.WordWrap
                textFormat: Text.StyledText
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                visible: contactCompany
            }

            Text {
                id: name
                text: contactName
                width: parent.width
                wrapMode: Text.WordWrap
                textFormat: Text.StyledText
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                visible: contactName
            }

            Text {
                id: streetAndNo
                property string san: "%1 %2"
                text: san.arg(contactStreet).arg(contactHouseNo)
                width: parent.width
                wrapMode: Text.WordWrap
                textFormat: Text.StyledText
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                visible: contactStreet
            }

            Text {
                id: zibAndCity
                property string zac: "%1 %2"
                text: zac.arg(contactZIP).arg(contactCity)
                width: parent.width
                wrapMode: Text.WordWrap
                textFormat: Text.StyledText
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                visible: contactCity
            }

            Text {
                id: country
                text: contactCountry
                width: parent.width
                wrapMode: Text.WordWrap
                textFormat: Text.StyledText
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                visible: contactCountry
            }

            Text {
                id: email
                text: _RICHTEXT_STYLESHEET_PREAMBLE + "<a href='mailto:" + contactEmail + "'>" + contactEmail + "</a>" + _RICHTEXT_STYLESHEET_APPENDIX
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                textFormat: Text.RichText
                onLinkActivated: Qt.openUrlExternally(link)
                visible: contactEmail
            }

            Text {
                id: website
                text: _RICHTEXT_STYLESHEET_PREAMBLE + "<a href='http://" + contactWebsite + "'>" + contactWebsite + "</a>" + _RICHTEXT_STYLESHEET_APPENDIX
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                textFormat: Text.RichText
                onLinkActivated: Qt.openUrlExternally(link)
                visible: contactWebsite
            }
        }

        Column {
            id: contributeCol
            anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingLarge; top: contactCol.bottom; topMargin: Theme.paddingMedium }

            SectionHeader { text: qsTr("Contribute"); visible: translateUrl || bugUrl || donation.visible }

            Row {
                id: contributeRow
                width: parent.width - Theme.paddingLarge

                Button {
                    width: parent.width/contributeRow.visibleChildren.length
                    text: qsTr("Translate")
                    onClicked: Qt.openUrlExternally(translateUrl)
                    visible: translateUrl
                }

                Button {
                    width: parent.width/contributeRow.visibleChildren.length
                    text: qsTr("Report bugs")
                    onClicked: Qt.openUrlExternally(bugUrl)
                    visible: bugUrl
                }
            }

            PaypalChooser {
                id: donation
                anchors { left: parent.left; leftMargin: -Theme.paddingLarge; right: parent.right }
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
                    text: _RICHTEXT_STYLESHEET_PREAMBLE + qsTranslate("LicensesModel", model.text) + _RICHTEXT_STYLESHEET_APPENDIX
                    width: parent.width
                    wrapMode: Text.WordWrap
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    textFormat: Text.RichText
                    onLinkActivated: Qt.openUrlExternally(link)
                }
            }
        }
    }
}
