/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the FOO module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL-EXCEPT$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 as published by the Free Software
** Foundation with exceptions as appearing in the file LICENSE.GPL3-EXCEPT
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

function Component()
{
    installer.installationFinished.connect(this, Component.prototype.installationFinishedPageIsShown);
    installer.finishButtonClicked.connect(this, Component.prototype.installationFinished);
}

Component.prototype.createOperations = function()
{
    component.createOperations();
    if (systemInfo.productType === "windows") {
        component.addOperation("CreateShortcut", "@TargetDir@/FastTrack.exe", "@StartMenuDir@/FastTrack.lnk",
            "workingDirectory=@TargetDir@","iconPath=@TargetDir@/icon.ico", "description=FastTrack");
        component.addOperation("CreateShortcut", "@TargetDir@/maintenancetool.exe", "@StartMenuDir@/FastTrackUpdater.lnk",
            "workingDirectory=@TargetDir@", "description=FastTrack Updater");
        installer.setDefaultPageVisible(QInstaller.LicenseCheck, false);
    }
}

Component.prototype.installationFinishedPageIsShown = function()
{
    try {
        if (installer.isInstaller() && installer.status == QInstaller.Success) {
            installer.addWizardPageItem( component, "ReadMeCheckBoxForm", QInstaller.InstallationFinished );
        }
    } catch(e) {
        console.log(e);
    }
}

Component.prototype.installationFinished = function()
{
    try {
        if (installer.isInstaller() && installer.status == QInstaller.Success) {
            var isMsvcCheckBoxChecked = component.userInterface( "ReadMeCheckBoxForm" ).msvcCheckBox.checked;
            if (isMsvcCheckBoxChecked) {
                installer.execute("@TargetDir@/vc_redist.x64.exe");
            }
            var isReadMeCheckBoxChecked = component.userInterface( "ReadMeCheckBoxForm" ).readMeCheckBox.checked;
            if (isReadMeCheckBoxChecked) {
                QDesktopServices.openUrl("https://www.fasttrack.sh/docs/intro");
            }
            var isStartCheckBoxChecked = component.userInterface( "ReadMeCheckBoxForm" ).startCheckBox.checked;
            if (isStartCheckBoxChecked) {
                installer.executeDetached("@TargetDir@/FastTrack.exe");
            }
        }
    } catch(e) {
        console.log(e);
    }
}

