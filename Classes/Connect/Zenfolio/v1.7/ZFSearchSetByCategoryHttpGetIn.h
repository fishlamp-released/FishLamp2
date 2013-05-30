// 
// ZFSearchSetByCategoryHttpGetIn.h
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

#import "FLModelObject.h"
@interface ZFSearchSetByCategoryHttpGetIn : FLModelObject {
@private
    NSString* _categoryCode;
    NSString* _limit;
    NSString* _offset;
    NSString* _type;
    NSString* _searchId;
    NSString* _sortOrder;
}

@property (readwrite, strong, nonatomic) NSString* categoryCode;
@property (readwrite, strong, nonatomic) NSString* limit;
@property (readwrite, strong, nonatomic) NSString* offset;
@property (readwrite, strong, nonatomic) NSString* type;
@property (readwrite, strong, nonatomic) NSString* searchId;
@property (readwrite, strong, nonatomic) NSString* sortOrder;
+(ZFSearchSetByCategoryHttpGetIn*) searchSetByCategoryHttpGetIn;
@end
