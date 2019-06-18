/*
Copyright (c) 2015-2019, Hüssenbergnetz/Matthias Fehring
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

#ifndef HBNSCLANGUAGEMODEL_H
#define HBNSCLANGUAGEMODEL_H

#include <QAbstractListModel>
#include <vector>
#include <utility>

namespace Hbnsc {

class LanguageModel : public QAbstractListModel
{
    Q_OBJECT
    Q_DISABLE_COPY(LanguageModel)
    std::vector<std::pair<QString,QString>> m_langs;
public:
    explicit LanguageModel(const QStringList &supportedLangs, QObject *parent = nullptr);
    LanguageModel(const QString &transDir, const QString &transName, QObject *parent = nullptr);
    ~LanguageModel() override;

    enum Roles {
        Code = Qt::UserRole +1,
        Name
    };

    int rowCount(const QModelIndex &parent = QModelIndex()) const override final;
    QModelIndex index(int row, int column = 0, const QModelIndex &parent = QModelIndex()) const override final;
    QHash<int, QByteArray> roleNames() const override final;
    QVariant data(const QModelIndex &index, int role = Qt::UserRole) const override final;

    /*!
     * \brief Returns the index of the language identified by \a langCode.
     */
    Q_INVOKABLE int findIndex(const QString &langCode) const;

private:
    void populate(const QStringList &supportedLangs);
};

}

#endif // HBNSCLANGUAGEMODEL_H
