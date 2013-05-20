//
//	ZfLoadUploadQueueThumbnail.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/31/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOperation.h"
#import "GtObjectDatabase.h"

@interface GtSaveObjectToDatabaseOperation : GtOperation {
@private
	GtObjectDatabase* m_database;
}

- (id) initWithDatabaseObjectInput:(GtObjectDatabase*) database input:(id) input;

@end
