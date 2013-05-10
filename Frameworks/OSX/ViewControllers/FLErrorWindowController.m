//
//  FLErrorWindowController.m
//  FishLampOSX
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLErrorWindowController.h"

@interface FLErrorWindowController ()

@end

@implementation FLErrorWindowController
@synthesize okButton = _okButton;

- (id) initWithTitle:(NSString*) title explanation:(NSString*) explanation {	
	self = [super initWithWindowNibName:@"FLErrorWindowController"];
	if(self) {
		_title = FLRetain(title);
        _explanation = FLRetain(explanation);
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
	[_title release];
    [_explanation release];
    [super dealloc];
}
#endif

+ (id) errorWindowController:(NSString*) title explanation:(NSString*) explanation {
    return FLAutorelease([[[self class] alloc] initWithTitle:title explanation:explanation]);
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    _titleField.stringValue = _title;
    _explanationField.stringValue = _explanation;
}


@end
