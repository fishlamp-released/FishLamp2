// 
// ZFCreateQuickBlogPost.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 2:36 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFCreateQuickBlogPost.h"
#import "FLObjectDescriber.h"
#import "FLModelObject.h"
@implementation ZFCreateQuickBlogPost
@synthesize keywords = _keywords;
@synthesize photoId = _photoId;
@synthesize publishDate = _publishDate;
@synthesize url = _url;
@synthesize title = _title;
@synthesize caption = _caption;
+(void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"string" propertyClass:[NSString class]] forContainerProperty:@"keywords"];
}
+(ZFCreateQuickBlogPost*) createQuickBlogPost {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_keywords release];
    [_publishDate release];
    [_url release];
    [_title release];
    [_caption release];
    [super dealloc];
}
#endif
@end
