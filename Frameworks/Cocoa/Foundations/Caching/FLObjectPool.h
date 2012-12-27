//
//  FLObjectPool.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/20/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FLObjectPoolBlock)(id object);
typedef id (^FLObjectPoolFactory)();

@class FLObjectPool;

@interface NSObject (FLObjectPool)
@property (readonly, strong) FLObjectPool* objectPool;
@end

@interface FLObjectPool : NSObject {
@private
    NSMutableArray* _objects;
    NSMutableArray* _requests;
    FLObjectPoolFactory _factory;
}

- (id) initWithObjectFactory:(FLObjectPoolFactory) factory;

+ (id) objectPool;
+ (id) objectPoolWithFactory:(FLObjectPoolFactory) factory;

- (void) requestPooledObject:(FLObjectPoolBlock) block;

- (void) stockPool:(NSArray*) withObjects;

@end

extern void FLReleasePooledObject(id __strong * object);