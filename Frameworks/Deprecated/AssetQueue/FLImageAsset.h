//
//	FLImageAsset.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStorableImageProtocol.h"
#import "FLAsset.h"
@class FLAssetStorage;

@protocol FLImageAsset <FLAsset, NSCopying> 

@property (readonly, retain, nonatomic) id<FLStorableImageProtocol> original;
@property (readonly, retain, nonatomic) id<FLStorableImageProtocol> thumbnail;
@property (readonly, retain, nonatomic) id<FLStorableImageProtocol> fullScreen;

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


