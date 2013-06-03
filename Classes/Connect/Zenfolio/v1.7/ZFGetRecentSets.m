// 
// ZFGetRecentSets.m
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


#import "ZFPhotoSetType.h"
#import "ZFGetRecentSets.h"
#import "FLModelObject.h"

@implementation ZFGetRecentSets

#if FL_MRC
- (void) dealloc {
    [_type release];
    [super dealloc];
}
#endif
+ (ZFGetRecentSets*) getRecentSets {
    return FLAutorelease([[[self class] alloc] init]);
}
@synthesize limit = _limit;
@synthesize offset = _offset;
@synthesize type = _type;
- (ZFPhotoSetType) typeEnum {
    return ZFPhotoSetTypeEnumFromString(self.type);
}
- (void) setTypeEnum:(ZFPhotoSetType) value {
    self.type = ZFPhotoSetTypeStringFromEnum(value);
}
- (ZFPhotoSetTypeEnumSet*) typeEnumSet {
    return ZFPhotoSetTypeEnumFromString(self.type);
}
- (void) setTypeEnumSet:(ZFPhotoSetTypeEnumSet*) value {
    self.type = value.concatenatedString;
}

@end
