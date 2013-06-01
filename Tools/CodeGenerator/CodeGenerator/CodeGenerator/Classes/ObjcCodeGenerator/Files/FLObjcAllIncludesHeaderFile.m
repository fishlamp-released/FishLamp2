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
#import "FLObjcTypeIndex.h"
#import "FLCodeProjectLocation.h"

@interface FLObjcAllIncludesHeaderFile ()
@property (readwrite, strong, nonatomic) FLObjcTypeIndex* typeIndex;
@end

@implementation FLObjcAllIncludesHeaderFile
@synthesize typeIndex = _typeIndex;

- (id) initWithTypeIndex:(FLObjcTypeIndex*) typeIndex fileName:(NSString*) fileName {	
	self = [super initWithFileName:fileName];
	if(self) {  
        self.typeIndex = typeIndex;
		_files = [[NSMutableArray alloc] init];
	}
	return self;
}

+ (id) allIncludesHeaderFile:(FLObjcTypeIndex*) index  fileName:(NSString*) fileName {
    return FLAutorelease([[[self class] alloc] initWithTypeIndex:index fileName:fileName]);
}

#if FL_MRC
- (void) dealloc {
    [_typeIndex release];
    [_files release];
	[super dealloc];
}
#endif

- (void) willGenerateFileWithFileManager:(FLObjcFileManager*) fileManager 
                          withCodeProject:(FLCodeProject*) codeProject {

    FLObjcFileHeader* fileHeader = [FLObjcFileHeader objcFileHeader:self.typeIndex];
    [fileHeader configureWithCodeProject:codeProject];
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
