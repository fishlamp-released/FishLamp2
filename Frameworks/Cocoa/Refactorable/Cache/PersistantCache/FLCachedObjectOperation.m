//
//	FLCachedObjectOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/27/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCachedObjectOperation.h"
#import "FLPerformSelectorOperation.h"
#import "FLObjectDatabase.h"

@interface FLCachedObjectOperation ()
@property (readwrite, assign) BOOL wasLoadedFromCache;
@end

@implementation FLCachedObjectOperation
@synthesize canSaveToCache = _canSaveToCache;
@synthesize canLoadFromCache = _canLoadFromCache;
@synthesize wasLoadedFromCache = _wasLoadedFromCache;
@synthesize alwaysRunSubOperations = _alwaysRunSubOperations;

- (id) init {
	if((self = [super init])) {
        FLAssertWithComment([self conformsToProtocol:@protocol(FLCacheObjectOperationSubclass)], @"subclass must implement FLCacheObjectOperationSubclass protocol");
    
        self.canLoadFromCache = YES;
        self.canSaveToCache = YES;
    }

	return self;
}

- (id) runSubOperations {
    return [NSError failedResultError];
}

- (id) loadObjectFromDatabase {
    return nil;
}

- (void) saveObjectToDatabase:(id) object {
}

- (id) performSynchronously {
    id object = nil;
    
	if(self.canLoadFromCache) {
		object = [self loadObjectFromDatabase];
        
        if(object) {
        	self.wasLoadedFromCache = YES;
 //           [self sendMessage:@"cachedObjectOperation:didLoadObjectFromDatabase:" withObject:object];
        }
	}
	
    if(!object || self.alwaysRunSubOperations) {
		self.wasLoadedFromCache = NO;
	
        object = [self runSubOperations];
        FLThrowIfError(object);

        if(self.canSaveToCache) {
            [self saveObjectToDatabase:object];
        }
	}
    
   return object;
}



@end
