//
//  FLDispatchable.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLDispatchTypes.h"

@interface FLDispatchable : NSObject {
@private
    FLFinisher* _finisher;
    FLBlock _block;
    FLBlockWithFinisher _finishableBlock;
    id _object;
}

+ (id) dispatchable:(FLFinisher*) finisher;
+ (id) dispatchable;

@property (readwrite, strong, nonatomic) FLFinisher* finisher;
@property (readwrite, copy, nonatomic) FLBlock block;
@property (readwrite, copy, nonatomic) FLBlockWithFinisher finishableBlock;
@property (readwrite, strong, nonatomic) id object;

- (void) dispatch:(id<FLDispatcher>) dispatcher;

@end

