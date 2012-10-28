//
//  FLRandom.h
//  fBee
//
//  Created by Mike Fullerton on 5/21/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"

#define FLSetRandomSeed() srandom(time(NULL))

NS_INLINE
NSUInteger FLRandomInt(NSUInteger min, NSUInteger max) {
	return min + (NSUInteger) random() % ((max+1) - min);
}


NS_INLINE
BOOL FLGetRandomBool() {
	return FLRandomInt(0, 100) > 50 ? YES : NO;
}
