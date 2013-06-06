//
//  FLObjcCodeElement.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//
#import "FLGenerated.h"

@class FLObjcCodeBuilder;
@class FLObjcFile;
@class FLObjcProject;

@protocol FLObjcCodeElement <NSObject>
- (void) writeCodeToHeaderFile:(FLObjcFile*) file 
               withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder;

- (void) writeCodeToSourceFile:(FLObjcFile*) file 
               withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder;

- (FLObjcFile*) headerFile;

- (FLObjcFile*) sourceFile;

@end

@interface FLObjcCodeElement : NSObject<FLObjcCodeElement, FLGenerated> {
@private
    __unsafe_unretained FLObjcProject* _project;
}
@property (readwrite, assign, nonatomic) FLObjcProject* project;

- (id) initWithProject:(FLObjcProject*) project;

@end
