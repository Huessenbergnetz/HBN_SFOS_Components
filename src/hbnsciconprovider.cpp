/*
Copyright (c) 2015-2022, Hüssenbergnetz/Matthias Fehring
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

#include "hbnsciconprovider.h"

using namespace Hbnsc;

BaseIconProvider::BaseIconProvider(const QString &providerName, std::initializer_list<qreal> scales, const QString &iconsDir, bool largeAvailable, QQmlEngine *engine)
    : QQuickImageProvider(QQuickImageProvider::Pixmap)
{
    m_iconsDir = Hbnsc::getIconsDir(scales, iconsDir, largeAvailable);

    if (engine) {
        Q_ASSERT_X(!providerName.trimmed().isEmpty(), "constructing BaseIconProvider", "providerName can not be empty when engine is a valid pointer");
        engine->addImageProvider(providerName, this);
    }

    qDebug(R"(Constructing a new icon provider "%s" loading icons from "%s".)", qUtf8Printable(providerName), qUtf8Printable(m_iconsDir));
}

BaseIconProvider::~BaseIconProvider() = default;

QPixmap BaseIconProvider::requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
{
    const int qmPos = id.indexOf(QLatin1Char('?'));
    const QString filePath = m_iconsDir % id.leftRef(qmPos) % QStringLiteral(".png");

    qDebug("Loading image from %s", qUtf8Printable(filePath));

    QPixmap sourcePixmap(filePath, "png");

    if (!sourcePixmap.isNull()) {

        if (size) {
            *size = sourcePixmap.size();
        }

        if (qmPos > -1) {
            const QColor color(id.mid(qmPos + 1));
            if (color.isValid()) {
                QPainter painter(&sourcePixmap);
                painter.setCompositionMode(QPainter::CompositionMode_SourceIn);
                painter.fillRect(sourcePixmap.rect(), color);
                painter.end();
            }
        }

        if (!requestedSize.isEmpty()) {
            return sourcePixmap.scaled(requestedSize);
        }
    }

    return sourcePixmap;
}

void BaseIconProvider::addProvider(QQmlEngine *engine, const QString &providerName, std::initializer_list<qreal> scales, const QString &iconsDir, bool largeAvailable)
{
    Q_ASSERT_X(engine, "BaseIconProvider::addProvider", "invalid QQmlEngine pointer");
    new BaseIconProvider(providerName, scales, iconsDir, largeAvailable, engine);
}

HbnscIconProvider::HbnscIconProvider(QQmlEngine *engine)
    : BaseIconProvider(QStringLiteral("hbnsc"), {1.0, 1.25, 1.5, 1.75, 2.0}, QStringLiteral(HBNSC_ICONS_DIR), false, engine)
{

}

HbnscIconProvider::~HbnscIconProvider() = default;

void HbnscIconProvider::addProvider(QQmlEngine *engine)
{
    Q_ASSERT_X(engine, "HbnscIconProvider::addProvider", "invalid QQmlEngine pointer");
    new HbnscIconProvider(engine);
}
