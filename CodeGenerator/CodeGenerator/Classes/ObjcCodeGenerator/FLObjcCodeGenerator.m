//
//  FLObjcCodeGenerator.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeGenerator.h"
#import "FLCodeProject.h"
#import "FLObjcTypeIndex.h"

#import "FLObjcType.h"
#import "FLObjcNamedObjectCollection.h"
#import "FLObjcObject.h"
#import "FLObjcFileHeader.h"
#import "FLObjcName.h"
#import "FLCodeMethod.h"
#import "FLObjcEnum.h"
#import "FLObjcFile.h"
#import "FLObjcCodeBuilder.h"
#import "FLCodeObject.h"
#import "FLCodeEnum.h"
#import "FLObjcFileManager.h"
#import "FLObjcAllIncludesHeaderFile.h"
#import "FLCodeProjectLocation.h"

@interface FLObjcCodeGenerator ()
@end

@implementation FLObjcCodeGenerator

+ (id) objcCodeGenerator {
    return FLAutorelease([[[self class] alloc] init]);
}

- (FLCodeGeneratorResult*) generateCodeWithCodeProject:(FLCodeProject*) project 
                                          fromLocation:(FLCodeProjectLocation*) location {


    @try {
        FLObjcFileManager* fileManager = [FLObjcFileManager objcFileManager:project];
        FLObjcTypeIndex* typeIndex = [FLObjcTypeIndex objcTypeIndex:project];


        NSMutableArray* enums = [NSMutableArray array];
        for(FLCodeEnumType* codeEnum in project.enumTypes) {
            FLObjcEnum* anEnum = [FLObjcEnum objcEnum:typeIndex];
            [anEnum configureWithCodeEnumType:codeEnum];
            [enums addObject:anEnum];
            
            [typeIndex setObjcType:anEnum.enumType];
        }
        [fileManager addFilesWithArrayOfCodeElements:enums typeIndex:typeIndex];

        for(FLCodeObject* object in project.objects) {
            FLObjcClassName* className = [FLObjcClassName objcClassName:object.className prefix:typeIndex.classPrefix];
            FLObjcType* forwardDecl = [FLObjcObjectType objcObjectType:className importFileName:[NSString stringWithFormat:@"%@.h", className.generatedName]];
            [typeIndex setObjcType:forwardDecl];
        }

        for(FLCodeArray* codeArray in project.arrays) {
            FLObjcClassName* className = [FLObjcClassName objcClassName:codeArray.name prefix:typeIndex.classPrefix];
            FLObjcType* forwardDecl = [FLObjcArrayType objcArrayType:className importFileName:[NSString stringWithFormat:@"%@.h", className.generatedName]];
            [typeIndex setObjcType:forwardDecl];
        }


        NSMutableArray* objects = [NSMutableArray array];
        for(FLCodeObject* object in project.objects) {
            FLObjcObject* objcObject = [FLObjcObject objcObject:typeIndex];
            [objcObject configureWithCodeObject:object];
            [objects addObject:objcObject];
        }

        [fileManager addFilesWithArrayOfCodeElements:objects typeIndex:typeIndex];

        if(project.generatorOptions.generateAllIncludesFile) {
        
            [fileManager addFile:[FLObjcAllIncludesHeaderFile allIncludesHeaderFile:typeIndex fileName:project.schemaName]];
        }

        return [fileManager writeFilesToDisk];
    }
    @finally {
    }
}





@end


