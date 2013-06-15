//
//  FLObjcFileHeader.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeElement.h"
@class FLCodeProject;

@interface FLObjcFileHeader : FLObjcCodeElement {
@private
    FLCodeProject* _codeProject;
}
- (void) configureWithInputProject:(FLCodeProject*) codeProject;

+ (id) objcFileHeader:(FLObjcProject*) project; 

@end

@interface FLObjcGeneratedFileHeader : FLObjcFileHeader
+ (id) objcGeneratedFileHeader;
@end

@interface FLObjcUserFileHeader : FLObjcFileHeader
+ (id) objcUserFileHeader;
@end