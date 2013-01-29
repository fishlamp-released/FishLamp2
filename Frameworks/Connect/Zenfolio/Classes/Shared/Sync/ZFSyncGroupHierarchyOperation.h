//
//  ZFSyncGroupHierarchyOperation.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "ZFPhotoSet.h"
#import "FLUserLogin.h"

@interface ZFSyncGroupHierarchyOperation : FLOperation {
@private    
    int _downloadedPhotoSetCount;
    int _totalPhotoSetCount;
    FLUserLogin* _userLogin;
}
- (id) initWithUserLogin:(FLUserLogin*) userLogin;
+ (id) syncGroupHierarchyOperation:(FLUserLogin*) userLogin;

@property (readonly, assign) int downloadedPhotoSetCount;
@property (readonly, assign) int totalPhotoSetCount;

@end

@protocol  ZFSyncGroupHierarchyObserver <NSObject>
@optional
- (void) syncGroupHierarchy:(ZFSyncGroupHierarchyOperation*) operation willDownloadGroupListForUser:(FLUserLogin*) login;
- (void) syncGroupHierarchy:(ZFSyncGroupHierarchyOperation*) operation didDownloadGroupList:(ZFGroup*) group;

- (void) syncGroupHierarchy:(ZFSyncGroupHierarchyOperation*) operation didDownloadPhotoSet:(ZFPhotoSet*) photoSet; 
@end