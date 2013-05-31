//
//  FLObjcEnum.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeElement.h"
#import "FLObjcType.h"

@class FLObjcTypeIndex;
@class FLCodeEnumType;
@class FLObjcEnumValue;

@interface FLObjcEnum : FLObjcCodeElement {
@private
    NSMutableArray* _enumValues;
    FLObjcType* _enumType;
    FLObjcName* _enumName;
    
    NSMutableDictionary* _defines;
}

+ (id) objcEnum:(FLObjcTypeIndex*) typeIndex;

@property (readonly, strong, nonatomic) NSArray* enumValues;
@property (readwrite, strong, nonatomic) FLObjcType* enumType;
@property (readwrite, strong, nonatomic) FLObjcName* enumName;

- (void) addValue:(FLObjcEnumValue*) enumValueType;
- (void) configureWithCodeEnumType:(FLCodeEnumType*) codeEnumType;
@end


@interface FLObjcEnumValue : FLObjcValueType {
@private
    NSUInteger _enumValue;
}
@property (readwrite, assign, nonatomic) NSUInteger enumValue;

+ (id) objcEnumValue:(FLObjcName*) name value:(NSUInteger) value;
@end
