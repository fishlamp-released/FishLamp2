//
//  GtSaveCameraImage.h
//  MyZen
//
//  Created by Mike Fullerton on 11/10/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtOperation.h"
#import "GtPhoto.h"

@interface GtSaveCameraImage : GtOperation {
	UIImage* m_image;
}

- (id) initWithImageInput:(UIImage*) image;

@property (readwrite, assign, nonatomic) GtPhoto* outputPhoto;

@end
