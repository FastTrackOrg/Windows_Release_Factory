## deb package creation
* `./create_deb.sh -p path/to/fasttrack/binary -v version`
* Copy to production server
* On production server `reprepro includedeb sid /fasttrack-x.x.x.deb`

## Windows installer creation
* Copy FastTrack binary inside /FastTrack/packages/FastTrack/data/data
* Add /FastTrack/packages/FastTrack/data/data to /FastTrack/packages/FastTrack/data/data.7z
* Update version number in window_installer/FastTrack/packages/FastTrack/meta/package.xml
* `./deploy.bat`
* Copy FastTrackInstaller.exe and FastTrackRep content on production server

