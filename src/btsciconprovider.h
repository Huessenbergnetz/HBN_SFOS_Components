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

#ifndef BTSCICONPROVIDER_H
#define BTSCICONPROVIDER_H

#include <QQuickImageProvider>
#include <QPainter>
#include <QColor>
#include <QStringBuilder>
#include <QVector>
#include <QDir>
#include <QFileInfoList>
#include <initializer_list>

class BtscIconProvider : public QQuickImageProvider
{
public:
    BtscIconProvider(std::initializer_list<qreal> scales, qreal pixelRatio = 1.0, bool large = false) : QQuickImageProvider(QQuickImageProvider::Pixmap)
    {
        qreal nearestScale = 1.0;

        if (scales.size() > 1) {
            qreal lastDiff = 999.0;
            for (qreal currentScale : scales) {
                qreal diff = (currentScale - pixelRatio);
                if (diff < 0) {
                    diff *= -1.0;
                }
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

        m_iconsDir = QStringLiteral(BTSC_ICONS_DIR) % QLatin1Char('z') % QString::number(nearestScale) % (large ? QStringLiteral("-large/") : QStringLiteral("/"));

        qDebug("Constructing a new BtscIconProvider object for a pixel ratio of %.2f on a %s screen. Loading icons from \"%s\".", nearestScale, large ? "large" : "small", qUtf8Printable(m_iconsDir));
    }

    ~BtscIconProvider() override
    {
        qDebug("Deconstructing the BtscIconProvider object.");
    }

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) override
    {
        const QStringList parts = id.split(QLatin1Char('?'), QString::SkipEmptyParts);
        const QString filePath = m_iconsDir % parts.at(0) % QStringLiteral(".png");
        QPixmap sourcePixmap(filePath);

        if (!sourcePixmap.isNull()) {

            if (size) {
                *size = sourcePixmap.size();
            }

            if (parts.size() > 1 && QColor::isValidColor(parts.at(1))) {
                QPainter painter(&sourcePixmap);
                painter.setCompositionMode(QPainter::CompositionMode_SourceIn);
                painter.fillRect(sourcePixmap.rect(), parts.at(1));
                painter.end();
            }
        }

        if (!sourcePixmap.isNull() && requestedSize.width() > 0 && requestedSize.height() > 0 && sourcePixmap.size() != requestedSize) {
            return sourcePixmap.scaled(requestedSize.width(), requestedSize.height(), Qt::IgnoreAspectRatio);
        } else {
            return sourcePixmap;
        }
    }

private:
    QString m_iconsDir;
};

#endif // BTSCICONPROVIDER_H
