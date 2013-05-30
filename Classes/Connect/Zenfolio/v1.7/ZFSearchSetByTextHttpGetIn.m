// 
// ZFSearchSetByTextHttpGetIn.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 4:42 PM with PackMule (3.0.0.1)
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
@synthesize limit = _limit;
@synthesize query = _query;
@synthesize offset = _offset;
@synthesize type = _type;
@synthesize searchId = _searchId;
@synthesize sortOrder = _sortOrder;
+(ZFSearchSetByTextHttpGetIn*) searchSetByTextHttpGetIn {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_limit release];
    [_query release];
    [_offset release];
    [_type release];
    [_searchId release];
    [_sortOrder release];
    [super dealloc];
}
#endif
@end
