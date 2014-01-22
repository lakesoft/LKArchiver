# LKArchiver

NSKeyedArchiver/NSKeyedUnArchiver wrapper

## Usage

### Archiving

    [LKDocumentDirectoryArchiver.sharedArchiver archiveRootObject:userList
                                                           forKey:@"UserList"];

It executes like below functions.

    // filename is equal to (Application Directory)/Documents/UserList.archive
    [NSKeyedArchiver archiveRootObject:userList toFile:filename];

### Unarchiving

    id userList = [LKDocumentDirectoryArchiver.sharedArchiver unarchiverObjectForKey:@"UserList"];
  
It executes like below functions.

    id userList = [NSKeyedUnarchiver unarchiverObjectWithFile:filename];

You can remove these files.

    [LKDOcumentDirectoryArchiver.sharedArchiver removeArchiverForKey:@"UserList"];


Available directories:

    LKCacheDirectoryArchiver -> NSCachesDirectory
    LKDocumentDirectoryArchiver -> NSDocumentDirectory


## Installation

LKUserDefaults is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "LKArchiver", :git => 'https://github.com/lakesoft/LKArchiver.git'


## Author

Hiroshi Hashiguchi, xcatsan@mac.com

## License

LKArchiver is available under the MIT license. See the LICENSE file for more info.
