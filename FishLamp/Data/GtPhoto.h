//
//  GtCameraImage.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtPhotoData.h"
#import "GtPhotoFile.h"
#import "GtPhotoFolder.h"

#define GT_ORIGINAL_PHOTO_SUFFIX @"_O.JPG"
#define GT_FULLSIZE_PHOTO_SUFFIX @"_F.JPG"
#define GT_THUMBNAIL_PHOTO_SUFFIX @"_T.JPG"
#define GT_PHOTO_DATA_SUFFIX @".DATA"

@interface GtPhoto : NSObject {
@private
	NSString* m_rootFileName;
	id m_userData;
	NSMutableDictionary* m_files;
	GtPhotoFolder* m_folder;
}


- (id) init;

- (id) initWithFolderAndRootFileName:(GtPhotoFolder*) folder
	rootFileName:(NSString*) rootFileName;

- (id) initWithOriginalImage:(GtPhotoFolder*) folder
	rootFileName:(NSString*) rootFileName
	image:(UIImage*) image;

- (id) initWithOriginalBytes:(GtPhotoFolder*) folder
	rootFileName:(NSString*) rootFileName
	data:(NSData*) data;

// common sizes
@property (readonly, assign, nonatomic) GtPhotoData* original;
@property (readonly, assign, nonatomic) GtPhotoData* thumbnail;
@property (readonly, assign, nonatomic) GtPhotoData* fullScreen;

// file for storing metadata, etc
@property (readonly, assign, nonatomic) GtPhotoFile* dataFile;

// fileName is rootFileName+uniqueid+suffix. unique id is datetime + counter, etc..
@property (readwrite, assign, nonatomic) NSString* rootFileName;
@property (readwrite, assign, nonatomic) GtPhotoFolder* folder;

// whatever you want
@property (readwrite, assign, nonatomic) id userData;


// for convienience
- (void) loadFullScreen;
- (void) loadOriginal;
- (void) loadThumbnail;

- (void) loadDataFile;

- (void) createThumbnailVersion; // requires fullscreen version
- (void) createFullScreenVersion; // requires original version

- (void) deleteFiles;

- (void) createAndSaveFullAndThumbnailVersionsToFileIfNeeded:(BOOL) clearFullScreen
    clearThumbnailWhenDone:(BOOL) clearThumbnail;

// for custom sizes

- (void) setPhotoDataFile:(GtPhotoFile*) file 
				    suffix:(NSString*) suffix;

- (GtPhotoData*) photoDataFile:(NSString*) forSuffix;


// Utils

+ (NSString*) imagePlusTimeFileName;

+ (BOOL) isOriginalPhoto:(NSString*) path;
+ (NSString*) rootFileNameFromOriginalPhotoName:(NSString*) path;


@end
