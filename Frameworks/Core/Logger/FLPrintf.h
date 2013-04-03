//
//  FLPrintf.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"

extern void FLPrintFormatWithIndent(NSUInteger indent, NSString* format, ...);
extern void FLPrintFormat(NSString* format, ...);
extern void FLPrintString(NSString* format);
extern void FLPrintStringWithIndent(NSUInteger indent, NSString* string);


extern void FLIndentString(void (^block)());