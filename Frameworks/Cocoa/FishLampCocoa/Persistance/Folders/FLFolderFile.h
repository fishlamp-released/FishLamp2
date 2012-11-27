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

@interface FLFolderFile : NSObject<NSCopying> {
@private
	NSString* _fileName;
	FLFolder* _folder;
}

- (id) initWithFolder:(FLFolder*) folder fileName:(NSString*) fileName;

@property (readwrite, strong, nonatomic) FLFolder* folder;
@property (readwrite, strong, nonatomic) NSString* fileName; 
@property (readonly, strong, nonatomic) NSString* filePath;
@property (readonly, assign) unsigned long long fileSize;

- (id) readObjectFromFile;
- (NSData*) readDataFromFile;

- (void) writeDataToFile:(NSData*) data;
- (void) writeObjectToFile:(id) object;

- (void) deleteFile;
- (BOOL) fileExists;

- (NSInputStream*) createReadStream;

@end