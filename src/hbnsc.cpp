/*
 C o*pyright (c) 2015-2022, Hüssenbergnetz/Matthias Fehring
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

#include "hbnsc.h"

#include <QTranslator>
#include <QStringList>
#include <QStringBuilder>
#include <QCoreApplication>
#include <silicatheme.h>
#include <silicascreen.h>
#include <sailfishapp.h>

constexpr qreal operator "" _qr(long double a){ return qreal(a); }

QString Hbnsc::getLauncherIcon(std::initializer_list<int> sizes)
{
    QString iconPath;

    const int size = static_cast<int>(Silica::Theme::instance()->iconSizeLauncher());
    const QStringList dirs = Silica::Theme::instance()->launcherIconDirectories();

    int nearestSize = 86;
    int lastDiff = 999;

    for (int currentSize : sizes) {
        const int diff = std::abs(currentSize - size);
        if (diff < lastDiff) {
            nearestSize = currentSize;
            lastDiff = diff;
        }
        if (lastDiff == 0) {
            break;
        }
    }

    const QString numberString = QString::number(nearestSize);
    const QString sizeStr = numberString % QLatin1Char('x') % numberString;

    for (const QString &dir : dirs) {
        if (dir.contains(sizeStr)) {
            iconPath = dir % QCoreApplication::applicationName() % QStringLiteral(".png");
            break;
        }
    }

    qDebug("Found app launcher icon for size %i at \"%s\".", size, qUtf8Printable(iconPath));

    return iconPath;
}

QString Hbnsc::getIconsDir(std::initializer_list<qreal> scales, const QString &iconsDir, bool largeAvailable)
{
    QString ret;

    const QString _iconsDir = !iconsDir.trimmed().isEmpty() ? iconsDir : SailfishApp::pathTo(QStringLiteral("icons")).toString(QUrl::RemoveScheme);
    const qreal pixelRatio = Silica::Theme::instance()->pixelRatio();
    const bool large = largeAvailable ? (Silica::Screen::instance()->sizeCategory() >= Silica::Screen::Large) : false;

    qreal nearestScale = 1.0;

    if (scales.size() > 1) {
        qreal lastDiff = 999.0;
        for (const qreal currentScale : scales) {
            const qreal diff = std::abs(currentScale - pixelRatio);
            if (diff < lastDiff) {
                nearestScale = currentScale;
                lastDiff = diff;
            }
            if (lastDiff == 0.0) {
                break;
            }
        }

    } else if (scales.size() == 1) {

        auto scalesIt = scales.begin();
        nearestScale = *scalesIt;

    } else {
        nearestScale = pixelRatio;
    }

    QString numberStr;
    if (nearestScale == 1.0_qr) {
        numberStr = QStringLiteral("1.0");
    } else if (nearestScale == 2.0_qr) {
        numberStr = QStringLiteral("2.0");
    } else if (nearestScale == 3.0_qr) {
        numberStr = QStringLiteral("3.0");
    } else if (nearestScale == 4.0_qr) {
        numberStr = QStringLiteral("4.0");
    } else {
        numberStr = QString::number(nearestScale);
    }

    ret = _iconsDir % (iconsDir.endsWith(QLatin1Char('/')) ? QStringLiteral("z") : QStringLiteral("/z")) % numberStr % (large ? QStringLiteral("-large/") : QStringLiteral("/"));

    return ret;
}

QVersionNumber Hbnsc::version()
{
    return QVersionNumber::fromString(QStringLiteral(HBNSC_VERSION));
}

bool Hbnsc::loadTranslations(const QLocale &locale)
{
    auto t = new QTranslator(QCoreApplication::instance());
    if (t->load(locale, QStringLiteral("hbnsc"), QStringLiteral("_"), QStringLiteral(HBNSC_L10N_DIR))) {
        return QCoreApplication::installTranslator(t);
    }
    return false;
}
