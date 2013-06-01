// 
// ZFSearchPhotoByText.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/31/13 7:38 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "ZFSearchPhotoByText.h"
#import "ZFSortOrder.h"
#import "FLModelObject.h"
#import "ZFSortOrder.h"
#import "ZFSortOrder.h"
@implementation ZFSearchPhotoByText
@synthesize offset = _offset;
@synthesize sortOrderEnumSet = (null);
@synthesize sortOrder = _sortOrder;
@synthesize sortOrderEnum = (null);
@synthesize query = _query;
@synthesize limit = _limit;
@synthesize searchId = _searchId;
+ (ZFSearchPhotoByText*) searchPhotoByText {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_query release];
    [_searchId release];
    [super dealloc];
}
#endif
@end
