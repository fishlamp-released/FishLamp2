//
//  FLCodeGeneratorFile.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 1/6/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeGeneratorFile.h"
#import "FLCodeBuilder.h"
#import "NSString+Lists.h"

@implementation FLCodeGeneratorFile
@synthesize fileName = _fileName;
@synthesize folder = _folder;

- (id) initWithFileName:(NSString*) name  {
    self = [super init];
    if(self) {
        FLAssertStringIsNotEmpty(name);
        self.fileName = name;
    }
    return self;
}

+ (id) codeGeneratorFile {
    return FLAutorelease([[[self class] alloc] initWithFileName:nil]);
}

+ (id) codeGeneratorFile:(NSString*) name {
    return FLAutorelease([[[self class] alloc] initWithFileName:name]);
}

#if FL_MRC
- (void) dealloc {
	[_folder release];
    [_fileName release];
	[super dealloc];
}
#endif

- (NSString*) relativePathToProject {
    return [FLEmptyStringOrString(self.folder) stringByAppendingPathComponent:self.fileName];
}

- (BOOL) canUpdateExistingFile {
    return NO;
}

#define kIgnoreLine @"// Generated by"

- (BOOL) linesInFileAreEqual:(NSArray*) lhs 
                         rhs:(NSArray*) rhs  {

    FLAssertNotNil(lhs);
    FLAssertNotNil(rhs);
                         
	if(lhs.count != rhs.count) {
		return NO;
	}
	
	for(NSUInteger i = 0; i < lhs.count; i++) {
		NSString* lhsStr = [lhs objectAtIndex:i];
		NSString* rhsStr = [rhs objectAtIndex:i];
		
        if(FLStringsAreEqual(lhsStr, rhsStr)) {
            continue;
        }
        
        if([lhsStr hasPrefix:kIgnoreLine] && [rhsStr hasPrefix:kIgnoreLine]) {
            continue;
        }
        
        return NO;
	}
	
	return YES;
}

- (BOOL) isTheSameAsFileOnDisk:(NSString*) pathToOldFile
         generatedFileContents:(NSString*) newFileContents {
	
    NSError* err = nil;
	NSString* existingFileContents = [NSString stringWithContentsOfFile:pathToOldFile 
                                                               encoding:NSUTF8StringEncoding error:&err];
    FLThrowIfError(err);                                                                     

	return [self linesInFileAreEqual:[existingFileContents lines] rhs:[newFileContents lines]];
}

- (void) writeCodeToCodeBuilder:(FLCodeBuilder*) codeBuilder {
}

- (FLCodeGeneratorFileWriteResult) writeFileToPath:(NSString*) path 
                                   withCodeBuilder:(FLCodeBuilder*) codeBuilder {

    [self writeCodeToCodeBuilder:codeBuilder];
    
    FLPrettyString* string = [FLPrettyString prettyString:[FLWhitespace tabbedWithSpacesWhitespace]];
    [string appendBuildableString:codeBuilder];
    NSString* generatedFileContents = [string string];
    FLAssertStringIsNotEmpty(generatedFileContents);

    BOOL exists = NO;

    if( [[NSFileManager defaultManager] fileExistsAtPath:path] ) {
        if(![self canUpdateExistingFile] || [self isTheSameAsFileOnDisk:path generatedFileContents:generatedFileContents]) {
            return FLCodeGeneratorFileWriteResultUnchanged;
        }
        exists = YES;
    }
    
    NSError* err = nil;
    [generatedFileContents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&err];
    FLThrowIfError(err);
        
    return exists ? 
        FLCodeGeneratorFileWriteResultUpdated :
        FLCodeGeneratorFileWriteResultNew;
}




@end
