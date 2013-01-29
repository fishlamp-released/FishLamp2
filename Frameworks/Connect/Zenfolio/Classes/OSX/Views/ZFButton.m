//
//  ZFButton.m
//  ZenLib
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFButton.h"
#import "NSColor+ZFAdditions.h"
#import "NSFont+ZFAdditions.h"

@implementation NSButton (FLAdditions) 
- (void) setTitleColor:(NSColor*) color withFont:(NSFont*) font {

    NSDictionary *txtDict = [NSDictionary dictionaryWithObjectsAndKeys:
        font, NSFontAttributeName, 
        color, NSForegroundColorAttributeName, 
        nil];

    NSAttributedString *attrStr = FLAutorelease([[NSAttributedString alloc] initWithString:self.title attributes:txtDict]);
        
    [self.cell setAttributedTitle:attrStr];
    [self updateCell:[self cell]];
    [self setNeedsDisplay:YES];
}
@end

@implementation ZFButton

- (void) setToZenfolioStyle {
    [self setBezelStyle:NSRoundedBezelStyle];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setToZenfolioStyle];
    }
    
    return self;
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:FLRectSetSize(frame, 160, 32)];
    if (self) {
        [self setToZenfolioStyle];
    }
    
    return self;
}



@end
