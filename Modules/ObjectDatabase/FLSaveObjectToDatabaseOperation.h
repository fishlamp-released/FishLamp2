//
//	ZfLoadUploadQueueThumbnail.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/31/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCocoa.h"

#import "FLOperation.h"
#import "FLObjectDatabase.h"

@interface FLSaveObjectToDatabaseOperation : FLOperation {
@private
	FLObjectDatabase* _database;
}

- (id) initWithDatabaseObjectInput:(FLObjectDatabase*) database input:(id) input;

@end
