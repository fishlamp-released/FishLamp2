//
//  FLObjcFileManager.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcFileManager.h"
#import "FLCodeProject.h"
#import "FLCodeProject+Additions.h"
#import "FLCodeGeneratorOptions.h"
#import "FLCodeGeneratorResult.h"

#import "FLObjcCodeGeneratorHeaders.h"

@interface FLObjcFileManager ()
@property (readwrite, assign, nonatomic) FLObjcProject* project;
@end

@implementation FLObjcFileManager
@synthesize files = _files;
@synthesize project = _project;

- (id) initWithProject:(FLObjcProject*) project {	
	self = [super init];
	if(self) {
		_files = [[NSMutableArray alloc] init];
        self.project = project;
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
	[_files release];
	[super dealloc];
}
#endif

+ (id) objcFileManager:(FLObjcProject*) codeProject {
    return FLAutorelease([[[self class] alloc] initWithProject:codeProject]);
}

- (NSString*) outputFolderPath  {

// TODO: abstract away dependency on inputProject
    NSString* outPath = self.project.inputProject.projectFolderPath;

	if(FLStringIsNotEmpty(self.project.inputProject.generatorOptions.objectsFolderName)) { 
        outPath = [outPath stringByAppendingPathComponent:self.project.inputProject.generatorOptions.objectsFolderName];
    }

    return outPath;
}

- (void) createGeneratedDirectoryIfNeeded:(NSString*) path {
    BOOL isDirectory = NO;
    if(![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory]){
        NSError* err = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&err];
        if(err){
            FLThrowIfError(err);
        }
    }
    else if(!isDirectory){

    // TODO: need to throw an error, not an exception.
        @throw [NSException exceptionWithName:@"Can't create generation folder" reason:@"Folder exists already but is a file" userInfo:nil];
    }
}

- (FLCodeGeneratorResult*) writeFilesToDisk {

// TODO: refactor this.
	
//	if(_comments && _comments.count) {
//		FLObjcCodeBuilder* builder = [FLObjcCodeBuilder codeDocument];
//		for(FLCodeComment* comment in _comments) {
//			[builder appendLineWithFormat:@"\"%@.%@\" = \"%@\";", comment.object, comment.commentID, [comment.comment stringByReplacingOccurrencesOfString:@"\"" withString:@"\'"]];
//		}
//		
//		FLCodeGeneratorFile* commentsFile = [FLCodeGeneratorFile file];
//		commentsFile.name = [NSString stringWithFormat:@"%@.strings", forProject.projectName];
//		commentsFile.contents = [builder buildString];
//		[_generatedFiles addObject:commentsFile];
//	}

    //FSPathMoveObjectToTrashSync

//    [self generateFilesInArray:_userFiles folderPath:[objectsFolderPath stringByAppendingPathComponent:@"Generated+User"] result:result];
//    [self generateFilesInArray:_generatedFiles folderPath:[objectsFolderPath stringByAppendingPathComponent:@"Generated"] result:result];


    FLCodeGeneratorResult* result = [FLCodeGeneratorResult codeGeneratorResult];

    if(!_files || _files.count == 0) {
        return result;
    }

    NSString* folderPath = [self outputFolderPath];

    [self createGeneratedDirectoryIfNeeded:folderPath];

// TODO: 
// Make this an atomic operation.
// 1. copy changed file to temp folder
// 2. if there's a failure, restore the file.

	for(FLObjcFile* file in _files) {

        NSString* srcPath = [folderPath stringByAppendingPathComponent:file.fileName];

        FLObjcCodeBuilder* codeBuilder = [FLObjcCodeBuilder objcCodeBuilder];

        [file willGenerateFileWithFileManager:self];
        
        FLCodeGeneratorFileWriteResult writeResult = [file writeFileToPath:srcPath withCodeBuilder:codeBuilder];

        switch(writeResult) {
            case FLCodeGeneratorFileWriteResultUnchanged:
                [result addUnchangedFile:srcPath];
            break;

            case FLCodeGeneratorFileWriteResultUpdated:
                [result addChangedFile:srcPath];
            break;

            case FLCodeGeneratorFileWriteResultNew:
                [result addNewFile:srcPath];
            break;

        }
    }

    return result;
}

- (void) addFile:(FLObjcFile*) file {
    FLAssertNotNil(file);
    FLAssertStringIsNotEmptyWithComment(file.fileName, @"file has no name");

    [_files addObject:file];
}


- (void) addFilesWithArrayOfCodeElements:(NSArray*) elementList {

    FLObjcFileHeader* fileHeader = [FLObjcFileHeader objcFileHeader:self.project];
    [fileHeader configureWithInputProject:self.project.inputProject];

    for(FLObjcCodeElement* element in elementList) {
            
        FLObjcFile* headerFile = [element headerFile];
        if(headerFile) {
            [headerFile addFileElement:fileHeader];
            [headerFile addFileElement:element];
            [self addFile:headerFile];
        }
        
        FLObjcFile* sourceFile = [element sourceFile];
        if(sourceFile) {
            [sourceFile addFileElement:fileHeader];
            [sourceFile addFileElement:element];
            [self addFile:sourceFile];
        }
    }
}

@end
