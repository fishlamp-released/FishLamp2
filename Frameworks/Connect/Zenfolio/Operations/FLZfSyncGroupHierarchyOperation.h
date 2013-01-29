//
//  FLZfSyncGroupHierarchyOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "FLZfPhotoSet.h"
#import "FLUserLogin.h"

@interface FLZfSyncGroupHierarchyOperation : FLOperation {
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

@protocol  FLZfSyncGroupHierarchyObserver <NSObject>
@optional
- (void) syncGroupHierarchy:(FLZfSyncGroupHierarchyOperation*) operation willDownloadGroupListForUser:(FLUserLogin*) login;
- (void) syncGroupHierarchy:(FLZfSyncGroupHierarchyOperation*) operation didDownloadGroupList:(FLZfGroup*) group;

- (void) syncGroupHierarchy:(FLZfSyncGroupHierarchyOperation*) operation didDownloadPhotoSet:(FLZfPhotoSet*) photoSet; 
@end