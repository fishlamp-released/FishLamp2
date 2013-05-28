//
//  FLObjcFile.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcFile.h"
#import "FLObjcTypeIndex.h"
#import "FLObjcCodeElement.h"

@interface FLObjcFile ()
@property (readwrite, strong, nonatomic) NSArray* fileElements;
@end

@implementation FLObjcFile

@synthesize fileElements = _fileElements;

- (id) init {	
	return [self initWithFileName:nil];
}

- (id) initWithFileName:(NSString*) name {
    self = [super initWithFileName:name];
    if(self) {
        _fileElements = [[NSMutableArray alloc] init];
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_fileElements release];
    [super dealloc];
}
#endif

- (void) addFileElement:(id<FLObjcCodeElement>) element {
    [_fileElements addObject:element];
}


//- (void) appendFileHeaderToCodeBuilder:(FLObjcCodeBuilder*) codeBuilder 
//                                                      codeGenerator:(id) codeGenerator {
//    
////    [self.header deleteAllCharacters];
//
////    FLObjcComment* comment = [FLObjcComment objcComment];
//////    [header appendLine:@"<Generated>"];
//////    [header appendBlankLine];
////
////    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
////    [dateFormatter setDateStyle:kCFDateFormatterShortStyle];
////    [dateFormatter setTimeStyle:kCFDateFormatterShortStyle];
////
////    NSString *formattedDateString = [dateFormatter stringFromDate:[NSDate date]];
////    [comment appendLineWithFormat:kGeneratedFileHeader, formattedDateString];
////    [comment appendEmptyComment];
////	[comment appendLineWithFormat:@"%@", self.fileName];
////	[comment appendLineWithFormat:@"Project: %@", [codeGenerator project].projectName];
////	[comment appendLineWithFormat:@"Schema: %@", [codeGenerator project].schemaName];
////    [comment appendEmptyComment];
////	
////// TODO: get current year from system of course
////    
////    [comment appendLineWithFormat:@"// Copywrite (C) 2013 %@. All rights reserved.", [codeGenerator project].organization.name];
////    [comment appendEmptyComment];
////    
////    [codeBuilder addCodeChunk:comment];
////    
////	if([codeGenerator project].generatorOptions.disabled) {
////        [codeBuilder appendBlankLine];
////        [codeBuilder appendPreprocessorIf:@"DISABLED"];
////        [codeBuilder appendBlankLine];
////	} 
//}
//
//- (void) appendFileFooterToCodeBuilder:(FLObjcCodeBuilder*) codeBuilder 
//                         codeGenerator:(id) codeGenerator {
//
//	if([codeGenerator project].generatorOptions.disabled) {
//        [codeBuilder appendBlankLine];
//		[codeBuilder appendPreprocessorEndIf];
//	}
////    [codeBuilder appendBlankLine];
////    [codeBuilder appendComment:kWhittleCloseTag];
//}
- (NSString*) counterPartFileName {
    NSString* ext = [self.fileName pathExtension];
    if(FLStringsAreEqual(ext, @"h")) {
        return [[self.fileName stringByDeletingPathExtension] stringByAppendingPathExtension:@"m"];
    }
    else if(FLStringsAreEqual(ext, @"m")) {
        return [[self.fileName stringByDeletingPathExtension] stringByAppendingPathExtension:@"h"];
    }
    else {
        return nil;
    }
}

- (void) willGenerateFileWithFileManager:(FLObjcFileManager*) fileManager withCodeProject:(FLCodeProject*) codeProject {
}

- (BOOL) isHeaderFile {
    return NO;
}
@end

@implementation FLObjcHeaderFile
- (BOOL) isHeaderFile {
    return YES;
}

+ (id) headerFile:(NSString*) rootFileName {
    return FLAutorelease([[[self class] alloc] initWithFileName:rootFileName]);
}

- (void) writeCodeToCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    for(id<FLObjcCodeElement> codeElement in self.fileElements) {
        [codeElement writeCodeToHeaderFile:self withCodeBuilder:codeBuilder];
    }
}

- (void) setFileName:(NSString*) fileName {
    [super setFileName:[NSString stringWithFormat:@"%@.h", fileName]];
}

- (BOOL) canUpdateExistingFile {
    return YES;
}
@end

@implementation FLObjcSourceFile

+ (id) sourceFile:(NSString*) rootFileName {
    return FLAutorelease([[[self class] alloc] initWithFileName:rootFileName]);
}

- (void) writeCodeToCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    for(id<FLObjcCodeElement> codeElement in self.fileElements) {
        [codeElement writeCodeToSourceFile:self withCodeBuilder:codeBuilder];
    }
}

- (void) setFileName:(NSString*) fileName {
    [super setFileName:[NSString stringWithFormat:@"%@.m", fileName]];
}
- (BOOL) canUpdateExistingFile {
    return YES;
}
@end

@implementation FLObjcUserHeaderFile
- (void) setFileName:(NSString*) fileName {
    [super setFileName:[NSString stringWithFormat:@"%@+User.h", fileName]];
}

@end

@implementation FLObjcGeneratedHeaderFile
@synthesize userHeaderFile = _userHeaderFile;

- (BOOL) canUpdateExistingFile {
    return YES;
}

@end

@implementation FLObjcUserSourceFile

- (void) setFileName:(NSString*) fileName {
    [super setFileName:[NSString stringWithFormat:@"%@+User.m", fileName]];
}

@end

@implementation FLObjcGeneratedSourceFile
@synthesize userSourceFile = _userSourceFile;
- (BOOL) canUpdateExistingFile {
    return YES;
}

@end