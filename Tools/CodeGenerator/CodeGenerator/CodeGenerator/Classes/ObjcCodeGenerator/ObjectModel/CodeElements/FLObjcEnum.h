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
@class FLObjcEnumValueType;

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

- (void) addValue:(FLObjcEnumValueType*) enumValueType;
- (void) configureWithCodeEnumType:(FLCodeEnumType*) codeEnumType;
@end

