set PATH=.\Qt\Qt\Tools\QtInstallerFramework\4.1\bin
repogen.exe -p .\FastTrack\packages FastTrackRep
binarycreator.exe -p .\FastTrack\packages -c .\FastTrack\config\config.xml FastTrackInstaller
