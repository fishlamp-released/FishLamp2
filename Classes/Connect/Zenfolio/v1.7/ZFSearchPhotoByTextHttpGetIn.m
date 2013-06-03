// 
// ZFSearchPhotoByTextHttpGetIn.m
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


#import "ZFSearchPhotoByTextHttpGetIn.h"
#import "FLModelObject.h"

@implementation ZFSearchPhotoByTextHttpGetIn

#if FL_MRC
- (void) dealloc {
    [_query release];
    [_offset release];
    [_searchId release];
    [_sortOrder release];
    [_limit release];
    [super dealloc];
}
#endif
@synthesize limit = _limit;
@synthesize offset = _offset;
@synthesize query = _query;
@synthesize searchId = _searchId;
+ (ZFSearchPhotoByTextHttpGetIn*) searchPhotoByTextHttpGetIn {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize sortOrder = _sortOrder;

@end
