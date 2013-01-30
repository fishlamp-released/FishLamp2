//
//  FLZenfolioUpdateSyncList.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioPhotoSetStatusSyncOperation.h"
#import "FLZenfolioSyncService.h"
#import "FLHttpRequest.h"
#import "FLZenfolioHttpRequest.h"

@implementation FLZenfolioPhotoSetStatusSyncOperation

- (FLResult) runOperation {
    [self addBatchObjects:[[self.context syncService] loadAllSyncInfoObjectsFromDatabase]];
    return [super runOperation];
}

- (void) photoSetWasUpdated:(FLZenfolioPhotoSet*) newPhotoSet {
    
    [[self.context syncService] elementWasUpdated:newPhotoSet];
//    [self postObservation:@selector(syncPhotoSets:photoSetWasUpdated:) withObject:newPhotoSet];
}

- (void) photoSetWasRemoved:(NSNumber*) photoSetID {
    [[self.context syncService] removeElementById:photoSetID];
//    [self postObservation:@selector(syncPhotoSets:photoSetWasRemoved:) withObject:photoSetID];
}

- (void) processBatchObject:(FLZenfolioGroupElementSyncInfo*) element {
    
    // Groups are synced elsewhere.

    if(!element.isGroupValue) {

        FLHttpRequest* request = [FLZenfolioHttpRequest loadPhotoSetHttpRequest:element.syncObjectId];
        
        @try {
            [self photoSetWasUpdated:FLConfirmResultType([request sendSynchronouslyInContext:self.context], FLZenfolioPhotoSet)];
        }
        @catch(NSException* ex) {
            if(ex.error.zenfolioErrorCode == FLZenfolioErrorCodeNoSuchObject) {
                [self photoSetWasRemoved:element.syncObjectId];
            }
            else {
                @throw;
            }
        }
    }
}


@end
