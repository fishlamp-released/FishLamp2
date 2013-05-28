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

@interface FLObjcProperty : FLObjcCodeElement {
@private
    __unsafe_unretained FLObjcObject* _object;
    FLObjcName* _propertyName;
    FLObjcType* _propertyType;
    FLObjcIvar* _ivar;
    BOOL _isStatic;
    BOOL _isPrivate;
    BOOL _isReadonly;
    BOOL _isAtomic;
    BOOL _isImmutable;
    BOOL _useForEquality;
    BOOL _lazyCreate;
    NSString* _defaultValue;
    FLCodeProperty* _codeProperty;
    NSMutableArray* _containerTypes;
    __unsafe_unretained FLObjcObject* _parentObject;
}
+ (id) objcProperty:(FLObjcTypeIndex*) typeIndex;

@property (readonly, strong, nonatomic) NSArray* containerTypes;

@property (readwrite, assign, nonatomic) FLObjcObject* parentObject;
@property (readwrite, strong, nonatomic) FLObjcName* propertyName;
@property (readwrite, strong, nonatomic) FLObjcType* propertyType;
@property (readwrite, strong, nonatomic) FLObjcIvar* ivar;

- (void) configureWithCodeProperty:(FLCodeProperty*) codeProperty;
            
- (void) didMoveToObject:(FLObjcObject*) object;                                    


@end
