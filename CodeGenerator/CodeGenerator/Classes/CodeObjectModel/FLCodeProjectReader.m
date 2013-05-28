//
//  FLCodeProjectReader.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 3/16/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeProjectReader.h"
#import "FLCodeProject+Additions.h"
#import "FLObjectDescriber.h"


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

- (BOOL) canReadProjectFromLocation:(FLCodeProjectLocation*) location {
    for(id<FLCodeProjectReader> reader in _fileReaders) {
        if([reader canReadProjectFromLocation:location]) {
            return YES;
        }
    }
    
    return NO;
}

- (FLCodeProjectLocation*) projectLocationFromImport:(FLCodeImport*) import 
                                   projectFolderPath:(NSString*) projectFolderPath {
    NSSet* enums = import.typeValues;

    FLCodeProjectLocationType type = FLCodeProjectLocationTypeNone;
    NSURL* url = nil;

    for(NSNumber* number in enums) {
        switch(number.intValue) {
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

    return [FLCodeProjectLocation resourceDescriptor:url resourceType:type];
}

- (void) didLoadProject:(FLCodeProject*) project fromLocation:(FLCodeProjectLocation*) location {
    project.projectPath = location.URL;
	if(FLStringIsEmpty(project.projectName)){
		project.projectName = [[project.projectPath lastPathComponent] stringByDeletingPathExtension];
	}

    // TODO: why?
	project.projectName = [project.projectName stringByReplacingOccurrencesOfString:@"." withString:@"_"];
	FLConfirmStringIsNotEmptyWithComment(project.projectName, @"project needs to be named - <description name='foo'/>");

    if(FLStringIsEmpty(project.schemaName)) {
        project.schemaName = [[project.projectPath lastPathComponent] stringByDeletingPathExtension];
    }
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

- (FLCodeProject *) readProjectFromLocation:(FLCodeProjectLocation*) location {
    FLAssertNotNil(_fileReaders);
    FLAssert(_fileReaders.count > 0);

    for(id<FLCodeProjectReader> reader in _fileReaders) {

        if([reader canReadProjectFromLocation:location]) {
            FLCodeProject* project = [reader readProjectFromLocation:location];
            [self didLoadProject:project fromLocation:location];
            [self loadSubProjectsRecursively:project];
            return project;
        }
    }

    FLConfirmationFailureWithComment(@"import not loaded for location: %@", location.URL);

    return nil;
}
@end
