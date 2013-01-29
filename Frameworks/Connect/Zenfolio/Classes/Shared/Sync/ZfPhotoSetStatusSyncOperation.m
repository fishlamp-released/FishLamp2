//
//  ZFUpdateSyncList.m
//  ZenLib
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFPhotoSetStatusSyncOperation.h"
#import "ZFSyncService.h"
#import "FLHttpRequest.h"

@implementation ZFPhotoSetStatusSyncOperation

- (FLResult) runOperation {
    [self addBatchObjects:[[self.context syncService] loadAllSyncInfoObjectsFromDatabase]];
    return [super runOperation];
}

- (void) photoSetWasUpdated:(ZFPhotoSet*) newPhotoSet {
    
    [[self.context syncService] elementWasUpdated:newPhotoSet];
//    [self postObservation:@selector(syncPhotoSets:photoSetWasUpdated:) withObject:newPhotoSet];
}

- (void) photoSetWasRemoved:(NSNumber*) photoSetID {
    [[self.context syncService] removeElementById:photoSetID];
//    [self postObservation:@selector(syncPhotoSets:photoSetWasRemoved:) withObject:photoSetID];
}

- (void) processBatchObject:(ZFGroupElementSyncInfo*) element {
    
    // Groups are synced elsewhere.

    if(!element.isGroupValue) {

        FLHttpRequest* request = [ZFHttpRequest loadPhotoSetHttpRequest:element.syncObjectId];
        
        @try {
            [self photoSetWasUpdated:FLConfirmResultType([request sendSynchronouslyInContext:self.context], ZFPhotoSet)];
        }
        @catch(NSException* ex) {
            if(ex.error.zenfolioErrorCode == ZFErrorCodeNoSuchObject) {
                [self photoSetWasRemoved:element.syncObjectId];
            }
            else {
                @throw;
            }
        }
    }
}


@end
