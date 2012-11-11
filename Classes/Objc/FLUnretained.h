//
//  FLUnretained.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FishLampCore.h"
#import "FLSimpleNotifier.h"
#import "FLWeakReference.h"

@interface FLUnretained : NSProxy {
@private
	FLWeakReference* _weakRef;
	__unsafe_unretained id _deadObject;
}
@property (readonly, strong) FLSimpleNotifier* notifier;
@property (readwrite, assign) id object;
- (id) initWithObject:(id) object;
+ (id) unretained:(id) object;
@end

@interface NSObject (FLUnretained)
- (id) unretained;
@end