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

#ifndef HBNSCICONPROVIDER_H
#define HBNSCICONPROVIDER_H

#include <QQuickImageProvider>
#include <QPainter>
#include <QColor>
#include <QStringBuilder>
#include <QQmlEngine>
#include <QUrl>
#include <initializer_list>
#include <memory>
#include "hbnsc.h"

namespace Hbnsc {

class HBNSC_EXPORT BaseIconProvider : public QQuickImageProvider
{
public:
    BaseIconProvider(std::initializer_list<qreal> scales, const QString &iconsDir = QString(), bool largeAvailable = false);

    ~BaseIconProvider() override;

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize) override;

    static void addProvider(QQmlEngine *engine, const QString &providerName, std::initializer_list<qreal> scales, const QString &iconsDir = QString(), bool largeAvailable = false);

    Q_DISABLE_COPY(BaseIconProvider)
    BaseIconProvider(BaseIconProvider &&other) = delete;
    BaseIconProvider &operator=(BaseIconProvider &&other) = delete;

private:
    QString m_iconsDir;
};

class HBNSC_EXPORT HbnscIconProvider : public BaseIconProvider
{
public:
    HbnscIconProvider();

    ~HbnscIconProvider() override;

    static void addProvider(QQmlEngine *engine);

    Q_DISABLE_COPY(HbnscIconProvider)
    HbnscIconProvider(HbnscIconProvider &&other) = delete;
    HbnscIconProvider &operator=(HbnscIconProvider &&other) = delete;
};

}

#endif // HBNSCICONPROVIDER_H
