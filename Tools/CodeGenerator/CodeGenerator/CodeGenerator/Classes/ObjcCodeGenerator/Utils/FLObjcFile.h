//
//  FLObjcFile.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeGeneratorFile.h"

@protocol FLObjcCodeElement;
@class FLCodeSession;
@class FLObjcFileManager;
@class FLCodeProject;

@interface FLObjcFile : FLCodeGeneratorFile {
@private

    NSMutableArray* _fileElements;
}

- (void) addFileElement:(id<FLObjcCodeElement>) element;

- (NSString*) counterPartFileName;
                           
- (void) willGenerateFileWithFileManager:(FLObjcFileManager*) fileManager 
                          withCodeProject:(FLCodeProject*) codeProject;

- (BOOL) isHeaderFile; 
                           
@end

@interface FLObjcHeaderFile : FLObjcFile
+ (id) headerFile:(NSString*) rootFileName;
@end

@interface FLObjcUserHeaderFile : FLObjcHeaderFile 
@end

@interface FLObjcGeneratedHeaderFile : FLObjcHeaderFile {
@private
    FLObjcUserHeaderFile* _userHeaderFile;
}
@property (readwrite, strong, nonatomic) FLObjcUserHeaderFile* userHeaderFile;
@end



@interface FLObjcSourceFile : FLObjcFile
+ (id) sourceFile:(NSString*) rootFileName;
@end

@interface FLObjcUserSourceFile : FLObjcSourceFile
@end

@interface FLObjcGeneratedSourceFile : FLObjcSourceFile {
@private
    FLObjcUserSourceFile* _userSourceFile;
}

@property (readwrite, strong, nonatomic) FLObjcUserSourceFile* userSourceFile;
@end
