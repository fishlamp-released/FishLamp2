// 
// ZFSearchPhotoByCategory.m
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

#import "ZFSearchPhotoByCategory.h"
#import "FLModelObject.h"
@implementation ZFSearchPhotoByCategory
@synthesize limit = _limit;
@synthesize offset = _offset;
@synthesize searchId = _searchId;
@synthesize sortOrder = _sortOrder;
@synthesize categoryCode = _categoryCode;
+(ZFSearchPhotoByCategory*) searchPhotoByCategory {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
-(void) dealloc {
    [_searchId release];
    [_sortOrder release];
    [super dealloc];
}
#endif
@end
