//
//  FLObjcStringStatement.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcStatement.h"

@class FLCodeChunk;
@class FLObjcProject;
@class FLCodeLine;
@class FLObjcCodeBuilder;

@interface FLObjcStringStatement : FLObjcStatement {
@private
    FLObjcCodeBuilder* _string;
}
+ (id) objcStringStatement;

@property (readonly, strong, nonatomic) FLObjcCodeBuilder* codeBuilder;

@end

