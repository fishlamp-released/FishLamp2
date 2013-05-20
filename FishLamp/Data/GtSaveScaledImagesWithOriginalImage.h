//
//  GtSaveScaledImagesWithOriginalImage.h
//  MyZen
//
//  Created by Mike Fullerton on 11/10/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtOperation.h"
#import "GtPhoto.h"

// NOTE this will always create full screen version if it doesn't exist

#define GtLoadFullScreen        gtBit1
#define GtCreateThumbnail       gtBit2
#define GtDiscardFullSize       gtBit3
#define GtDiscardThumbail       gtBit4
#define GtDiscardOriginal       gtBit5
#define GtLoadThumbnail         gtBit6
#define GtLoadFullScreenImage   gtBit7

@interface GtSaveScaledImagesWithOriginalImage : GtOperation {
	GtPhoto* m_photo;
	GtPhotoFolder* m_folder;
    GtBitMask m_options;
}

- (id) initWithPhotoInput:(GtPhoto*) photo 
                   folder:(GtPhotoFolder*) folder
              saveOptions:(GtBitMask) options;


@end
