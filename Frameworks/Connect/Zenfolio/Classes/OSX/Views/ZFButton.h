//
//  ZFButton.h
//  ZenLib
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "NSFont+ZFAdditions.h"

@interface NSButton (FLAdditions)
- (void) setTitleColor:(NSColor*) color withFont:(NSFont*) font;
@end

@interface ZFButton : NSButton
- (void) setToZenfolioStyle;
@end

