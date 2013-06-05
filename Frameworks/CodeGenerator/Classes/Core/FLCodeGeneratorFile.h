//
//  FLCodeGeneratorFile.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 1/6/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeBuilder.h"

typedef enum {
    FLCodeGeneratorFileWriteResultUnchanged,
    FLCodeGeneratorFileWriteResultUpdated,
    FLCodeGeneratorFileWriteResultNew
} FLCodeGeneratorFileWriteResult;

@interface FLCodeGeneratorFile : NSObject {
@private
    NSString* _fileName;
}

@property (readwrite, strong, nonatomic) NSString* fileName;

- (id) initWithFileName:(NSString*) fileName;

+ (id) codeGeneratorFile:(NSString*) name;
+ (id) codeGeneratorFile;

- (FLCodeGeneratorFileWriteResult) writeFileToPath:(NSString*) path 
                                  withCodeBuilder:(FLCodeBuilder*) codeBuilder;

- (void) writeCodeToCodeBuilder:(FLCodeBuilder*) codeBuilder;

- (BOOL) canUpdateExistingFile;

@end
