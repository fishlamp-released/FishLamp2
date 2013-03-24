//
//	ZFPhoto+More.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZFPhoto.h"
#import "ZFImageSize.h"

@interface ZFPhoto (More)
- (NSString*) displayName;
- (BOOL) isFullVersion;
- (BOOL) isFullyDownloaded;

- (BOOL) isStaleComparedTo:(int) anotherTextCn 
                  sequence:(NSString*) sequence; // nil seq skip that check

- (BOOL) isStaleComparedToPhoto:(ZFPhoto*) photo;

- (NSURL*) urlForImageWithSize:(ZFImageSize*) size;

@end