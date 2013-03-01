//
//  FLZenfolioLoadGroupHierarchyOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "FLZenfolioPhotoSet.h"
#import "FLUserLogin.h"
#import "FLZenfolioDownloadPhotoSetsOperation.h"

@interface FLZenfolioLoadGroupHierarchyOperation : FLOperation {
@private    
    int _downloadedPhotoSetCount;
    int _totalPhotoSetCount;
    FLUserLogin* _userLogin;
}
- (id) initWithUserLogin:(FLUserLogin*) userLogin;
+ (id) loadGroupHierarchyOperation:(FLUserLogin*) userLogin;

@property (readonly, assign) int downloadedPhotoSetCount;
@property (readonly, assign) int totalPhotoSetCount;

@end

@protocol  FLZenfolioSyncGroupHierarchyObserver <FLZenfolioDownloadPhotoSetsOperationObserver>
@optional
- (void) loadGroupHierarchyOperation:(FLZenfolioLoadGroupHierarchyOperation*) operation willDownloadGroupListForUser:(FLUserLogin*) login;

- (void) loadGroupHierarchyOperation:(FLZenfolioLoadGroupHierarchyOperation*) operation didDownloadGroupList:(FLZenfolioGroup*) group;

@end