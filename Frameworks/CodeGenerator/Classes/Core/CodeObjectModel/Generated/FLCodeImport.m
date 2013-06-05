// 
// FLCodeImport.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/3/13 11:50 AM with PackMule (3.0.0.20)
// 
// Project: FishLamp Code Generator
// Schema: ObjectModel
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "FLCodeInputType.h"
#import "FLCodeImport.h"
#import "FLModelObject.h"

@implementation FLCodeImport

+ (FLCodeImport*) codeImport {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_path release];
    [_type release];
    [super dealloc];
}
#endif
@synthesize path = _path;
@synthesize type = _type;
- (FLCodeInputType) typeEnum {
    return FLCodeInputTypeEnumFromString(self.type);
}
- (void) setTypeEnum:(FLCodeInputType) value {
    self.type = FLCodeInputTypeStringFromEnum(value);
}
- (FLCodeInputTypeEnumSet*) typeEnumSet {
    return [FLCodeInputTypeEnumSet enumSet:self.type];;
}
- (void) setTypeEnumSet:(FLCodeInputTypeEnumSet*) value {
    self.type = value.concatenatedString;
}

@end