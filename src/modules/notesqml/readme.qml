/* === This file is part of Calamares - <https://calamares.io> ===
 *
 *   Copyright 2020, Anke Boersma <demm@kaosx.us>
 *   Copyright 2020, Adriaan de Groot <groot@kde.org>
 *   SPDX-License-Identifier: GPL-3.0-or-later
 *
 */

/* Some Calamares internals are available to all QML modules.
 * They live in the io.calamares namespace (filled programmatically
 * by Calamares). One of the internals that is exposed in the sub-
 * namespace io.calamares.ui is the Branding object, which can be used
 * to retrieve strings and paths and colors. For a full list, see
 * the documentation in `Qml.h`.
 */
import io.calamares.ui 1.0

import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.1

Item {
    width: 740
    height: 420

    Flickable {
        id: flick
        anchors.fill: parent
        contentHeight: 800

        ScrollBar.vertical: ScrollBar {
            id: fscrollbar
            width: 10
            policy: ScrollBar.AlwaysOn
        }

        TextArea {
                id: intro
                x: 1
                y: 0
                width: parent.width - fscrollbar.width
                font.pointSize: 14
                textFormat: TextEdit.RichText
                antialiasing: true
                activeFocusOnPress: false
                wrapMode: Text.WordWrap

                onLinkActivated: Qt.openUrlExternally( link )

                text: qsTr('<p>Find information or ask questions on :</p> \
                <p><br />Github <a href="https://github.com/devDucks/astroarch">https://github.com/devDucks/astroarch</a></p> \
                <p>Discord <a href="https://discord.com/invite/uJEQCZKBT8">https://discord.com/invite/uJEQCZKBT8</a></p> \
                <p>Indilib <a href="https://indilib.org/forum/astro-arch.html">https://indilib.org/forum/astro-arch.html</a></p> \
                <p>&nbsp;</p> \
                <p><img src="/usr/share/calamares/branding/astroarch/slide1.png" alt="astroarch image" width="96" height="96" />&nbsp; Clear skies and have fun with AstroArch<br />Mattia Procopio</p>')
        }
    }
}
