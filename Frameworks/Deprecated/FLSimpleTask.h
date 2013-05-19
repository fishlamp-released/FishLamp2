//
//	FLSimpleTask.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

@interface FLSimpleTask : NSObject {
	id	_target;
	SEL _backgroundAction;
	SEL _foregroundAction;
}

- (void) beginTaskOnQueue:(NSOperationQueue*) queue 
	target :(id) target 
	backgroundAction:(SEL) backgroundAction 
	foregroundAction:(SEL) foregroundAction;

@end
