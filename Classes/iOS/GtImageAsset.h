//
//	GtImageAsset.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtStorableImage.h"
#import "GtAsset.h"

@protocol GtImageAsset <GtAsset, NSCopying> 

@property (readonly, retain, nonatomic) id<GtStorableImage> original;
@property (readonly, retain, nonatomic) id<GtStorableImage> thumbnail;
@property (readonly, retain, nonatomic) id<GtStorableImage> fullScreen;

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

