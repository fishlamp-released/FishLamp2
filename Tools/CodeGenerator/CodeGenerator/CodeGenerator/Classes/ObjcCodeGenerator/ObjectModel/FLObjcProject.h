//
//  FLObjcProject.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 6/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLamp.h"

@class FLObjcFileManager;
@class FLObjcTypeRegistry;
@class FLCodeProject;
@class FLCodeGeneratorResult;

@interface FLObjcProject : NSObject {
@private 
    FLObjcFileManager* _fileManager;
    FLObjcTypeRegistry* _typeRegistry;
    FLCodeProject* _inputProject;
}
@property (readonly, strong, nonatomic) FLCodeProject* inputProject;

@property (readonly, strong, nonatomic) FLObjcFileManager* fileManager;
@property (readonly, strong, nonatomic) FLObjcTypeRegistry* typeRegistry;

@property (readonly, strong, nonatomic) NSString* classPrefix;


+ (id) objcProject;
- (void) configureWithProjectInput:(FLCodeProject*) project;
- (FLCodeGeneratorResult*) generateFiles;

@end
