//
//  FLObjcCodeLines.h
//  FishLampCodeGenerator
//
//  Created by Mike Fullerton on 6/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeLines.h"

#import "FLObjcCodeBuilder.h"
@class FLObjcProject;

@protocol FLObjcCodeLine <NSObject>
- (void) appendToObjcCodeBuilder:(FLObjcCodeBuilder*) builder 
                     withProject:(FLObjcProject*) project;
                     
@end

@interface FLObjcCodeBuilder (FLObjcCodeLine)

- (void) appendCodeLine:(FLCodeLine*) codeLine 
            withProject:(FLObjcProject*) project;


@end

@interface FLObjcCodeLines : FLCodeLine

@end

