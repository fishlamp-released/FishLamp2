//
//  FLZfLoadSyncedElementsFromCacheOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfLoadSyncedElementsFromCacheOperation.h"
#import "FLZfUtils.h"
#import "FLZfSyncService.h"
#import "FLZfCacheService.h"

@interface FLZfLoadSyncedElementsFromCacheOperation ()
@end

@implementation FLZfLoadSyncedElementsFromCacheOperation

- (FLResult) runOperation {
    NSArray* list = [[self.context syncService] loadAllSyncInfoObjectsFromDatabase];
    
    FLOrderedCollection* result = [FLOrderedCollection orderedCollection];
	for(FLZfGroupElementSyncInfo* tgElement in list) {

		[self abortIfNeeded];
        
		if(tgElement.syncObjectId && tgElement.syncObjectId) {
			FLZfGroupElement* element = nil;
			if(tgElement.isGroupValue) {
				element = [[self.context cacheService] loadGroupWithID:tgElement.syncObjectIdValue];
				if(!element) {
					element = [FLZfGroup group];
					element.Id = tgElement.syncObjectId;
					element.Title = tgElement.name;
				}
			}
			else {
				element = [[self.context cacheService] loadPhotoSetWithID:tgElement.syncObjectIdValue];
				if(!element) {
					element = [FLZfPhotoSet photoSet];
					element.Id = tgElement.syncObjectId;
					element.Title = tgElement.name;
					((FLZfPhotoSet*) element).TypeValue = FLZfPhotoSetTypeGallery;
				}
			}
		
			[result addOrReplaceObject:element forKey:element.Id];
		}
	}
    
    return result;
}

@end