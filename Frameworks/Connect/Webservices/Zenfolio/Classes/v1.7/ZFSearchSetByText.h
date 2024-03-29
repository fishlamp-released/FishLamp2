// 
// ZFSearchSetByText.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/3/13 10:43 AM with PackMule (3.0.1.100)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
#import "ZFSortOrder.h"
#import "ZFPhotoSetType.h"

@class ZFPhotoSetTypeEnumSet;
@class ZFSortOrderEnumSet;

@interface ZFSearchSetByText : FLModelObject {
@private
    int _limit;
    NSString* _query;
    int _offset;
    NSString* _type;
    NSString* _searchId;
    NSString* _sortOrder;
}

@property (readwrite, assign, nonatomic) int limit;
@property (readwrite, assign, nonatomic) int offset;
@property (readwrite, strong, nonatomic) NSString* query;
@property (readwrite, strong, nonatomic) NSString* searchId;
@property (readwrite, strong, nonatomic) NSString* sortOrder;
@property (readwrite, assign, nonatomic) ZFSortOrder sortOrderEnum;
@property (readwrite, strong, nonatomic) ZFSortOrderEnumSet* sortOrderEnumSet;
@property (readwrite, strong, nonatomic) NSString* type;
@property (readwrite, assign, nonatomic) ZFPhotoSetType typeEnum;
@property (readwrite, strong, nonatomic) ZFPhotoSetTypeEnumSet* typeEnumSet;

+ (ZFSearchSetByText*) searchSetByText;

@end
