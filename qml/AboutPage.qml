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

Page {
    id: about

    property alias pageTitle: pHeader.title

    property string appTitle: ""
    property alias appCover: appCoverImage.source

    property alias appDescription: description.text
    property url appHomepage: ""
    property string appCopyrightYear: ""
    property string appCopyrightHolder: ""
    property alias appLicense: license.text
    property string appLicenseFile: ""
    property string appCustomLicense

    property string privacyPolicyQmlFile: ""

    property ListModel changelogModel: null
    property string bugTrackerBaseUrl: ""

    property ListModel contributorsModel: null
    property string contributorsAvatarBasePath: ""
    property string contributorsPlaceholderPath: ""

    property alias contactCompany: company.text
    property alias contactName: name.text
    property string contactStreet: ""
    property string contactHouseNo: ""
    property string contactZIP: ""
    property string contactCity: ""
    property alias contactCountry: country.text
    property string contactEmail: ""
    property string contactWebsite: ""
    property url contactWebsiteLink: ""

    property url bugUrl: ""
    property url translateUrl: ""

    property alias licensesModel: licensesRepeater.model

    property alias paypalOrganization: paypalDonation.organization
    property alias paypalItem: paypalDonation.item
    property alias paypalEmail: paypalDonation.email
    property alias paypalMessage: paypalDonation.message
    property alias paypalLabel: paypalDonation.label
    property alias paypalDescription: paypalDonation.description

    property url bitcoinURI
    property url bitcoinQRImage

    SilicaFlickable {
        id: aboutFlick
        anchors.fill: parent
        contentHeight: imgCol.height + aboutCol.height + contactCol.height + contributeCol.height + licensesCol.height + Theme.paddingLarge + 4 * Theme.paddingMedium
        VerticalScrollDecorator { flickable: aboutFlick; page: about }

        PullDownMenu {
            MenuItem {
                //% "Homepage"
                text: qsTrId("btsc-homepage")
                onClicked: Qt.openUrlExternally(appHomepage)
                visible: appHomepage.toString().length > 0
            }
            MenuItem {
                //% "Privacy Policy"
                text: qsTrId("btsc-priv-policy")
                onClicked: pageStack.push(privacyPolicyQmlFile)
                visible: privacyPolicyQmlFile.length > 0
            }
            MenuItem {
                //% "Changelog"
                text: qsTrId("btsc-changelog")
                onClicked: pageStack.push(Qt.resolvedUrl("Changelog.qml"), {model: changelogModel, bugTrackerBase: bugTrackerBaseUrl})
                visible: changelogModel !== null
            }
            MenuItem {
                //% "Contributors"
                text: qsTrId("btsc-contributors")
                onClicked: pageStack.push(Qt.resolvedUrl("Contributors.qml"), { avatarBasePath: contributorsAvatarBasePath, model: contributorsModel, avatarPlaceholderPath: contributorsPlaceholderPath })
                visible: contributorsModel !== null
            }
        }


        Column {
            id: imgCol
            anchors { left: parent.left; right: parent.right }
            PageHeader {
                id: pHeader;
                page: about
                //% "About"
                title: qsTrId("btsc-about")
            }

            Image {
                id: appCoverImage
                visible: status === Image.Ready
                width: parent.width
                smooth: true
                fillMode: Image.PreserveAspectFit
            }

        }

       Column {
           id: aboutCol
           anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin; top: imgCol.bottom; topMargin: Theme.paddingMedium }
           spacing: Theme.paddingSmall

            Label {
                id: labelName
                textFormat: Text.PlainText
                text: appTitle + " " + Qt.application.version
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
                text: appCopyrightYear !== "" ? String("© %1, %2").arg(appCopyrightYear).arg(appCopyrightHolder) : String("© %1").arg(appCopyrightHolder)
                visible: appCopyrightHolder
            }

            BackgroundItem {
                id: licenseBi
                anchors { left: parent.left; right: parent.right; leftMargin: -Theme.horizontalPageMargin; rightMargin: -Theme.horizontalPageMargin }
                contentHeight: license.height

                enabled: appCustomLicense.toString().length > 0 || appLicenseFile !== ""

                onClicked: {
                    if (appCustomLicense.toString().length > 0) {
                        pageStack.push(appCustomLicense)
                    } else if (appLicenseFile !== "") {
                        pageStack.push("licenses/"+appLicenseFile, {componentName: appTitle, componentAuthor: appCopyrightHolder})
                    }
                }

                Label {
                    id: license
                    anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                    textFormat: Text.PlainText
                    color: licenseBi.highlighted ? Theme.highlightColor : Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.WordWrap
                }

            }
       }

       Column {
           id: contactCol
           anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; top: aboutCol.bottom; topMargin: Theme.paddingMedium }

           //% "Contact"
            SectionHeader { text: qsTrId("btsc-contact") }

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
                text: "<a href='" + contactWebsiteLink + "'>" + contactWebsite + "</a>"
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

            SectionHeader {
                //% "Contribute"
                text: qsTrId("btsc-contribute")
                visible: translateUrl.toString().length > 0 || bugUrl.toString().length > 0
            }

            Row {
                id: contributeRow
                width: parent.width - Theme.paddingLarge
                spacing: Theme.paddingMedium

                Button {
                    width: (parent.width/2) - (parent.spacing/2)
                    //% "Translate"
                    text: qsTrId("btsc-translate")
                    onClicked: Qt.openUrlExternally(translateUrl)
                    visible: translateUrl.toString().length > 0
                }

                Button {
                    width: (parent.width/2) - (parent.spacing/2)
                    //% "Report bugs"
                    text: qsTrId("btsc-report-bugs")
                    onClicked: Qt.openUrlExternally(bugUrl)
                    visible: bugUrl.toString().length > 0
                }
            }

            SectionHeader {
                //% "Donate via PayPal"
                text: qsTrId("btsc-donate-via-paypal")
                visible: paypalDonation.visible
            }

            PaypalChooser {
                id: paypalDonation
                anchors { left: parent.left; leftMargin: -Theme.horizontalPageMargin; right: parent.right }
                //% "Select currency"
                label: qsTrId("btsc-select-currency")
                visible: email && organization
            }

            SectionHeader {
                //% "Donate via Bitcoin"
                text: qsTrId("btsc-donate-via-bitcoin")
                visible: (bitcoinQr.status === Image.Ready || bitcoinQr.status === Image.Loading) || (bitcoinURI.toString() !== "")
            }

            Image {
                id: bitcoinQr
                anchors.horizontalCenter: parent.horizontalCenter
                visible: bitcoinQRImage.toString() !== ""
                source: bitcoinQRImage
            }

            Text {
                id: bitcoinLink
                width: parent.width - Theme.horizontalPageMargin
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                text: String("<a href='%1'>%2</a>").arg(bitcoinURI.toString()).arg(bitcoinURI.toString().slice(bitcoinURI.toString().indexOf(':') + 1, bitcoinURI.toString().lastIndexOf('?')))
                visible: bitcoinURI.toString() !== ""
                onLinkActivated: Qt.openUrlExternally(link)
                textFormat: Text.StyledText
                linkColor: Theme.highlightColor
                font.pixelSize: Theme.fontSizeSmall
                horizontalAlignment: (bitcoinQr.status === Image.Ready || bitcoinQr.status === Image.Loading) ? Text.AlignHCenter : Text.AlignLeft
            }
        }

        Column {
            id: licensesCol
            anchors { left: parent.left; right: parent.right; top: contributeCol.bottom; topMargin: Theme.paddingMedium }

            SectionHeader {
                //% "3rd party components"
                text: qsTrId("btsc-third-party")
                visible: licensesRepeater.count > 0
            }

            Text {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.horizontalPageMargin; rightMargin: Theme.horizontalPageMargin }
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeExtraSmall
                //% "%1 uses the following components:"
                text: qsTrId("btsc-third-party-desc").arg(appTitle)
                visible: licensesRepeater.count > 0
                wrapMode: Text.WordWrap
            }

            Repeater {
                id: licensesRepeater
                width: parent.width

                delegate: LicenseDelegate {}
            }
        }
    }
}
