//
//  FLAbortException.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"

@interface FLAbortException : NSException {
}
+ (FLAbortException*) abortException;
+ (void) raise;
@end

@interface NSError (FLAbort)
- (BOOL) isAbortError;
+ (id) abortError;
@end

