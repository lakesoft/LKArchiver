# LKArchiver

NSKeyedArchiver/NSKeyedUnArchiver wrapper

## Usage

### Archiving

    [LKDocumentDirectoryArchiver archiveRootObject:userList
                                            forKey:@"UserList"];

It executes like below functions.

    // filename is equal to (Application Directory)/Documents/UserList.archive
    [NSKeyedArchiver archiveRootObject:userList toFile:filename];


### Unarchiving

    id userList = [LKDocumentDirectoryArchiver unarchiverObjectForKey:@"UserList"];
  
It executes like below functions.

    id userList = [NSKeyedUnarchiver unarchiverObjectWithFile:filename];

If required default value case,

	[LKDocumentDirectoryArchiver unarchiveObject:userList
	                                      forKey:@"UserList"
                                    defaultObject:^id{
    								   return @[].mutableCopy;
  								    }];

Supports handling failure,

	[LKDocumentDirectoryArchiver unarchiveObject:userList
	                                      forKey:@"UserList"
                                         failure:^{
    								        // do something
  								         }];

### Using directroy

You can use directory. 

    [LKDocumentDirectoryArchiver archiveRootObject:userList1
                                            forKey:@"Support/01/UserList"];
	// placed as bellow:
	// (Application Directory)/Documents/Support/01/UserList.archive

The first "/" character will be removed. (e.g.) "/Sales/obj" => "Sales/obj"

### Etc

You can remove an archive file.

    [LKDOcumentDirectoryArchiver removeArchiverForKey:@"UserList"];

Check to exist an archiver file.

	[LKDocumentDirectoryArchiver archiverExistsForKey:@"UserList"];

NSCachesDirectory is available too:

	[LKCachesDirecotryArchiver archiveRootObject:userList toFile:filename];


## Installation

LKUserDefaults is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "LKArchiver", :git => 'https://github.com/lakesoft/LKArchiver.git'


## Author

Hiroshi Hashiguchi, xcatsan@mac.com

## License

LKArchiver is available under the MIT license. See the LICENSE file for more info.

