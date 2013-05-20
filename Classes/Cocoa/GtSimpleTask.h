//
//	GtSimpleTask.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>


@interface GtSimpleTask : NSObject {
	id	m_target;
	SEL m_backgroundAction;
	SEL m_foregroundAction;
}

- (void) beginTaskOnQueue:(NSOperationQueue*) queue 
	target :(id) target 
	backgroundAction:(SEL) backgroundAction 
	foregroundAction:(SEL) foregroundAction;

@end
