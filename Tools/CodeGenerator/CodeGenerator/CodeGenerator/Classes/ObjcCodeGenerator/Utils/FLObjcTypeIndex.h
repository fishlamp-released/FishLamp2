//
//  FLObjcTypeIndex.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLamp.h"

@class FLCodeProject;
@class FLObjcNamedObjectCollection;
@class FLObjcType;
@class FLObjcName;

@interface FLObjcTypeIndex : NSObject {
@private
    FLObjcNamedObjectCollection* _typeIndex;
    NSDictionary* _parseableTypes;
    FLCodeProject* _project;
}
+ (id) objcTypeIndex:(FLCodeProject*) codeProject;

- (void) setObjcType:(FLObjcType*) type;
- (FLObjcType*) objcTypeForTypeName:(NSString*) type;
- (FLObjcType*) objcTypeForClass:(Class) aClass;

@property (readonly, strong, nonatomic) NSString* classPrefix;
@property (readonly, strong, nonatomic) FLCodeProject* project;

@end
