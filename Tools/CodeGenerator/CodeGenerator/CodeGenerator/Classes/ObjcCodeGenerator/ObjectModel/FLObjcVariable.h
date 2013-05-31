//
//  FLObjcVariable.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeElement.h"

@class FLObjcType;
@class FLObjcName;
@class FLObjcRuntimeValue;
@protocol FLObjcType;

@interface FLObjcVariable : NSObject<FLObjcCodeElement> {
    FLObjcName* _variableName;
    FLObjcType* _variableType;
    FLObjcRuntimeValue* _runtimeValue;
}
@property (readwrite, strong, nonatomic) FLObjcName* variableName;
@property (readwrite, strong, nonatomic) FLObjcType* variableType;
@property (readwrite, strong, nonatomic) FLObjcRuntimeValue* runtimeValue;

- (id) initWithVariableName:(FLObjcName*) variableName variableType:(FLObjcType*) variableType;
@end

@interface FLObjcLocalVariable : FLObjcVariable {
@private
}

@end

@interface FLObjcIvar : FLObjcVariable 
+ (id) objcIvar:(FLObjcName*) variableName ivarType:(FLObjcType*) variableType;
@end

@interface FLObjcParameter : FLObjcVariable {
@private
    NSString* _key;
}
@property (readwrite, strong, nonatomic) NSString* key;

- (id) initWithParameterName:(FLObjcName*) variableName parameterType:(FLObjcType*) parameterType key:(NSString*) key;
+ (id) objcParameter:(FLObjcName*) variableName parameterType:(FLObjcType*) parameterType key:(NSString*) key;
@end
