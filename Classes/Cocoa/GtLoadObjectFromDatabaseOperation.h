//
//	ZfLoadUploadQueueThumbnail.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/31/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOperation.h"
#import "GtObjectDatabase.h"

@interface GtLoadObjectFromDatabaseOperation : GtOperation {
@private
	GtObjectDatabase* m_database;
}

- (id) initWithCacheableObjectInput:(GtObjectDatabase*) database 
							  input:(id) input;

@end
