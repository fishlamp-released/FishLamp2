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
#import "FLObjcCodeBuilder.h"
#import "FLObjcFileHeader.h"
#import "FLObjcTypeIndex.h"

@implementation FLObjcFileManager
@synthesize files = _files;

- (id) initWithCodeProject:(FLCodeProject*) codeProject {	
	self = [super init];
	if(self) {
		_files = [[NSMutableArray alloc] init];
        FLSetObjectWithRetain(_codeProject, codeProject);
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
    [_codeProject release];
    
	[_files release];
	[super dealloc];
}
#endif

+ (id) objcFileManager:(FLCodeProject*) codeProject {
    return FLAutorelease([[[self class] alloc] initWithCodeProject:codeProject]);
}

- (NSString*) outputFolderPath:(FLCodeProject*) project  {
    NSString* outPath = project.projectFolderPath;

	if(FLStringIsNotEmpty(project.generatorOptions.objectsFolderName)) { 
        outPath = [outPath stringByAppendingPathComponent:project.generatorOptions.objectsFolderName];
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

- (FLCodeGeneratorResult*) writeFilesToDiskWithProject:(FLCodeProject*) project {

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

    NSString* folderPath = [self outputFolderPath:project];

    [self createGeneratedDirectoryIfNeeded:folderPath];

// TODO:
// 1. copy changed file to temp folder
// 2. if there's a failure, restore the file.

	for(FLObjcFile* file in _files) {

        NSString* srcPath = [folderPath stringByAppendingPathComponent:file.fileName];

        FLObjcCodeBuilder* codeBuilder = [FLObjcCodeBuilder objcCodeBuilder];

        [file willGenerateFileWithFileManager:self withCodeProject:project];
        
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
    FLAssertStringIsNotEmptyWithComment(file.fileName, @"file has no name");

    [_files addObject:file];
}

- (FLCodeGeneratorResult*) writeFilesToDisk {
    return [self writeFilesToDiskWithProject:_codeProject];
}

- (void) addFilesWithArrayOfCodeElements:(NSArray*) elementList  
                               typeIndex:(FLObjcTypeIndex*) typeIndex {

    FLObjcFileHeader* fileHeader = [FLObjcFileHeader objcFileHeader:typeIndex];
    [fileHeader configureWithCodeProject:_codeProject];

    for(FLObjcCodeElement* element in elementList) {
        
        NSString* identifier = [element generatedName];
        FLAssertStringIsNotEmptyWithComment(identifier, @"element has no generated name");
    
        FLObjcHeaderFile* headerFile = [FLObjcGeneratedHeaderFile headerFile:identifier];
        [headerFile addFileElement:fileHeader];
        [headerFile addFileElement:element];
        [self addFile:headerFile];
        
        FLObjcSourceFile* sourceFile = [FLObjcGeneratedSourceFile sourceFile:identifier];
        [sourceFile addFileElement:fileHeader];
        [sourceFile addFileElement:element];
        [self addFile:sourceFile];
    }
}

@end
