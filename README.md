# HBN SFOS Components
A set of QML components to use on Sailfish OS.

## Integrate into your Sailfish OS application
The easiest way is to simple download the latest release tarball. You can than copy the files you want to use
into your source tree. You should keep the directory layout of HBN SFOS components, at least the one in the qml
directory.

A better, and on the long run more comfortable solution, is to clone this repository and checkout the current stable
branch/tag to work with. Or integrate it as a submodule into your project git tree.

### Cloning and branching
    git clone --branch v1.3.3 https://github.com/Huessenbergnetz/HBN_SFOS_Components.git

### Integrate into your project
You can copy the files or, the better way, include the configuration into your project.

    include(path/to/HBN_SFOS_Components/HBN_SFOS_Components.pri)

To install the files of the HBN SFOS Components into the right location, you have nothing to do. If your app
for example is named *harbour-myapp*, the following installation paths will be used:
* qml files go into */usr/share/harbour-myapp/de/huessenbergnetz/hbnsc*
* icon files go into */usr/share/harbour-myapp/de/huessenbergnetz/hbnsc/icons*
* translations go into */usr/share/harbour-myapp/translations*

Optionally you can define the installation directories independently.

    HBNSC_INSTALL_ICONS_DIR // install path for the icons
    INSTALL_TRANSLATIONS_DIR // install path for the translation files (*.qm)

### Optional variables
By default, all license page files will be installed. You can use the `HBNSC_LICENSES` variable to specify the
license pages you want to install. Have a look into the [qml/licenses](https://github.com/Huessenbergnetz/HBN_SFOS_Components/tree/master/qml/licenses)
directory for the available license page files and their names. To select only some pages to install, set their
base names withouth the extensions to the `HBNSC_LICENSES` variable.

    HBNSC_LICENSES="GPLv3 LGPLv3"

This will only include the license page files for GPL and LGPL in version 3.

### Build the icons

The icons included in the source tarball are SVG files that have to be converted into PNG files. There is a a Bash script called
[createIcons.sh](https://github.com/Huessenbergnetz/HBN_SFOS_Components/tree/master/images/createIcons.sh) in the *images* directory
that will do the job for you. It will automatically create the required icons for different resolution scales. To convert the
icons, [Inkscape](https://inkscape.org/) has to available. It is also recommended to have [GNU parallel](https://www.gnu.org/software/parallel/)
installed to speed up the conversion. Another recommendation is [zopflipng](https://github.com/google/zopfli) that will
further improve the size of the created PNG files.

    cd HBN_SFOS_Components/images
    ./createIcons.sh

That will create icons for the following scalings: 1, 1.25, 1.5, 1.75 and 2.

### Integrate translations

Unless you specify a different value for `INSTALL_TRANSLATIONS_DIR` the translation files of HBN SFOS Components will be
installed into */usr/share/harbour-myapp/translations*. To include the translations (they are ID based) into
your application, you have to load them into a QTranslator for your application (in your main.cpp or wherever you define
your QGuiApplication). The base name of the translation files is *hbnsc*, the delimeter is an underscore.

    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));

    QTranslator *hbnscTrans = new QTranslator(app);
    if (hbnscTrans->load(QLocale(), QStringLiteral("btsc"), QStringLiteral("_"), SailfishApp::pathTo(QStringLiteral("translations")).toString(QUrl::RemoveScheme)) {
        app->installTranslator(hbnscTrans)
    }

### Integrate icon provider

To show the included icons with the appropriate size and scaling, add [hbnciconprovider.h](https://github.com/Huessenbergnetz/HBN_SFOS_Components/tree/master/src/hbnsciconprovider.h)
to your project. It uses libsailfishsilica to determine the pixel ratio to select the best fitting icon scaling.

To automatically install the devel files of libsailfishsilica in the SDK, add the follwing to your YAML RPM spec file into the *PkgConfigBR* section:

    PkgConfigBR:
      - sailfishsilica

Then in your main function file or where you load your application, include the headers and install the icon provider:

    #include "hbnsciconprovider.h"

    int main(int argc, char *argv[])
    {

        // .... other stuff ...

        QScopedPointer<QQuickView> view(SailfishApp::createView());

	QScopedPointer<Hbnsc::HbnscIconProvider> hbnscIconProvider(new Hbnsc::HbnscIconProvider(view->engine()));
    }

## Components API

### PaypalChooser

The *PaypalChooser* can be used to offer a ComboBox that lets the user choose from a list of currencies. If the user
chooses a currency, a browser window will be opened with a PayPal donation site.

    import de.huessenbergnetz.hbnsc 1.0

    PaypalChooser {
        // address of the PayPal account that will receive the donation (mandatory)
        email: me@exmaple.com

        // name of your organization or yourself (mandatory, but free definable)
        organization: "Me myself"

        // name of your app or whatever (optional)
        item: "My App"

        // message shown to the donator (optional)
        message: "Thank you for your donation."

        // label shown on the ComboBox (optional), default is "Donate via PayPal in"
        label: "Donate"

        // description below the ComboBox (optional)
        description: "We like donations."
    }

### AboutPage

Implements an about page and optionally pages about contributors, changelog and third party components.

    import de.huessenbergnetz.hbnsc 1.0

    AboutPage {

        // the title of the about page, default is "About" (optional)
        pageTitle: "About"

        // the name of you app (mandatory)
        appTitle: "My App"

        // cover image, will be displayed in the page header (optional)
        appCover: "/usr/share/harbour-myapp/images/cover.jpg"

        // description what your app is doing (optional)
        appDescription: "Performs really awesome stuff."

        // link to the homepage of the app, will be shown in the pull down menu (optional)
        appHomepage: "https://www.example.com"

        // the copyright start year of your app
        appCopyrightYearFrom: "2016"

	// the copyright end year of your app, mostly the current year (optional)
	appCopyrightYearTo: "2018"

        // the copyright holder, your name or whoever (optional)
        appCopyrightHolder: "Me"

        // name of the license your app is licensed under (optional)
        appLicense: "GNU General Public License, Version 3"

        // name of a license page file in qml/licenses (optional)
        // will be opened when the user presses the license string
        // if you define a appCustomLicense, that will take precedence
        appLicenseFile: "GPLv3.qml"

        // url to a custom license page file (optional)
        // will be opened when the user presses the license string
        // takes precedence above appLicenseFile
        appCustomLicense: Qt.resolvedUrl("MyOwnLicense.qml")

        // url to a page that shows you privacy policy (optional)
        // will show an entry in the pull down menu
        privacyPolicyQmlFile: Qt.resolvedUrl("MyPrivacyPolicy.qml")

        // ListModel containing your changelog (optional)
        // will show a MenuItem in the PullDownMenu to show the changelog
        // look further down to see an example for a changelog model
        changelogModel: MyChangeLogModel {}

        // url to which the issue numbers from the changelog model will be appended (optional)
        // most bugtrackers follow a specific scheme for their issue links (like githubg)
        bugTrackerBaseUrl: "https://github.com/Buschtrommel/BT_SFOS_Components/issues/"

        // ListModel containing your contributors (optional)
        // will show a MenuItem in the PullDownMenu to show the changelog
        // look further down to see an example for a contributors model
        contributorsModel: MyContributorsModel {}

        // base path to the avatar images of your contributors (optional)
        // used inside the delegate displaying the contributor
        contributorsAvatarBasePath: "/usr/share/harbour-myapp/images/contributors"

        // contact information (optional)
        contactCompany: "Little Company"
        contactName: "Me"
        contactStreet: "Small street"
        contactHouseNo: "0"
        contactZIP: "12345"
        contactCity: "Smaller city"
        contactCountry: "Smallest country"
        contactEmail: "contact@example.com"
        // the website of the developer/company, this is part visible to the user
        contactWebsite: "example.com"
        // the link to the website of the developer/company, this is the link that
        // will be opened if the user clicks on the visible part
        contactWebsiteLink: "https://www.example.com"

        // url to your bug tracker (optional)
        // will show a button opening the url
        bugUrl: "https://github.com/Huessenbergnetz/HBN_SFOS_Components/issues"

        // url to your online translation system (optional)
        // will show a button opening the url
        translateUrl: "https://www.transifex.com/huessenbergnetz/hbn-sfos-components"

        // ListModel containing information about used 3rd party stuff (optional)
        // look further down to see an example for a licenses model
        licensesModel: UsedComponentsModel {}

        // information to show a PaypalChooser on the AboutPage (optional)
        // have a look up the page for more information about the properties
        paypalOrganization: "Me or my organization"
        paypalItem: "MyApp"
        paypalEmail: "contact@example.com"
        paypalMessage: "Thank you for your donation."
        paypalLabel: "Donate"
        paypalDescription: "A donation would be nice."

	// information to show a Bitcoin donation link on the AboutPage (optional)
	// a bitcoin URI that will show the bitcoin address linked to the URI
	bitcoinURI: "bitcoin:12TmPhHeEoc5htME4D6aaGLsgTMfWNm6re?label=BT%20SFOS%20Components&message=Thank%20you%20for%20your%20donation%21"
	// URL of a bitcoin QR code image
	bitcoinQRImage: Qt.resolvedUrl("/usr/share/harbour-myapp/images/bitcoin-qr-code.png")
    }

### Changelog model example
ListModel used to show changelog entries. Used at AboutPage::changelogModel

Changelog entry types:
* 0 - New
* 1 - Improved/Enhanced
* 2 - Fixed
* 3 - Note

```
    ListModel {
        ListElement {
            // simple version string
            version: "0.0.2"

            // release date unix timestamp
            date: 1476809072000

            // entries list
            entries: [
                ListElement {

                    // entry type
                    type: 2

                    // bug tracker issue number
                    // bugTrackerBaseUrl on AboutPage has to be set to create a link
                    issue: "23"

                    description: "fixed aweful bug"
                },
                ListElement {
                    type: 1
                    issue: ""
                    description: "awesome new feature"
                }
            ]
        }
    }
```

### Contributors model example
ListModel containing a list of contributors. Used at AboutPage::contributorsModel

     ListModel {
        ListElement {

            // name of the contributor (mandatory)
            name: "Buschmann"

            // role of the contributor (mandatory)
            role: "BT SFOS creator, main developer"

            // will show a section header (mandatory)
            section: "Author"

            // contributor avatar (optional)
            // should be inside AboutPage::contributorsAvatarBasePath
            // if no image is set, "image://theme/icon-l-people" will be used
            image: "buschmann.png"

            // contributor's website url (optional)
            website: "https://www.buschmann23.de"

            // twitter username (optional)
            // part of https://twitter.com/USERNAME
            twitter: "buschmann23"

            // github username (optional)
            // part of https://github/USERNAME
            github: "buschmann23"

            // bitbucket username (optional)
            // part of https://bitbucket.org/USERNAME
            bitbucket: ""

            // linkedin id (optional)
            // part of https://www.linkedin.com/profile/view?id=USERID
            linkedin: ""

            // sina weibo username (optional)
            // part of http://www.weibo.com/USERNAME
            weibo: ""

            // talk.maemo.org profile (optional)
            // part of https://talk.maemo.org/member.php?u=USERID
            tmo: ""

            // facebook profile (optional)
            // part of https://www.facebook.com/PROFILE.NAME
            facebook: ""

            // google plus profile (optional)
            // part of https://plus.google.com/PROFILE.NAME
            googleplus: ""
        }
     }

### 3rd party components model example
Used to show a list of 3rd party components. Used on AboutPage::licensesModel

    ListModel {

        // name of the component (mandatory)
        name: "libfuoten"

        // author of the component (mandatory)
        author: "Buschtrommel"

        // version of the component (optional)
        version: "0.0.1"

        // license of the component (mandatory)
        license: "GNU Lesser General Public License, Version 3"

        // one of the license files in qml/licenses (optional)
        // takes precedence over customLicenseFile
        licenseFile: "LGPLv3.qml"

        // custom license page file (optional)
        customLicenseFile: Qt.resolvedUrl("CustomLicense.qml")

        // website of the component (optional)
        website: "https://github.com/Huessenbergnetz/libfuoten"

        // description of the component (optional)
        description: "Libfuoten is a Qt based library that provides access the ownCloud/Nextcloud News App API."

	// website of the license (optional)
	licenseWebsite: "https://github.com/Huessenbergnetz/libfuoten/blob/master/LICENSE"
    }


## License
Copyright (c) 2015-2018, Hüssenbergnetz/Matthias Fehring
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

* Neither the name of BT SFOS Components nor the names of its
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
