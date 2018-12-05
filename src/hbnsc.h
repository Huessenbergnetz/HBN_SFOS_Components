#ifndef HBNSC_H
#define HBNSC_H

#include <QString>
#include <QStringList>
#include <QStringBuilder>
#include <QCoreApplication>
#include <QVersionNumber>

#ifndef CLAZY
#include <silicatheme.h>
#endif

#include <initializer_list>

namespace Hbnsc {

static QString getLauncherIcon(std::initializer_list<int> sizes)
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
            iconPath = dir % qApp->applicationName() % QStringLiteral(".png");
            break;
        }
    }

    qDebug("Found app launcher icon for size %i at \"%s\".", size, qUtf8Printable(iconPath));

    return iconPath;
}

static QVersionNumber version()
{
    return QVersionNumber::fromString(QStringLiteral(HBNSC_VERSION));
}

}

#endif // HBNSC_H
