//
//  FLPrintf.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/22/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCoreRequired.h"

extern void FLPrintFormatWithIndent(NSUInteger indent, NSString* format, ...);
extern void FLPrintFormat(NSString* format, ...);
extern void FLPrintString(NSString* format);
extern void FLPrintStringWithIndent(NSUInteger indent, NSString* string);


extern void FLIndentString(void (^block)());