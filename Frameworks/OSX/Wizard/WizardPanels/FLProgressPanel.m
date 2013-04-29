//
//  FLProgressPanel.m
//  FishLampOSX
//
//  Created by Mike Fullerton on 4/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLProgressPanel.h"

@interface FLProgressPanel ()

@end

@implementation FLProgressPanel

- (id) init {
    return [self initWithNibName:@"FLProgressPanel" bundle:nil];
}

+ (id) progressPanel {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) awakeFromNib {
    [super awakeFromNib];
    
    [_progress startAnimation:self];
}

- (void) setProgressText:(NSString*) text {
    _textField.stringValue = text;
}

- (IBAction) cancelButtonWasPushed:(id) button {
    [self.delegate progressPanelWasCancelled:self];
}

@end