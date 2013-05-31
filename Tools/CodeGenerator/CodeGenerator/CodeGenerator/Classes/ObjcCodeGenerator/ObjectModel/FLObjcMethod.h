//
//  FLObjcMethod.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeElement.h"

@class FLObjcParameter;
@class FLObjcType;
@class FLObjcName;
@class FLObjcStatement;
@class FLObjcMethodName;
@class FLObjcBlockStatement;
@class FLObjcObject;
@protocol FLObjcType;
@class FLObjcTypeIndex;
@class FLCodeMethod;

@interface FLObjcMethod : FLObjcCodeElement {
@private
    NSMutableArray* _parameters;
    FLObjcBlockStatement* _statement;
    FLObjcType* _returnType;
    FLObjcName* _methodName;
    BOOL _isPrivate;
    BOOL _isStatic;
    __unsafe_unretained FLObjcObject* _parentObject;
}
+ (id) objcMethod:(FLObjcTypeIndex*) typeIndex;

@property (readwrite, strong, nonatomic) FLObjcBlockStatement* statement;

@property (readwrite, assign, nonatomic) FLObjcObject* parentObject;
@property (readwrite, assign, nonatomic) BOOL isPrivate;
@property (readwrite, assign, nonatomic) BOOL isStatic;

@property (readwrite, strong, nonatomic) FLObjcName* methodName;
@property (readwrite, strong, nonatomic) FLObjcType* returnType;


// parameters
- (void) addParameter:(FLObjcParameter*) parameter;
- (void) addOrReplaceParameter:(FLObjcParameter*) parameter;

- (void) removeParameter:(FLObjcParameter*) parameter;

- (FLObjcParameter*) parameterForName:(NSString*) variableIdentifierName;

- (void) replaceParameter:(FLObjcParameter*) oldParameter 
            withParameter:(FLObjcParameter*) newParameter;

// statement
- (void) addStatement:(FLObjcStatement*) statement;

// mise
- (void) didMoveToObject:(FLObjcObject*) object;

- (void) configureWithCodeMethod:(FLCodeMethod*) codeMethod ;
                   
@end

@interface FLObjcClassInitializerMethod : FLObjcMethod 
@end

@class FLObjcDeallocStatement;
@interface FLObjcDeallocMethod : FLObjcMethod {
@private
    FLObjcDeallocStatement* _deallocStatement;
}
@end

