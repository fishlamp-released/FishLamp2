//
//	FLPerformSelectorOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"
#import "FLOperation.h"
#import "FLCallback.h"

@interface FLPerformSelectorOperation : FLOperation {
@private
	FLCallback _callback;
}

@property (readwrite, assign, nonatomic) FLCallback callback; // NOT target is retained

- (void) setCallback:(id) target action:(SEL) action; // target is NOT retained

- (id) initWithTarget:(id) target action:(SEL) action; // target is NOT retained

+ (FLPerformSelectorOperation*) performSelectorOperation:(id) target action:(SEL) action; // target is NOT retained

@end
