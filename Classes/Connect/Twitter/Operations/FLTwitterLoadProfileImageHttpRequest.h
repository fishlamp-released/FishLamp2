//
//  FLTwitterLoadProfileImageOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/9/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

#import	"FLTwitterHttpRequest.h"

#define FLTwitterImageSizeNormal @"normal"
#define FLTwitterImageSizeSmall @"mini"
#define FLTwitterImageSizeLarge @"bigger"

@interface FLTwitterLoadProfileImageHttpRequest : FLTwitterHttpRequest {
@private
	NSString* _imageSize;
	NSString* _username;
}
@property (readwrite, retain, nonatomic) NSString* username;
@property (readwrite, retain, nonatomic) NSString* imageSize; // defaults to normal

@end
