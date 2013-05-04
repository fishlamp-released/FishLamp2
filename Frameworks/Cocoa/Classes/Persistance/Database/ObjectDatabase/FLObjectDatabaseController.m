//
//  FLObjectDatabaseController.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/4/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectDatabaseController.h"

@interface FLObjectDatabaseController ()
@property (readwrite, strong) FLObjectDatabase* objectDatabase;
@property (readwrite, strong) FLFifoAsyncQueue* schedulingQueue;
@end

@implementation FLObjectDatabaseController
@synthesize objectDatabase = _objectDatabase;
@synthesize schedulingQueue = _schedulingQueue;

- (id) init {
    return [self initWithFilePath:nil];
}

- (id) initWithFilePath:(NSString*) filePath {	
    FLAssertStringIsNotEmpty(filePath);
    
	if(self) {
        _objectDatabase = [[FLObjectDatabase alloc] initWithFilePath:filePath];
        self.schedulingQueue = [FLFifoAsyncQueue fifoAsyncQueue];
	}
	return self;
}

+ (id) objectDatabaseController:(NSString*) pathToDatabase {
    return FLAutorelease([[[self class] alloc] initWithFilePath:pathToDatabase]);
}

#if FL_MRC
- (void) dealloc {
    [_schedulingQueue release];
	[_objectDatabase release];
	[super dealloc];
}
#endif

- (FLPromise*) dispatchAsync:(FLObjectDatabaseBlock) block
                  completion:(fl_completion_block_t) completion {

    block = FLCopyWithAutorelease(block);
    
    // this avoids the block from retain self.
    FLObjectDatabase* database = _objectDatabase;
    
    return [_schedulingQueue queueFinishableBlock:^(FLFinisher *finisher) {
        
        block(database);
        [finisher setFinished];
        
    } completion:completion];
}             

- (void) dispatchSync:(FLObjectDatabaseBlock) block {
    
    block = FLCopyWithAutorelease(block);
    
    // this avoids the block from retain self.
    FLObjectDatabase* database = _objectDatabase;
    
    FLPromisedResult result = [_schedulingQueue finishSync:^(FLFinisher* finisher) {
        block(database);
        [finisher setFinished];
    }];
    
    FLThrowIfError(result);
}

- (void) openDatabase {
    [self dispatchSync:^(FLObjectDatabase* database){
        [database openDatabase];
    }];
}

- (void) closeDatabase {
    [self dispatchSync:^(FLObjectDatabase* database){
        [database closeDatabase];
    }];
}

- (void) writeObject:(id) object {
    [self dispatchSync:^(FLObjectDatabase* database){
        [database writeObject:object];
    }];
}

- (void) writeObjectsInArray:(NSArray*) array {
    [self dispatchSync:^(FLObjectDatabase* database){
        [database writeObjectsInArray:array];
    }];
}

- (id) readObject:(id) inputObject {
    
    __block id outObject = nil;
    [self dispatchSync:^(FLObjectDatabase* database){
        outObject = [database readObject:inputObject];
    }];
    
    return FLRetainWithAutorelease(outObject);
}

- (void) deleteObject:(id) object {
    [self dispatchSync:^(FLObjectDatabase* database){
        [database deleteObject:object];
    }];
}

- (BOOL) containsObject:(id) object {
    __block BOOL outResult = NO;
    [self dispatchSync:^(FLObjectDatabase* database){
        outResult = [database containsObject:object];
    }];
    return outResult;
}

- (NSUInteger) objectCountForClass:(Class) aClass {
    __block NSUInteger outCount = 0;
    [self dispatchSync:^(FLObjectDatabase* database){
        outCount = [database objectCountForClass:aClass];
    }];
    
    return outCount;
}

- (void) deleteAllObjectsForClass:(Class) aClass {
    [self dispatchSync:^(FLObjectDatabase* database){
        [database deleteAllObjectsForClass:aClass];
    }];
}

- (NSArray*) readAllObjectsForClass:(Class) aClass {
    __block NSArray* results = nil;
    [self dispatchSync:^(FLObjectDatabase* database){
        results = [database readAllObjectsForClass:aClass];
    }];
    
    return FLRetainWithAutorelease(results);
}

@end
