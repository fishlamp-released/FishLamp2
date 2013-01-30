//
//  FLZenfolioLoadSyncedElementsFromCacheOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioLoadSyncedElementsFromCacheOperation.h"
#import "FLZenfolioUtils.h"
#import "FLZenfolioSyncService.h"
#import "FLZenfolioCacheService.h"

@interface FLZenfolioLoadSyncedElementsFromCacheOperation ()
@end

@implementation FLZenfolioLoadSyncedElementsFromCacheOperation

- (FLResult) runOperation {
    NSArray* list = [[self.context syncService] loadAllSyncInfoObjectsFromDatabase];
    
    FLOrderedCollection* result = [FLOrderedCollection orderedCollection];
	for(FLZenfolioGroupElementSyncInfo* tgElement in list) {

		[self abortIfNeeded];
        
		if(tgElement.syncObjectId && tgElement.syncObjectId) {
			FLZenfolioGroupElement* element = nil;
			if(tgElement.isGroupValue) {
				element = [[self.context cacheService] loadGroupWithID:tgElement.syncObjectIdValue];
				if(!element) {
					element = [FLZenfolioGroup group];
					element.Id = tgElement.syncObjectId;
					element.Title = tgElement.name;
				}
			}
			else {
				element = [[self.context cacheService] loadPhotoSetWithID:tgElement.syncObjectIdValue];
				if(!element) {
					element = [FLZenfolioPhotoSet photoSet];
					element.Id = tgElement.syncObjectId;
					element.Title = tgElement.name;
					((FLZenfolioPhotoSet*) element).TypeValue = FLZenfolioPhotoSetTypeGallery;
				}
			}
		
			[result addOrReplaceObject:element forKey:element.Id];
		}
	}
    
    return result;
}

@end