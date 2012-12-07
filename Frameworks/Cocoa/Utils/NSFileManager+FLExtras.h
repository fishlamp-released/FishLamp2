//
//	NSFileManager+FLExtras
//	FishLamp
//
//	Created by Mike Fullerton on 6/20/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLCore.h"

typedef void (^FLFileManagerVisitor)(NSString* filePath, BOOL* stop);

@interface	NSFileManager (FLExtras)

+ (BOOL) getFileSize:(NSString*) filePath 
	outSize:(unsigned long long*) outSize
	outError:(NSError**) outError;
	
+ (void) moveFolderContents:(NSString*) fromFolder toFolder:(NSString*) toFolder;

+ (NSString*) timeStampedName:(NSString*) baseName	optionalExtension:(NSString*) extension;

+ (BOOL) createDirectoryIfNeeded:(NSString*) path;

+ (unsigned long long) availableDiskSpace;

+ (unsigned long long) diskSize;

- (NSUInteger) countItemsInDirectory:(NSString*) path 
                         recursively:(BOOL) recursively
                    visibleItemsOnly:(BOOL) visibleItemsOnly;

- (BOOL) itemIsDirectory:(NSString*) path;

- (void) visitEachItemAtPath:(NSString*) path
                 recursively:(BOOL) recursively
            visibleItemsOnly:(BOOL) visibleItemsOnly
                     visitor:(FLFileManagerVisitor) visitor;

#if IOS
+ (void) addSkipBackupAttributeToFile:(NSString*) filePath;
#endif 
@end

