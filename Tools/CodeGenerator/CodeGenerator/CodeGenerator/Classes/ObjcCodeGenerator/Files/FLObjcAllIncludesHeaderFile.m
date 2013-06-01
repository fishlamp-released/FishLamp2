//
//  FLObjcAllIncludesHeaderFile.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/14/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcAllIncludesHeaderFile.h"
#import "FLObjcCodeBuilder.h"
#import "FLObjcFileHeader.h"
#import "FLObjcFile.h"
#import "FLObjcFileManager.h"
#import "FLObjcProject.h"
#import "FLCodeProjectLocation.h"

@interface FLObjcAllIncludesHeaderFile ()
@property (readwrite, assign, nonatomic) FLObjcProject* project;
@end

@implementation FLObjcAllIncludesHeaderFile
@synthesize project = _project;

- (id) initWithProject:(FLObjcProject*) project fileName:(NSString*) fileName {	
	self = [super initWithFileName:fileName];
	if(self) {  
        self.project = project;
		_files = [[NSMutableArray alloc] init];
	}
	return self;
}

+ (id) allIncludesHeaderFile:(FLObjcProject*) project  fileName:(NSString*) fileName {
    return FLAutorelease([[[self class] alloc] initWithProject:project fileName:fileName]);
}

#if FL_MRC
- (void) dealloc {
    [_files release];
	[super dealloc];
}
#endif

- (void) willGenerateFileWithFileManager:(FLObjcFileManager*) fileManager  {

    FLObjcFileHeader* fileHeader = [FLObjcFileHeader objcFileHeader:self.project];
    [fileHeader configureWithInputProject:fileManager.project.inputProject];
    
    [self addFileElement:fileHeader];

    for(FLObjcFile* file in fileManager.files) {
        [_files addObject:file];
    }
}                          

- (void) writeCodeToCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    [super writeCodeToCodeBuilder:codeBuilder];
    
    for(FLObjcFile* file in _files) {
        if([file.fileName hasSuffix:@".h"]) {
            [codeBuilder appendImport:file.fileName];
        }
    
    }
}

@end
