//
//  FLTwoColumnWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTwoColumnWidget.h"


@implementation FLTwoColumnWidget

@synthesize leftColumn = _leftColumn;
@synthesize rightColumn = _rightColumn;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
// init left column
		_leftColumn = [[FLWidget alloc] initWithFrame:frame];
		[self addWidget:_leftColumn];

		_rightColumn = [[FLWidget alloc] initWithFrame:frame];
		[self addWidget:_rightColumn];
	}
	
	return self;
}

- (void) layoutSubWidgets
{
    [super layoutSubWidgets];
    
    CGRect bounds = self.frame;
    bounds.size.width *= 0.5f;
    
    _leftColumn.frameOptimizedForSize = bounds;
    bounds.origin.x += bounds.size.width;
	_rightColumn.frameOptimizedForSize = bounds;
		
}

- (void) dealloc
{
	FLRelease(_leftColumn);
	FLRelease(_rightColumn);
	FLSuperDealloc();
}
@end
