import QtQuick 2.2
import Sailfish.Silica 1.0

LicenseBase {
    licenseName: "zlib License"
    licenseWebsite: "http://zlib.net/zlib_license.html"

    licenseModel: ListModel {
        ListElement {
            text: "This software is provided 'as-is', without any express or implied warranty. In no event will the authors be held liable for any damages arising from the use of this software."
        }

        ListElement {
            text: "Permission is granted to anyone to use this software for any purpose, including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:"
        }

        ListElement {
            format: Text.StyledText
            text: "<ol><li>The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation would be appreciated but is not required.</li><li>Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.</li><li>This notice may not be removed or altered from any source distribution.</li></ol>"
        }
    }
}
