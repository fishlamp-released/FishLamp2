//
//	FLFolderFile.h
//	PackMule
//
//	Created by Mike Fullerton on 11/8/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLFolder.h"

@interface FLFolderFile : NSObject {
@private
	NSString* _fileName;
	FLFolder* _folder;
}

- (id) initWithFolder:(FLFolder*) folder fileName:(NSString*) fileName;

@property (readwrite, retain, nonatomic) FLFolder* folder;
@property (readwrite, retain, nonatomic) NSString* fileName; 

@property (readonly, retain, nonatomic) NSString* filePath;

- (void) writeToFile;
- (BOOL) readFromFile;
- (void) deleteFile;
- (BOOL) fileExists;

@end