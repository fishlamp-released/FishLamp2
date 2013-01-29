//
//  ZFLoadSyncedElementsFromCacheOperation.m
//  ZenLib
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFLoadSyncedElementsFromCacheOperation.h"
#import "ZFUtils.h"
#import "ZFSyncService.h"
#import "ZFCacheService.h"

@interface ZFLoadSyncedElementsFromCacheOperation ()
@end

@implementation ZFLoadSyncedElementsFromCacheOperation

- (FLResult) runOperation {
    NSArray* list = [[self.context syncService] loadAllSyncInfoObjectsFromDatabase];
    
    FLOrderedCollection* result = [FLOrderedCollection orderedCollection];
	for(ZFGroupElementSyncInfo* tgElement in list) {

		[self abortIfNeeded];
        
		if(tgElement.syncObjectId && tgElement.syncObjectId) {
			ZFGroupElement* element = nil;
			if(tgElement.isGroupValue) {
				element = [[self.context cacheService] loadGroupWithID:tgElement.syncObjectIdValue];
				if(!element) {
					element = [ZFGroup group];
					element.Id = tgElement.syncObjectId;
					element.Title = tgElement.name;
				}
			}
			else {
				element = [[self.context cacheService] loadPhotoSetWithID:tgElement.syncObjectIdValue];
				if(!element) {
					element = [ZFPhotoSet photoSet];
					element.Id = tgElement.syncObjectId;
					element.Title = tgElement.name;
					((ZFPhotoSet*) element).TypeValue = ZFPhotoSetTypeGallery;
				}
			}
		
			[result addOrReplaceObject:element forKey:element.Id];
		}
	}
    
    return result;
}

@end