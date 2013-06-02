// 
// ZFSearchSetByTextHttpGetIn.m
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


#import "ZFSearchSetByTextHttpGetIn.h"
#import "FLModelObject.h"

@implementation ZFSearchSetByTextHttpGetIn

#if FL_MRC
- (void) dealloc {
    [_limit release];
    [_query release];
    [_offset release];
    [_type release];
    [_searchId release];
    [_sortOrder release];
    [super dealloc];
}
#endif
@synthesize limit = _limit;
@synthesize offset = _offset;
@synthesize query = _query;
@synthesize searchId = _searchId;
+ (ZFSearchSetByTextHttpGetIn*) searchSetByTextHttpGetIn {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize sortOrder = _sortOrder;
@synthesize type = _type;

@end
