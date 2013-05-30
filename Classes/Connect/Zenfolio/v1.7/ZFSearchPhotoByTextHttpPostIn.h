// 
// ZFSearchPhotoByTextHttpPostIn.h
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

#import "FLModelObject.h"
@interface ZFSearchPhotoByTextHttpPostIn : FLModelObject {
@private
    NSString* _query;
    NSString* _offset;
    NSString* _searchId;
    NSString* _sortOrder;
    NSString* _limit;
}

@property (readwrite, strong, nonatomic) NSString* query;
@property (readwrite, strong, nonatomic) NSString* offset;
@property (readwrite, strong, nonatomic) NSString* searchId;
@property (readwrite, strong, nonatomic) NSString* sortOrder;
@property (readwrite, strong, nonatomic) NSString* limit;
+(ZFSearchPhotoByTextHttpPostIn*) searchPhotoByTextHttpPostIn;
@end
