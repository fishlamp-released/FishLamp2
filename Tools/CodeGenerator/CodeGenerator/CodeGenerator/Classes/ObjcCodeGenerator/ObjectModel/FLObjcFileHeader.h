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
- (void) configureWithCodeProject:(FLCodeProject*) codeProject;

+ (id) objcFileHeader:(FLObjcTypeIndex*) typeIndex; 

@end
