//
//  ZFLoadGroupHierarchyOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"
#import "ZFPhotoSet.h"
#import "FLUserLogin.h"

@interface ZFLoadGroupHierarchyOperation : FLAsyncOperation {
@private    
    FLUserLogin* _userLogin;
}
- (id) initWithCredentials:(FLUserLogin*) userLogin;
+ (id) loadGroupHierarchyOperation:(FLUserLogin*) userLogin;

@end

//@protocol  ZFSyncGroupHierarchyObserver <ZFDownloadPhotoSetsOperationObserver>
//@optional
//- (void) loadGroupHierarchyOperation:(ZFLoadGroupHierarchyOperation*) operation willDownloadGroupListForUser:(FLUserLogin*) login;
//
//- (void) loadGroupHierarchyOperation:(ZFLoadGroupHierarchyOperation*) operation didDownloadGroupList:(ZFGroup*) group;
//
//@end
//
