// 
// ZFGetRecentSets.h
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
@interface ZFGetRecentSets : FLModelObject {
@private
    NSString* _type;
    int _limit;
    int _offset;
}

@property (readwrite, strong, nonatomic) NSString* type;
@property (readwrite, assign, nonatomic) int limit;
@property (readwrite, assign, nonatomic) int offset;
+(ZFGetRecentSets*) getRecentSets;
@end
