/*
Copyright (c) 2016, Buschtrommel
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

LicenseBase {

    licenseName: "GNU LESSER GENERAL PUBLIC LICENSE"
    licenseWebsite: "http://www.gnu.org/licenses/lgpl-3.0.en.html"

    licenseModel: ListModel {
        ListElement {
            text: "Version 3, 29 June 2007"
        }

        ListElement {
            format: Text.StyledText
            text: "Copyright © 2007 Free Software Foundation, Inc. &lt;<a href='http://fsf.org'>http://fsf.org/</a>&gt;"
        }

        ListElement {
            text: "Everyone is permitted to copy and distribute verbatim copies of this license document, but changing it is not allowed."
        }

        ListElement {
            text: "This version of the GNU Lesser General Public License incorporates the terms and conditions of version 3 of the GNU General Public License, supplemented by the additional permissions listed below."
        }

        ListElement {
            text: "0. Additional Definitions."
            header: true
        }

        ListElement {
            text: "As used herein, “this License” refers to version 3 of the GNU Lesser General Public License, and the “GNU GPL” refers to version 3 of the GNU General Public License."
        }

        ListElement {
            text: "“The Library” refers to a covered work governed by this License, other than an Application or a Combined Work as defined below."
        }

        ListElement {
            text: "An “Application” is any work that makes use of an interface provided by the Library, but which is not otherwise based on the Library. Defining a subclass of a class defined by the Library is deemed a mode of using an interface provided by the Library."
        }

        ListElement {
            text: "A “Combined Work” is a work produced by combining or linking an Application with the Library. The particular version of the Library with which the Combined Work was made is also called the “Linked Version”."
        }

        ListElement {
            text: "The “Minimal Corresponding Source” for a Combined Work means the Corresponding Source for the Combined Work, excluding any source code for portions of the Combined Work that, considered in isolation, are based on the Application, and not on the Linked Version."
        }

        ListElement {
            text: "The “Corresponding Application Code” for a Combined Work means the object code and/or source code for the Application, including any data and utility programs needed for reproducing the Combined Work from the Application, but excluding the System Libraries of the Combined Work."
        }

        ListElement {
            header: true
            text: "1. Exception to Section 3 of the GNU GPL."
        }

        ListElement {
            text: "You may convey a covered work under sections 3 and 4 of this License without being bound by section 3 of the GNU GPL."
        }

        ListElement {
            header: true
            text: "2. Conveying Modified Versions."
        }

        ListElement {
            text: "If you modify a copy of the Library, and, in your modifications, a facility refers to a function or data to be supplied by an Application that uses the facility (other than as an argument passed when the facility is invoked), then you may convey a copy of the modified version:"
        }

        ListElement {
            format: Text.RichText
            text: "<ul><li>a) under this License, provided that you make a good faith effort to ensure that, in the event an Application does not supply the function or data, the facility still operates, and performs whatever part of its purpose remains meaningful, or</li><li>b) under the GNU GPL, with none of the additional permissions of this License applicable to that copy.</li></ul>"
        }

        ListElement {
            header: true
            text: "3. Object Code Incorporating Material from Library Header Files."
        }

        ListElement {
            text: "The object code form of an Application may incorporate material from a header file that is part of the Library. You may convey such object code under terms of your choice, provided that, if the incorporated material is not limited to numerical parameters, data structure layouts and accessors, or small macros, inline functions and templates (ten or fewer lines in length), you do both of the following:"
        }

        ListElement {
            format: Text.RichText
            text: "<ul><li>a) Give prominent notice with each copy of the object code that the Library is used in it and that the Library and its use are covered by this License.</li><li>b) Accompany the object code with a copy of the GNU GPL and this license document.</li></ul>"
        }

        ListElement {
            header: true
            text: "4. Combined Works."
        }

        ListElement {
            text: "You may convey a Combined Work under terms of your choice that, taken together, effectively do not restrict modification of the portions of the Library contained in the Combined Work and reverse engineering for debugging such modifications, if you also do each of the following:"
        }

        ListElement {
            format: Text.RichText
            text: "<ul><li>a) Give prominent notice with each copy of the Combined Work that the Library is used in it and that the Library and its use are covered by this License.</li><li>b) Accompany the Combined Work with a copy of the GNU GPL and this license document.</li><li>c) For a Combined Work that displays copyright notices during execution, include the copyright notice for the Library among these notices, as well as a reference directing the user to the copies of the GNU GPL and this license document.</li><li>d) Do one of the following:<ul><li>0) Convey the Minimal Corresponding Source under the terms of this License, and the Corresponding Application Code in a form suitable for, and under terms that permit, the user to recombine or relink the Application with a modified version of the Linked Version to produce a modified Combined Work, in the manner specified by section 6 of the GNU GPL for conveying Corresponding Source.</li><li>1) Use a suitable shared library mechanism for linking with the Library. A suitable mechanism is one that (a) uses at run time a copy of the Library already present on the user's computer system, and (b) will operate properly with a modified version of the Library that is interface-compatible with the Linked Version.</li></ul></li><li>e) Provide Installation Information, but only if you would otherwise be required to provide such information under section 6 of the GNU GPL, and only to the extent that such information is necessary to install and execute a modified version of the Combined Work produced by recombining or relinking the Application with a modified version of the Linked Version. (If you use option 4d0, the Installation Information must accompany the Minimal Corresponding Source and Corresponding Application Code. If you use option 4d1, you must provide the Installation Information in the manner specified by section 6 of the GNU GPL for conveying Corresponding Source.)</li></ul>"
        }

        ListElement {
            header: true
            text: "5. Combined Libraries."
        }

        ListElement {
            text: "You may place library facilities that are a work based on the Library side by side in a single library together with other library facilities that are not Applications and are not covered by this License, and convey such a combined library under terms of your choice, if you do both of the following:"
        }

        ListElement {
            format: Text.RichText
            text: "<ul><li>a) Accompany the combined library with a copy of the same work based on the Library, uncombined with any other library facilities, conveyed under the terms of this License.</li><li>b) Give prominent notice with the combined library that part of it is a work based on the Library, and explaining where to find the accompanying uncombined form of the same work.</li></ul>"
        }

        ListElement {
            header: true
            text: "6. Revised Versions of the GNU Lesser General Public License."
        }

        ListElement {
            text: "The Free Software Foundation may publish revised and/or new versions of the GNU Lesser General Public License from time to time. Such new versions will be similar in spirit to the present version, but may differ in detail to address new problems or concerns."
        }

        ListElement {
            text: "Each version is given a distinguishing version number. If the Library as you received it specifies that a certain numbered version of the GNU Lesser General Public License “or any later version” applies to it, you have the option of following the terms and conditions either of that published version or of any later version published by the Free Software Foundation. If the Library as you received it does not specify a version number of the GNU Lesser General Public License, you may choose any version of the GNU Lesser General Public License ever published by the Free Software Foundation."
        }

        ListElement {
            text: "If the Library as you received it specifies that a proxy can decide whether future versions of the GNU Lesser General Public License shall apply, that proxy's public statement of acceptance of any version is permanent authorization for you to choose that version for the Library."
        }
    }
}
