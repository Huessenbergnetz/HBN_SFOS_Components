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

Item {
    id: root
    height: donation.height
    anchors { left: parent.left; right: parent.right }

    property string email
    property string organization
    property string item
    property string message
    property string url
    property string label

    function openDonation(currency)
    {
        var lang = "";
        var locale = new String(Qt.locale().name);
        var cc = locale.slice(3, 5);

        console.log(locale)
        console.log(cc)

        switch (locale) {
        case "da_DK":
        case "he_IL":
        case "id_ID":
        case "ja_JP":
        case "no_NO":
        case "pt_BR":
        case "ru_RU":
        case "sv_SE":
        case "th_TH":
        case "tr_TR":
        case "zh_CN":
        case "zh_HK":
        case "zh_TW":
            lang = locale;
            break;
        default:
            lang = "";
            break;
        }

        if (lang === "") {
            switch(cc) {
            case "AU":
            case "AT":
            case "BE":
            case "BR":
            case "CA":
            case "CH":
            case "CN":
            case "DE":
            case "ES":
            case "GB":
            case "FR":
            case "IT":
            case "NL":
            case "PL":
            case "PT":
            case "RU":
                lang = cc;
                break;
            default:
                lang = "US";
                break;
            }
        }

        if (currency !== "") {
            url = "https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=" + email +"&lc=" + lang +"&item_name="+ organization +"&item_number=" + item +"&no_note=0&cn="+ message + "&no_shipping=1&currency_code="+ currency +"&bn=PP%2dDonationsBF%3abtn_donate_LG%2egif%3aNonHosted"

            Qt.openUrlExternally(encodeURI(url))
        }

    }

    ListModel {
        id: donationModel
        ListElement { name: ""; value: "" }
        ListElement { name: ""; value: "EUR" }
        ListElement { name: ""; value: "USD" }
        ListElement { name: ""; value: "AUD" }
        ListElement { name: ""; value: "BRL" }
        ListElement { name: ""; value: "GBP" }
        ListElement { name: ""; value: "DKK" }
        ListElement { name: ""; value: "HKD" }
        ListElement { name: ""; value: "ILS" }
        ListElement { name: ""; value: "JPY" }
        ListElement { name: ""; value: "CAD" }
        ListElement { name: ""; value: "MXN" }
        ListElement { name: ""; value: "TWD" }
        ListElement { name: ""; value: "NZD" }
        ListElement { name: ""; value: "NOK" }
        ListElement { name: ""; value: "PHP" }
        ListElement { name: ""; value: "PLN" }
        ListElement { name: ""; value: "RUB" }
        ListElement { name: ""; value: "SEK" }
        ListElement { name: ""; value: "CHF" }
        ListElement { name: ""; value: "SGD" }
        ListElement { name: ""; value: "THB" }
        ListElement { name: ""; value: "CZK" }
        ListElement { name: ""; value: "HUF" }
        Component.onCompleted: {
            donationModel.get(0).name = qsTr("Currency")
            donationModel.get(1).name = qsTr("Euro")
            donationModel.get(2).name = qsTr("US Dollar")
            donationModel.get(3).name = qsTr("Australian Dollar")
            donationModel.get(4).name = qsTr("Brazilian Real")
            donationModel.get(5).name = qsTr("Pound Sterling")
            donationModel.get(6).name = qsTr("Danish Krone")
            donationModel.get(7).name = qsTr("Hong Kong Dollar")
            donationModel.get(8).name = qsTr("Israel New Shekel")
            donationModel.get(9).name = qsTr("Japanese Yen")
            donationModel.get(10).name = qsTr("Canadian Dollar")
            donationModel.get(11).name = qsTr("Mexican Peso")
            donationModel.get(12).name = qsTr("New Taiwan Dollar")
            donationModel.get(13).name = qsTr("New Zealand Dollar")
            donationModel.get(14).name = qsTr("Norwegian Krone")
            donationModel.get(15).name = qsTr("Philippine Peso")
            donationModel.get(16).name = qsTr("Polish Zloty")
            donationModel.get(17).name = qsTr("Russian Ruble")
            donationModel.get(18).name = qsTr("Swedish Krone")
            donationModel.get(19).name = qsTr("Swiss Franc")
            donationModel.get(20).name = qsTr("Singapore Dollar")
            donationModel.get(21).name = qsTr("Thai Baht")
            donationModel.get(22).name = qsTr("Czech Koruna")
            donationModel.get(23).name = qsTr("Hungarian Forint")
        }
    }

    ComboBoxList {
        id: donation
        anchors { left: parent.left; right: parent.right }
        label: root.label
        model: donationModel
        onChoosenValueChanged: openDonation(choosenValue)
    }
}
