//
//	FLLoadObjectFromDatabaseOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/31/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FLCore.h"

#import "FLOperation.h"
#import "FLDatabase.h"

@interface FLLoadObjectFromDatabaseOperation : FLOperation {
@private
	FLDatabase* _database;
    id _input;
}

- (id) initWithCacheableObjectInput:(FLDatabase*) database 
							  input:(id) input;

@end
