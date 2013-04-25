//
//  FLAsyncOperation.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"

@interface FLAsyncOperation : FLOperation<FLFinishable> {
@private
    FLFinisher* _finisher;
    id _threadID;
}
@property (readonly, strong) id threadID;
@property (readwrite, strong) FLFinisher* finisher; 

- (id) startAsyncOperation;
@end
