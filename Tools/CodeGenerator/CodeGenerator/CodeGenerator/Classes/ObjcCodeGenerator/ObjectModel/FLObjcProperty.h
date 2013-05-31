//
//  FLObjcProperty.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeElement.h"
@class FLObjcIvar;
@class FLObjcName;
@class FLCodeProperty;
@class FLObjcObject;
@class FLObjcTypeIndex;
@class FLObjcType;
@class FLObjcMethod;

@interface FLObjcProperty : FLObjcCodeElement {
@private
    FLObjcIvar* _ivar;
    BOOL _isReadonly;
    BOOL _isAtomic;
    BOOL _isImmutable;
    BOOL _useForEquality;
    BOOL _lazyCreate;
    NSMutableArray* _containerTypes;
    FLObjcMethod* _setter;
    FLObjcMethod* _getter;
    __unsafe_unretained FLObjcObject* _parentObject;
}
+ (id) objcProperty:(FLObjcTypeIndex*) typeIndex;

@property (readwrite, assign, nonatomic) FLObjcObject* parentObject;

// these all need to be set before generation of course
@property (readwrite, strong, nonatomic) FLObjcName* propertyName;
@property (readwrite, strong, nonatomic) FLObjcType* propertyType;
@property (readwrite, strong, nonatomic) FLObjcIvar* ivar;
@property (readwrite, assign, nonatomic) BOOL isStatic;
@property (readwrite, assign, nonatomic) BOOL isPrivate;
@property (readwrite, assign, nonatomic) BOOL isReadOnly;
@property (readwrite, assign, nonatomic) BOOL isAtomic;
@property (readwrite, assign, nonatomic) BOOL isImmutable;
@property (readwrite, assign, nonatomic) BOOL useForEquality;
@property (readwrite, assign, nonatomic) BOOL lazyCreate;

// if it's an array, etc.
@property (readonly, strong, nonatomic) NSArray* containerTypes;

// misc
- (void) configureWithCodeProperty:(FLCodeProperty*) codeProperty;
            
- (void) didMoveToObject:(FLObjcObject*) object;                                    



@end
