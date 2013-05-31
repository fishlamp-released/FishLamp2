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
@class FLObjcTypeIndex;

@protocol FLObjcCodeElement <NSObject>
- (void) writeCodeToHeaderFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder;
- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder;
@end

@interface FLObjcCodeElement : NSObject<FLObjcCodeElement, FLGenerated> {
@private
    __unsafe_unretained FLObjcTypeIndex* _typeIndex;
}
@property (readwrite, assign, nonatomic) FLObjcTypeIndex* typeIndex;

- (id) initWithTypeIndex:(FLObjcTypeIndex*) index;

@end
