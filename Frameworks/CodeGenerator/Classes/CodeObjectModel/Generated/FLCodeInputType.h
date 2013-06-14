// 
// FLCodeInputType.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/14/13 2:45 PM with PackMule (3.0.0.29)
// 
// Project: ObjectModel
// Schema: ObjectModel
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLTypeSpecificEnumSet.h"

typedef enum {
    FLCodeInputTypeHttp = 0,
    FLCodeInputTypeFile = 1,
    FLCodeInputTypeWsdl = 2,
} FLCodeInputType;

#define kFLCodeInputTypeHttp @"Http"
#define kFLCodeInputTypeFile @"File"
#define kFLCodeInputTypeWsdl @"Wsdl"

extern NSString* FLCodeInputTypeStringFromEnum(FLCodeInputType theEnum);
extern FLCodeInputType FLCodeInputTypeEnumFromString(NSString* theString);

@interface FLCodeInputTypeEnumSet : FLTypeSpecificEnumSet
+ (id) enumSet;
+ (id) enumSet:(NSString*) concatenatedEnumString;
@end
