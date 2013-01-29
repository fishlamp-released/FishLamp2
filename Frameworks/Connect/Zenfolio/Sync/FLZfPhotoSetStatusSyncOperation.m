//
//  FLZfUpdateSyncList.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfPhotoSetStatusSyncOperation.h"
#import "FLZfSyncService.h"
#import "FLHttpRequest.h"

@implementation FLZfPhotoSetStatusSyncOperation

- (FLResult) runOperation {
    [self addBatchObjects:[[self.context syncService] loadAllSyncInfoObjectsFromDatabase]];
    return [super runOperation];
}

- (void) photoSetWasUpdated:(FLZfPhotoSet*) newPhotoSet {
    
    [[self.context syncService] elementWasUpdated:newPhotoSet];
//    [self postObservation:@selector(syncPhotoSets:photoSetWasUpdated:) withObject:newPhotoSet];
}

- (void) photoSetWasRemoved:(NSNumber*) photoSetID {
    [[self.context syncService] removeElementById:photoSetID];
//    [self postObservation:@selector(syncPhotoSets:photoSetWasRemoved:) withObject:photoSetID];
}

- (void) processBatchObject:(FLZfGroupElementSyncInfo*) element {
    
    // Groups are synced elsewhere.

    if(!element.isGroupValue) {

        FLHttpRequest* request = [FLZfHttpRequest loadPhotoSetHttpRequest:element.syncObjectId];
        
        @try {
            [self photoSetWasUpdated:FLConfirmResultType([request sendSynchronouslyInContext:self.context], FLZfPhotoSet)];
        }
        @catch(NSException* ex) {
            if(ex.error.zenfolioErrorCode == FLZfErrorCodeNoSuchObject) {
                [self photoSetWasRemoved:element.syncObjectId];
            }
            else {
                @throw;
            }
        }
    }
}


@end
