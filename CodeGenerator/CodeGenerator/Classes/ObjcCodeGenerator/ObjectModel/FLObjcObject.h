//
//  FLObjcObject.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeElement.h"
#import "FLObjcType.h"

@class FLObjcProperty;
@class FLObjcIvar;
@class FLObjcType;
@class FLObjcName;
@class FLCodeObject;
@class FLObjcNamedObjectCollection;
@class FLObjcMethod;
@class FLObjcTypeIndex;

@interface FLObjcObject : FLObjcCodeElement {
@private
    FLObjcType* _objectType;
    FLObjcType* _superclass;
    FLObjcName* _objectName;
    FLObjcNamedObjectCollection* _ivars;
    FLObjcNamedObjectCollection* _properties;
    NSMutableArray* _methods;
    NSMutableSet* _dependencies;
    FLCodeObject* _codeObject;
}

@property (readonly, strong, nonatomic) FLObjcNamedObjectCollection* properties;
@property (readonly, strong, nonatomic) FLObjcNamedObjectCollection* ivars;

@property (readwrite, strong, nonatomic) FLObjcType* objectType;
@property (readwrite, strong, nonatomic) FLObjcName* objectName;
@property (readwrite, strong, nonatomic) FLObjcType* superclassType;

+ (id) objcObject:(FLObjcTypeIndex*) typeIndex;

- (void) configureWithCodeObject:(FLCodeObject*) codeObject;

- (void) addIvar:(FLObjcIvar*) ivar;
- (void) addProperty:(FLObjcProperty*) property;
- (void) addMethod:(FLObjcMethod*) method;

- (void) addDependency:(FLObjcType*) type;

@end
