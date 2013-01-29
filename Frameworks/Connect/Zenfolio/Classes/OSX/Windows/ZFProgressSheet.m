//
//  ZFProgressSheet.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 1/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFProgressSheet.h"

@interface ZFProgressSheet ()

@end

@implementation ZFProgressSheet

@synthesize progressString = _progressString;
@synthesize cancelBlock = _cancelBlock;

- (id) init {
    self = [super initWithWindowNibName:@"ZFProgressSheet"];
    if(self) {
        
    }
    return self;
}


- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (id) progressWindowController {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_progressString release];
    [_cancelBlock release];
    [super dealloc];
}
#endif

- (IBAction) respondToCancelButton:(id) sender {
    if(_cancelBlock) {
        _cancelBlock();
    }
}

- (void) setProgressString:(NSString*) string {
    FLSetObjectWithRetain(_progressString, string);
    
    if(_progressTextField) {
        _progressTextField.stringValue = string;
    }
}

- (void) startProgress {
//    _spinner.hidden = NO;
//    _progressBar.hidden = YES;
//    [_spinner startAnimation:self];

    _progressBar.hidden = NO;
    [_progressBar setIndeterminate:YES];
    [_progressBar startAnimation:self];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    _progressTextField.stringValue = _progressString;
    [self startProgress];
}

- (void) setValue:(CGFloat) value total:(CGFloat) total {
    [_progressBar setIndeterminate:NO];
    [_progressBar setMinValue:0];
    [_progressBar setMaxValue:total];
    [_progressBar setDoubleValue:value];
}

- (void) incrementValue {
    [_progressBar incrementBy:1];
}


@end
