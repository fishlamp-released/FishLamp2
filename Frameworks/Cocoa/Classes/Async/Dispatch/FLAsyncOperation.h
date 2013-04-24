//
//  FLAsyncOperation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"

@interface FLAsyncOperation : FLOperation {
@private
    FLFinisher* _finisher;
}
@property (readwrite, strong) FLFinisher* finisher; 

- (void) setFinishedWithResult:(id) result;
- (void) setFinished;
- (void) setFinishedWithCancelResult;

- (void) startAsyncOperation;
@end
