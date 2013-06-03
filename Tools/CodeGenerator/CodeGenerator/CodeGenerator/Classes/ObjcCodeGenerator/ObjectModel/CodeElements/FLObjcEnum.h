//
//  FLObjcEnum.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeElement.h"
#import "FLObjcType.h"

@class FLObjcProject;
@class FLCodeEnumType;
@class FLObjcEnumValueType;

@interface FLObjcEnum : FLObjcCodeElement {
@private
    NSMutableArray* _enumValues;
    FLObjcType* _enumType;
    FLObjcName* _enumName;
    
    NSMutableDictionary* _defines;
}

+ (id) objcEnum:(FLObjcProject*) project;

@property (readonly, strong, nonatomic) NSArray* enumValues;
@property (readwrite, strong, nonatomic) FLObjcType* enumType;
@property (readwrite, strong, nonatomic) FLObjcName* enumName;

- (void) addValue:(FLObjcEnumValueType*) enumValueType;
- (void) configureWithCodeEnumType:(FLCodeEnumType*) codeEnumType;


// called from FLObjcEnumType
- (void) objcObject:(FLObjcObject*) object 
didConfigureProperty:(FLObjcProperty *)property;

@end

