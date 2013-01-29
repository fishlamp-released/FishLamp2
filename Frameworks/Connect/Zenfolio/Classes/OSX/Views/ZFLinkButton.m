//
//  ZFLinkButton.m
//  ZenLib
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFLinkButton.h"
#import "NSColor+ZFAdditions.h"

@implementation ZFLinkButton

- (void) go:(id) sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:self.title]];
}

- (void) setToZenfolioStyle {
    [self setTarget:self];
    [self setAction:@selector(go:)];
    [self setBezelStyle:NSRoundedBezelStyle];
    [self setBordered:NO];
    [self setTitleColor:[NSColor whiteColor] withFont:[NSFont zenfolioLinkButtonFont]];
    [self setEnabled:YES];
    [self setButtonType:NSMomentaryLightButton];
}

- (void)highlight:(BOOL)flag {
    if(flag) {
        [self setTitleColor:[NSColor zenfolioOrange] withFont:[NSFont zenfolioLinkButtonFont]];
    }
    else {
        [self setTitleColor:[NSColor whiteColor] withFont:[NSFont zenfolioLinkButtonFont]];
    }
    
    [super highlight:flag];
}

@end
