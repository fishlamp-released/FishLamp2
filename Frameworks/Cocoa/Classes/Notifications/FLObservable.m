//
//  FLObservable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObservable.h"

@implementation FLObservable 

- (void) sendObjectMessage:(FLObjectMessage*) message toListener:(id) listener {
    dispatch_async(dispatch_get_main_queue(), ^{
        [listener receiveObjectMessage:message];
    });
}

@end