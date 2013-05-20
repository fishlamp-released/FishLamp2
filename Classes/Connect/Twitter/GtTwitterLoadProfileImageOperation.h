//
//  GtTwitterLoadProfileImageOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/9/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import	"GtTwitterOperation.h"

#define GtTwitterImageSizeNormal @"normal"
#define GtTwitterImageSizeSmall @"mini"
#define GtTwitterImageSizeLarge @"bigger"

@interface GtTwitterLoadProfileImageOperation : GtHttpOperation {
@private
	NSString* m_imageSize;
	NSString* m_username;
}
@property (readwrite, retain, nonatomic) NSString* username;
@property (readwrite, retain, nonatomic) NSString* imageSize; // defaults to normal

@end
