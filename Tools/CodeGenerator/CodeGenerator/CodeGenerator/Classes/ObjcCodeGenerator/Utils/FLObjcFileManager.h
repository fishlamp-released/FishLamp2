//
//  FLObjcFileManager.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcFile.h"
@class FLObjcTypeIndex;
@class FLCodeProject;
@class FLCodeGeneratorResult;

@interface FLObjcFileManager : NSObject {
@private
    NSMutableArray* _files;
    FLCodeProject* _codeProject;
}
@property (readonly, strong, nonatomic) NSArray* files;

+ (id) objcFileManager:(FLCodeProject*) codeProject;

- (void) addFilesWithArrayOfCodeElements:(NSArray*) elementList  
                               typeIndex:(FLObjcTypeIndex*) typeIndex;

- (void) addFile:(FLObjcFile*) file;

- (FLCodeGeneratorResult*) writeFilesToDisk;

@end
