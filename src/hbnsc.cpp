#include "hbnsc.h"

#include <QTranslator>
#include <QStringList>
#include <QStringBuilder>
#include <QCoreApplication>

#ifndef CLAZY
#include <silicatheme.h>
#include <silicascreen.h>
#include <sailfishapp.h>
#endif

QString Hbnsc::getLauncherIcon(std::initializer_list<int> sizes)
{
    QString iconPath;

#ifndef CLAZY
    const int size = static_cast<int>(Silica::Theme::instance()->iconSizeLauncher());
    const QStringList dirs = Silica::Theme::instance()->launcherIconDirectories();
#else
    const int size = 86;
    const QStringList dirs;
#endif

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
            iconPath = dir % QCoreApplication::instance()->applicationName() % QStringLiteral(".png");
            break;
        }
    }

    qDebug("Found app launcher icon for size %i at \"%s\".", size, qUtf8Printable(iconPath));

    return iconPath;
}

QString Hbnsc::getIconsDir(std::initializer_list<qreal> scales, const QString &iconsDir, bool largeAvailable)
{
    QString ret;

#ifndef CLAZY
    const QString _iconsDir = !iconsDir.trimmed().isEmpty() ? iconsDir : SailfishApp::pathTo(QStringLiteral("icons")).toString(QUrl::RemoveScheme);
    const qreal pixelRatio = Silica::Theme::instance()->pixelRatio();
    const bool large = largeAvailable ? (Silica::Screen::instance()->sizeCategory() >= Silica::Screen::Large) : false;
#else
    const QString _iconsDir;
    const qreal pixelRatio = 1.0;
    const bool large = largeAvailable;
#endif

    qreal nearestScale = 1.0;

    if (scales.size() > 1) {
        qreal lastDiff = 999.0;
        for (qreal currentScale : scales) {
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

    ret = _iconsDir % (iconsDir.endsWith(QLatin1Char('/')) ? QStringLiteral("z") : QStringLiteral("/z")) % QString::number(nearestScale) % (large ? QStringLiteral("-large/") : QStringLiteral("/"));

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
