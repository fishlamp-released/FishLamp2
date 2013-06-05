//
//  FLActionContextWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/18/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLActionWidget.h"


@implementation FLActionWidget

@synthesize actionContext = _operationContext; 

- (FLAction*) action {
	return _action.object;
}

- (void) setAction:(FLAction*) action {
	_action.object = action;
}

- (id) initWithFrame:(CGRect) frame {
	if((self = [super initWithFrame:frame])) {
		_action = [[FLWeakReference alloc] init];
	}
	
	return self;
}

- (void) dealloc {
	FLRelease(_action);
	FLRelease(_operationContext);
	FLSuperDealloc();
}
@end
