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


ComboBox {
    property string initialValue
    property string choosenValue
    property alias model: repeater.model

    function getInitialValue() {
        var found = false;
        var i = 0;
        while ((!found) && (i < model.count)) {
            if (repeater.model.get(i).value == initialValue) {
                box.currentIndex = i;
                found = true;
            }
            i++;
        }
    }

    function setChoosenValue()
    {
        var choosen = repeater.model.get(box.currentIndex).value;

        choosenValue = choosen;

        if (choosen !== initialValue) {
//            initialValue = choosen;
//            choosenValue = choosen;
        }
    }

    Component.onCompleted: { choosenValue = initialValue; timer.start() }

    onInitialValueChanged: { choosenValue = initialValue; timer.start() }

//    onCurrentIndexChanged: if (currentIndex > -1) setChoosenValue()
    onCurrentIndexChanged: {
        _currentIndexSet = true
        if (_completed && !_updating) {
            _updating = true
            _updateCurrent(currentIndex, null)
            _updating = false
        }
        if (currentIndex > -1) setChoosenValue()
    }

    id: box
    menu: ContextMenu {
          Repeater {
               id: repeater
               MenuItem { text: model.name; visible: (model.enabled) ? model.enabled : true }
          }
    }

    Timer {
        id: timer
        interval: 500
        repeat: false
        triggeredOnStart: false
        onTriggered: getInitialValue()
    }
}
