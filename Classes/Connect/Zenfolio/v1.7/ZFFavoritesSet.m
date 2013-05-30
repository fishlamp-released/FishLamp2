// 
// ZFFavoritesSet.m
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

#import "ZFFavoritesSet.h"
#import "FLModelObject.h"
@implementation ZFFavoritesSet
@synthesize sharerName = _sharerName;
@synthesize sharerMessage = _sharerMessage;
@synthesize id = _id;
@synthesize isShared = _isShared;
@synthesize sharerEmail = _sharerEmail;
@synthesize changeNumber = _changeNumber;
@synthesize sharedOn = _sharedOn;
@synthesize name = _name;
+(ZFFavoritesSet*) favoritesSet {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_sharerName release];
    [_sharerMessage release];
    [_sharerEmail release];
    [_sharedOn release];
    [_name release];
    [super dealloc];
}
#endif
@end
