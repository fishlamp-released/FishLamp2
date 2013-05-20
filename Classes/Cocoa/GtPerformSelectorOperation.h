//
//	GtPerformSelectorOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOperation.h"
#import "GtCallbackObject.h"

@interface GtPerformSelectorOperation : GtOperation {
@private
	GtCallback m_callback;
}

@property (readwrite, assign, nonatomic) GtCallback callback; // NOT target is retained

- (void) setCallback:(id) target action:(SEL) action; // target is NOT retained

- (id) initWithTarget:(id) target action:(SEL) action; // target is NOT retained

+ (GtPerformSelectorOperation*) performSelectorOperation:(id) target action:(SEL) action; // target is NOT retained

@end
