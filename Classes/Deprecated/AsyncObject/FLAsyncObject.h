//
//	FLAsyncObject.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/17/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLCallback_t.h"

typedef void (^FLAsyncObjectBlock)(id block);

@protocol FLAsyncObject <NSObject>
- (void) beginOperation:(FLAsyncObjectBlock) block;
@end