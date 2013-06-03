// 
// ZFLoadGroup.m
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


#import "ZFLoadGroup.h"
#import "FLModelObject.h"
#import "ZFInformationLevel.h"

@implementation ZFLoadGroup

#if FL_MRC
- (void) dealloc {
    [_level release];
    [super dealloc];
}
#endif
@synthesize groupId = _groupId;
@synthesize includeChildren = _includeChildren;
@synthesize level = _level;
- (ZFInformationLevel) levelEnum {
    return ZFInformationLevelEnumFromString(self.level);
}
- (void) setLevelEnum:(ZFInformationLevel) value {
    self.level = ZFInformationLevelStringFromEnum(value);
}
- (ZFInformationLevelEnumSet*) levelEnumSet {
    return ZFInformationLevelEnumFromString(self.level);
}
- (void) setLevelEnumSet:(ZFInformationLevelEnumSet*) value {
    self.level = value.concatenatedString;
}
+ (ZFLoadGroup*) loadGroup {
    return FLAutorelease([[[self class] alloc] init]);
}

@end
