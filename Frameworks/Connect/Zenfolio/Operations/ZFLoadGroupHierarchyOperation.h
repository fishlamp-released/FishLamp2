//
//  ZFLoadGroupHierarchyOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "ZFPhotoSet.h"
#import "FLUserLogin.h"
#import "ZFDownloadPhotoSetsOperation.h"

@interface ZFLoadGroupHierarchyOperation : FLOperation {
@private    
    int _downloadedPhotoSetCount;
    int _totalPhotoSetCount;
    FLUserLogin* _userLogin;
}
- (id) initWithUserLogin:(FLUserLogin*) userLogin objectStorage:(id<FLObjectStorage>) objectStorage;
+ (id) loadGroupHierarchyOperation:(FLUserLogin*) userLogin objectStorage:(id<FLObjectStorage>) objectStorage;

@property (readonly, assign) int downloadedPhotoSetCount;
@property (readonly, assign) int totalPhotoSetCount;

@end

@protocol  ZFSyncGroupHierarchyObserver <ZFDownloadPhotoSetsOperationObserver>
@optional
- (void) loadGroupHierarchyOperation:(ZFLoadGroupHierarchyOperation*) operation willDownloadGroupListForUser:(FLUserLogin*) login;

- (void) loadGroupHierarchyOperation:(ZFLoadGroupHierarchyOperation*) operation didDownloadGroupList:(ZFGroup*) group;

@end