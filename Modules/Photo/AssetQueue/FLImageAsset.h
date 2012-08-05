//
//	FLImageAsset.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLStorableImage.h"
#import "FLAsset.h"

@protocol FLImageAsset <FLAsset, NSCopying> 

@property (readonly, retain, nonatomic) id<FLStorableImage> original;
@property (readonly, retain, nonatomic) id<FLStorableImage> thumbnail;
@property (readonly, retain, nonatomic) id<FLStorableImage> fullScreen;

// for convienience
- (void) loadFullScreen;
- (void) loadOriginal;
- (void) loadThumbnail;

- (void) createThumbnailVersion; // requires fullscreen version
- (void) createFullScreenVersion; // requires original version

- (void) releaseFiles; // in memory 

- (BOOL) needsManualScaling;

- (NSDate*) takenDate;

@end

