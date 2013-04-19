//
//  FLSmallWizardView.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLSmallPanelView.h"

@implementation FLSmallPanelView

- (void) setup {
#if OSX
    self.autoresizingMask = NSViewMaxXMargin | NSViewMaxYMargin | NSViewMinXMargin | NSViewMinYMargin; 
#endif    
    self.backgroundColor = [NSColor gray95Color];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

@end