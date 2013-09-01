//
//  FLNotifier.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLNotifier.h"
#import "FLBroadcaster.h"

@implementation FLNotifier 

FLSynthesizeNotifierProperties(_notifier);

#if FL_MRC
- (void)dealloc {
	[_notifier release];
	[super dealloc];
}
#endif

@end
