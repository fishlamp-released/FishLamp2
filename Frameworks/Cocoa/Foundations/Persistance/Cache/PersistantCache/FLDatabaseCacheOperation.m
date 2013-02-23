//
//	FLQueuedCachedOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLDatabaseCacheOperation.h"

@implementation FLDatabaseCacheOperation

- (id) initWithObjectAndOperationType:(FLDatabase*) database
                                input:(id) input 
                            operation:(FLCacheOperationType) operation
{
	if((self = [super init]))
	{
		FLAssertIsNotNil_v(database, nil);
		FLAssertIsNotNil_v(input, nil);
		
        _database = FLRetain(database);
        _input = FLRetain(input);
		_operationType = operation;
	}
	
	return self;
}

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
    FLResult result = FLSuccessfullResult;
	
    switch(_operationType)
    {
        case gtLoadFromCacheOperation:
            result = [_database readObject:_input];
            break;

        case gtSaveToCacheOperation:
            [_database writeObject:_input];
            break;

        case gtDeleteFromCacheOperation:
            [_database deleteObject:_input];
            break;
            
            
        case gtLoadFromDatabaseOperation:
        case gtSaveToDatabaseOperation:
        case gtDeleteFromDatabase:
            FLAssertFailed_v(@"not implemented");
            break;
            
    }
	
    return result;
}

#if FL_MRC
- (void) dealloc {
    [_database release];
    [_input release];
    [super dealloc];
}
#endif

@end
