//
//  FLDeallocNotifier.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"
#import "FLCallback.h"


// EXPERIMENTAL

@interface FLDeallocNotifier : NSObject {
@private
    FLCallback _callback;
}
- (id) initWithTarget:(id) target action:(SEL) action;
+ (FLDeallocNotifier*) deallocNotifier:(id) target action:(SEL) action;
@end

@interface NSObject (FLDeallocNotifier)
- (void) addDeallocNotifier:(FLDeallocNotifier*) notifier;
@end