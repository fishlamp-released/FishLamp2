//
//  FLObjectDatabaseController.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/4/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//
#import "FLAsyncQueue.h"
#import "FLDispatch.h"
#import "FLObjectDatabase.h"
#import "FLObjectStorage.h"

typedef void (^FLObjectDatabaseBlock)(FLObjectDatabase* database);

@interface FLObjectDatabaseController : NSObject<FLObjectStorageExtended, FLDatabaseDelegate> {
@private
    FLFifoAsyncQueue* _schedulingQueue;
    FLObjectDatabase* _objectDatabase;
}

- (id) initWithFilePath:(NSString*) filePath;
+ (id) objectDatabaseController:(NSString*) pathToDatabase;

- (FLPromise*) dispatchAsync:(FLObjectDatabaseBlock) block
                  completion:(fl_completion_block_t) block;

- (void) dispatchSync:(FLObjectDatabaseBlock) block;

- (void) openDatabase;
             
@end