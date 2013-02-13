//
//  FLAsyncWorkerContext.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLFinisher.h"
#import "FLDispatcher.h"

typedef void (^FLDispatchableObjectVisitor)(id object, BOOL* stop);

@interface FLAsyncWorkerContext : NSObject {
@private
    NSCountedSet* _objects;
    FLDispatcher* _dispatcher;
}

@property (readwrite, strong, nonatomic) FLDispatcher* dispatcher;

+ (id) context;

- (void) requestCancel;

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor
                  completion:(FLBlockWithResult) completion;

- (FLFinisher*) visitObjects:(FLDispatchableObjectVisitor) visitor;

- (void) addObject:(id) object;

- (void) removeObject:(id) object;

@end

