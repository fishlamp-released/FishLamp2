//
//	FLEmptyCacheOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/20/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

#import "FLSynchronousOperation.h"

@interface FLEmptyCacheOperation : FLSynchronousOperation {
}

+ (FLEmptyCacheOperation*) emptyCacheOperation;

@end
