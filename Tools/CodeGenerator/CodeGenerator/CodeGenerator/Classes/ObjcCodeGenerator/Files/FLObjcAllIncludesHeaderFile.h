//
//  FLObjcAllIncludesHeaderFile.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/14/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcGeneratedHeaderFile.h"
@class FLObjcTypeIndex;
@class FLCodeProjectLocation;

@interface FLObjcAllIncludesHeaderFile : FLObjcGeneratedHeaderFile {
@private
    NSMutableArray* _files;
    FLObjcTypeIndex* _typeIndex;
}

+ (id) allIncludesHeaderFile:(FLObjcTypeIndex*) typeIndex  fileName:(NSString*) fileName;

@end
