//
//	FLSaveObjectToDatabaseOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/31/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"

#import "FLSynchronousOperation.h"
#import "FLDatabase.h"

@interface FLSaveObjectToDatabaseOperation : FLSynchronousOperation {
@private
	FLDatabase* _database;
    id _input;
}

- (id) initWithDatabaseObjectInput:(FLDatabase*) database input:(id) input;

@end
