//
//  ZFUpdateSyncList.m
//  ZenLib
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFPhotoSetStatusSyncOperation.h"
#import "ZFSyncService.h"
#import "FLHttp.h"

@implementation ZFPhotoSetStatusSyncOperation

- (id) performSynchronously {

#if REFACTOR
    [self addBatchObjects:[[context syncService] loadAllSyncInfoObjectsFromDatabase]];
#endif
    
    return [super performSynchronously];
}

#if REFACTOR
- (void) photoSetWasUpdated:(ZFPhotoSet*) newPhotoSet {
    
    [[self.context syncService] elementWasUpdated:newPhotoSet];
//    [self sendMessage:@"syncPhotoSets:photoSetWasUpdated:" withObject:newPhotoSet];
}

- (void) photoSetWasRemoved:(NSNumber*) photoSetID {
    [[self.context syncService] removeElementById:photoSetID];
//    [self sendMessage:@"syncPhotoSets:photoSetWasRemoved:" withObject:photoSetID];
}
#endif

- (void) processBatchObject:(ZFGroupElementSyncInfo*) element {
    
#if REFACTOR
    
    // Groups are synced elsewhere.

    if(!element.isGroupValue) {

        FLHttpRequest* request = [ZFHttpRequestFactory loadPhotoSetHttpRequest:element.syncObjectId];
        
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
    
#endif    
}


@end
