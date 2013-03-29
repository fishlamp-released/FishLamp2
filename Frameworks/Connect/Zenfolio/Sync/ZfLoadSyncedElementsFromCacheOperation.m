//
//  ZFLoadSyncedElementsFromCacheOperation.m
//  ZenLib
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFLoadSyncedElementsFromCacheOperation.h"

#import "ZFSyncService.h"
#import "ZFCacheService.h"

@interface ZFLoadSyncedElementsFromCacheOperation ()
@end

@implementation ZFLoadSyncedElementsFromCacheOperation

- (FLResult) performSynchronously {

#if REFACTOR    
    NSArray* list = [[context syncService] loadAllSyncInfoObjectsFromDatabase];
    
    FLOrderedCollection* result = [FLOrderedCollection orderedCollection];
	for(ZFGroupElementSyncInfo* tgElement in list) {

		[self abortIfNeeded];
        
		if(tgElement.syncObjectId && tgElement.syncObjectId) {
			ZFGroupElement* element = nil;
			if(tgElement.isGroupValue) {
				element = [[context cacheService] loadGroupWithID:tgElement.syncObjectIdValue];
				if(!element) {
					element = [ZFGroup group];
					element.Id = tgElement.syncObjectId;
					element.Title = tgElement.name;
				}
			}
			else {
				element = [[context cacheService] loadPhotoSetWithID:tgElement.syncObjectIdValue];
				if(!element) {
					element = [ZFPhotoSet photoSet];
					element.Id = tgElement.syncObjectId;
					element.Title = tgElement.name;
					((ZFPhotoSet*) element).TypeValue = ZFPhotoSetTypeGallery;
				}
			}
		
			[result setObject:element forKey:element.Id];
		}
	}
    
    return result;
#endif
        
    return nil;
}

@end