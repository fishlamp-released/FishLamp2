// 
// ZFCreatePhotoFromUrlHttpPostIn.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 4:12 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "ZFCreatePhotoFromUrlHttpPostIn.h"
#import "FLModelObject.h"

@implementation ZFCreatePhotoFromUrlHttpPostIn

@synthesize cookies = _cookies;
+ (ZFCreatePhotoFromUrlHttpPostIn*) createPhotoFromUrlHttpPostIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_url release];
    [_galleryId release];
    [_cookies release];
    [super dealloc];
}
#endif
@synthesize galleryId = _galleryId;
@synthesize url = _url;

@end
