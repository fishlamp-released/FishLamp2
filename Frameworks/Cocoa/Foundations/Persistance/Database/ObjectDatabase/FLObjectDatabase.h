//
//	FLObjectDatabase.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCore.h"
#import "FLDatabase.h"

#import "FLService.h"

typedef enum {
    FLObjectDatabaseEventHintNone,
    FLObjectDatabaseEventHintLoaded,
    FLObjectDatabaseEventHintSaved
} FLObjectDatabaseEventHint;


@interface FLObjectDatabase : FLDatabase<FLObjectStorageExtended> {
}

- (id) initWithDefaultName:(NSString*) directory; // eg appname.sqlite
- (id) initWithName:(NSString*) fileName directory:(NSString*) directory;

- (id) loadObjectFromMemoryCache:(id) inputObject;


@end


//#import "FLAsyncJob.h"
//
//@interface FLObjectDatabase (FLAsyncJob) 
//- (void) readObject:(id) inputObject 
//   withEventHandler:(FLAsyncJob*) handler;
//@end
