// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// FLCodeEnums.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeEnums.h"
@implementation FLCodeCodeGeneratorEnumLookup

FLSynthesizeSingleton(FLCodeCodeGeneratorEnumLookup);

- (id) init {
    if((self = [super init])) {
        [self addEnum:FLCodeDataTypeObject withName:kFLCodeDataTypeObject];
        [self addEnum:FLCodeDataTypeValue withName:kFLCodeDataTypeValue];
        [self addEnum:FLCodeTypeEnum withName:kFLCodeDataTypeEnum];
        [self addEnum:FLCodeDataTypeImmuteable withName:kFLCodeDataTypeImmuteable];
        [self addEnum:FLCodeInputTypeHttp withName:kFLCodeInputTypeHttp];
        [self addEnum:FLCodeInputTypeFile withName:kFLCodeInputTypeFile];
        [self addEnum:FLCodeInputTypeWsdl withName:kFLCodeInputTypeWsdl];
    }
    return self;
}

- (NSString*) stringFromDataType:(FLCodeTypeID) inEnum {
    switch(inEnum) {
        case FLCodeDataTypeObject: return kFLCodeDataTypeObject;
        case FLCodeDataTypeValue: return kFLCodeDataTypeValue;
        case FLCodeTypeEnum: return kFLCodeDataTypeEnum;
        case FLCodeDataTypeImmuteable: return kFLCodeDataTypeImmuteable;
    }
    return nil;
}

- (NSString*) stringFromInputType:(FLCodeInputType) inEnum {
    switch(inEnum) {
        case FLCodeInputTypeHttp: return kFLCodeInputTypeHttp;
        case FLCodeInputTypeFile: return kFLCodeInputTypeFile;
        case FLCodeInputTypeWsdl: return kFLCodeInputTypeWsdl;
    }
    return nil;
}

- (FLCodeTypeID) dataTypeFromString:(NSString*) inString {
    return (FLCodeTypeID) [self enumFromString:inString];
}

- (FLCodeInputType) inputTypeFromString:(NSString*) inString {
    return (FLCodeInputType) [self enumFromString:inString];
}
@end
// [/Generated]