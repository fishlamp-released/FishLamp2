//
//	GtFolder.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/7/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtCancellableOperation.h"

@class GtFolder;

typedef void (^GtTestFileNameBlock)(NSString* fileName, BOOL* shouldDeleteFile);
typedef void (^GtFileVisitorBlock)(GtFolder* folder, NSString* fileName);

@interface GtFolder : NSObject {
@private
	NSString* m_fullPath;
	NSSearchPathDirectory m_searchPathDirectory;

}

@property (readonly, assign, nonatomic) NSSearchPathDirectory searchPathDirectory;
@property (readwrite, retain, nonatomic) NSString* fullPath;

- (id) initWithFullPath:(NSString*) path;
- (id) initWithSearchPathDirectory:(NSSearchPathDirectory) directory;

- (void) appendStringToPath:(NSString*) string;

- (unsigned long long) calculateFolderSize:(id<GtCancellableOperation>) operation outItemCount:(NSUInteger*) outItemCount;

- (void) deleteAllFiles:(id<GtCancellableOperation>) operation;

- (void) deleteFiles:(id<GtCancellableOperation>) operation
shouldDeleteFileBlock: (GtTestFileNameBlock) shouldDeleteFileBlock;

- (void) visitAllFiles:(id<GtCancellableOperation>) operation
          visitorBlock:(GtFileVisitorBlock) visitorBlock;

- (BOOL) existsOnDisk;

- (NSString*) pathForFile:(NSString*) fileName;

- (void) createIfNeeded;

- (void) writeObjectToFile:(NSString*) fileName object:(id) object;

- (void) deleteFile:(NSString*) fileName;

- (void) readObjectFromFile:(NSString*) fileName outObject:(id*) outObject;

- (void) writeDataToFile:(NSString*) fileName data:(NSData*) data;

- (void) readDataFromFile:(NSString*) fileName outData:(NSData**) outData;

- (void) moveFilesToFolder:(GtFolder*) destinationFolder withCopy:(BOOL) copy;
	
- (BOOL) fileExistsInFolder:(NSString*) name;

- (NSDate*) dateCreatedForFile:(NSString*) name;

- (NSDate*) dateModifiedForFile:(NSString*) name;

- (unsigned long long) sizeForFileName:(NSString*) name;

- (void) addSkipBackupAttributeToFile:(NSString*) name;

- (NSUInteger) countItems:(BOOL) recursive;

@end

