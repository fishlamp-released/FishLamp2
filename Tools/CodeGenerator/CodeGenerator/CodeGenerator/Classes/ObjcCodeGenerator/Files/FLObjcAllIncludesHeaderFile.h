//
//  FLObjcAllIncludesHeaderFile.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/14/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcGeneratedHeaderFile.h"
@class FLObjcProject;
@class FLCodeProjectLocation;

@interface FLObjcAllIncludesHeaderFile : FLObjcGeneratedHeaderFile {
@private
    NSMutableArray* _files;
    __unsafe_unretained FLObjcProject* _project;
}

+ (id) allIncludesHeaderFile:(FLObjcProject*) project  
                    fileName:(NSString*) fileName;

@end
