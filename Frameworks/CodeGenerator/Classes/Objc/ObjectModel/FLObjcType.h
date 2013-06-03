//
//  FLObjcType.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLGenerated.h"
@class FLObjcName;
@class FLObjcObject;
@class FLObjcProperty;
@class FLObjcProject;

@interface FLObjcType : NSObject<FLGenerated, NSCopying> {
@private
    FLObjcName* _typeName;
    NSString* _importFileName;
}

- (id) initWithTypeName:(FLObjcName*) typeName 
         importFileName:(NSString*) importFileName;

@property (readonly, strong, nonatomic) FLObjcName* typeName;
@property (readonly, strong, nonatomic) NSString* importFileName;
@property (readonly, assign, nonatomic) BOOL isObject;
@property (readonly, strong, nonatomic) NSString* generatedObjectClassName;
@property (readonly, assign, nonatomic) BOOL canForwardReference;
@property (readonly, assign, nonatomic) BOOL isMutableObject;

- (void) objcObject:(FLObjcObject*) object 
didConfigureProperty:(FLObjcProperty*) property;

@end













