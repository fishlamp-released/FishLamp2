//
//  FLCodeProjectReader.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 3/16/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeProjectReader.h"
#import "FLObjectDescriber.h"
#import "FLCodeProjectLocation.h"
#import "FLCodeProject.h"
#import "FLCodeInputType.h"
#import "FLCodeImport.h"
#import "FLCodeProjectInfo.h"
#import "FLCodeGeneratorOptions.h"
#import "FLCodeObject.h"
#import "FLCodeProperty.h"

@interface FLCodeProjectReader ()
@property (readwrite, strong) NSArray* fileReaders;
@end

@implementation FLCodeProjectReader

@synthesize fileReaders = _fileReaders;

- (id) init {
    self = [super init];
    if(self) {
        _fileReaders = [[NSMutableArray alloc]init];
    }
    return self;
}

+ (id) codeProjectReader {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void)addFileReader:(id<FLCodeProjectReader>)fileReader {
    [_fileReaders addObject:fileReader];
}

//- (BOOL) canReadProjectFromLocation:(FLCodeProjectLocation*) location {
//    for(id<FLCodeProjectReader> reader in _fileReaders) {
//        if([reader canReadProjectFromLocation:location]) {
//            return YES;
//        }
//    }
//    
//    return NO;
//}

- (FLCodeProjectLocation*) projectLocationFromImport:(FLCodeImport*) import 
                                   projectFolderPath:(NSString*) projectFolderPath {
    
    FLCodeInputTypeEnumSet* enums = import.typeEnumSet;
    FLCodeProjectLocationType type = FLCodeProjectLocationTypeNone;

    if(!enums.count) {
        [enums addEnum:FLCodeInputTypeFile];
    }

    NSURL* url = nil;

    for(FLEnumPair* number in enums) {
        switch(number.enumValue) {
            case FLCodeInputTypeFile:
                type |= FLCodeProjectLocationTypeFile;
                url = [NSURL fileURLWithPath:[projectFolderPath stringByAppendingPathComponent:import.path]];
            break;

            case FLCodeInputTypeHttp:
                type |= FLCodeProjectLocationTypeHttp;
                url = [NSURL URLWithString:import.path];
            break;

            case FLCodeInputTypeWsdl:
                type |= FLCodeProjectLocationTypeWsdl;
                url = [NSURL URLWithString:import.path];
            break;

            default:
                break;
        }
    }

    FLAssertIsNotNil(url);

    return [FLCodeProjectLocation codeProjectLocation:url resourceType:type];
}

- (void) didLoadProject:(FLCodeProject*) project 
           fromLocation:(FLCodeProjectLocation*) location {
    
    FLConfirmNotNilWithComment(project, @"project was not created");

    project.projectLocation = location;
    project.projectPath = location.URL.path;
    
	if(FLStringIsEmpty(project.info.projectName)){
		project.info.projectName = [[project.projectPath lastPathComponent] stringByDeletingPathExtension];
	}

    project.info.projectName = [project.info.projectName stringByReplacingOccurrencesOfString:@"." withString:@"_"];
	FLConfirmStringIsNotEmptyWithComment(project.info.projectName, @"project needs to be named - <description name='foo'/>");

//    if(FLStringIsEmpty(project.schemaName)) {
//        project.schemaName = [[project.projectPath lastPathComponent] stringByDeletingPathExtension];
//    }
}

- (void) loadSubProjectsRecursively:(FLCodeProject*) project {
    for(FLCodeImport* import in project.imports) {

        FLCodeProjectLocation* location = [self projectLocationFromImport:import projectFolderPath:project.projectFolderPath];

        FLCodeProject* subProject = [self readProjectFromLocation:location];
            
        if(subProject) {
            FLMergeObjects(project, subProject, FLMergeModePreserveDestination);
        }
	}
}

- (void) finalizeLoadedProject:(FLCodeProject*) project {
    
    if(project.options.canLazyCreate) {
        for(FLCodeObject* object in project.classes) {
            object.canLazyCreate = YES;
        }
    }

    for(FLCodeObject* object in project.classes) {
        if(object.canLazyCreate) {
            for(FLCodeProperty* prop in object.properties) {
                prop.canLazyCreate = YES;
            }
        }
    }
}

- (FLCodeProject *) readProjectFromFileURL:(NSURL*) fileURL {
    FLCodeProjectLocation* projectLocation = [FLCodeProjectLocation codeProjectLocation:fileURL
                                                                           resourceType:FLCodeProjectLocationTypeFile];

    return [self readProjectFromLocation:projectLocation];
}

- (FLCodeProject *) parseProjectFromData:(NSData*) data {
    return nil;
}

- (FLCodeProject *) readProjectFromLocation:(FLCodeProjectLocation*) location {
    FLAssertNotNil(_fileReaders);
    FLAssert(_fileReaders.count > 0);

    NSData* data = [location loadDataInResource];

    for(id<FLCodeProjectReader> reader in _fileReaders) {
        FLCodeProject* project = [reader parseProjectFromData:data];
        if(project) {
            [self didLoadProject:project fromLocation:location];
            [self loadSubProjectsRecursively:project];
            [self finalizeLoadedProject:project];
            return project;
        }
    }

    FLConfirmationFailureWithComment(@"import not loaded for location: %@", location.URL);

    return nil;
}
@end
