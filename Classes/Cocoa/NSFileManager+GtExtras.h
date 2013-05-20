//
//	NSFileManager+GtExtras
//	FishLamp
//
//	Created by Mike Fullerton on 6/20/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampMinimum.h"

typedef void (^GtFileManagerVisitor)(NSString* filePath, BOOL* stop);

@interface	NSFileManager (GtExtras)

+ (BOOL) getFileSize:(NSString*) filePath 
	outSize:(unsigned long long*) outSize
	outError:(NSError**) outError;
	
+ (NSString*) appMarketingVersion;

+ (NSString*) appVersion;       

+ (NSString*) appName;

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
                     visitor:(GtFileManagerVisitor) visitor;

#if IOS
+ (void) addSkipBackupAttributeToFile:(NSString*) filePath;
#endif 
@end

