//
//  GtPhotoFile.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

// TODO: this should be DATA file, not PHOTO file

@interface GtPhotoFile : NSObject {
@private
	NSData* m_data;
	NSString* m_path;
}

@property (readwrite, assign, nonatomic) NSString* path;

@property (readonly, assign, nonatomic) BOOL hasData;
@property (readonly, assign, nonatomic) BOOL existsOnDisk;

@property (readonly, assign, nonatomic) BOOL isLoaded;

@property (readwrite, assign, nonatomic) NSData* data;

@property (readonly, assign, nonatomic) unsigned long size;

- (id) initWithPath:(NSString*) path;
- (id) initWithPathAndData:(NSString*) path 
					  data:(NSData*) data;
- (id) initWithData:(NSData*) data;
- (id) init;

- (BOOL) saveToFile;
- (BOOL) readFromFile;
- (BOOL) readFromFile:(BOOL) forceReload;
- (BOOL) deleteFile;

- (void) releaseData;

@end
