//
//	FLEmptyCacheOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLSynchronousOperation.h"

@interface FLEmptyCacheOperation : FLSynchronousOperation {
}

+ (FLEmptyCacheOperation*) emptyCacheOperation;

@end
