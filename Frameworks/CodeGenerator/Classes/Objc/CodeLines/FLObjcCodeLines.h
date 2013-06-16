//
//  FLObjcCodeLines.h
//  FishLampCodeGenerator
//
//  Created by Mike Fullerton on 6/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeBuilder.h"

@class FLObjcProject;
@class FLCodeElement;

@protocol FLObjcCodeLine <NSObject>
- (void) appendToObjcCodeBuilder:(FLObjcCodeBuilder*) builder 
                     withProject:(FLObjcProject*) project;
                     
@end

@interface FLObjcCodeBuilder (FLObjcCodeLine)

- (void) appendCodeElement:(FLCodeElement*) codeLine
               withProject:(FLObjcProject*) project;


@end


