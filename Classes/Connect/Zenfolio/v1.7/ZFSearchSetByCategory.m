// 
// ZFSearchSetByCategory.m
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

#import "ZFSearchSetByCategory.h"
#import "FLModelObject.h"
@implementation ZFSearchSetByCategory
@synthesize categoryCode = _categoryCode;
@synthesize limit = _limit;
@synthesize offset = _offset;
@synthesize type = _type;
@synthesize searchId = _searchId;
@synthesize sortOrder = _sortOrder;
+(ZFSearchSetByCategory*) searchSetByCategory {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_type release];
    [_searchId release];
    [_sortOrder release];
    [super dealloc];
}
#endif
@end
