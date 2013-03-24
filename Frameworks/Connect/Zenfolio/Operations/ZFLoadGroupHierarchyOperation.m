 //
//  ZFLoadGroupHierarchyOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFLoadGroupHierarchyOperation.h"
#import "ZFDownloadPhotoSetsOperation.h"
#import "ZFWebApi.h"

@interface ZFLoadGroupHierarchyOperation ()
@property (readwrite, assign) int downloadedPhotoSetCount;
@property (readwrite, assign) int totalPhotoSetCount;
@end

@implementation ZFLoadGroupHierarchyOperation

@synthesize downloadedPhotoSetCount = _downloadedPhotoSetCount;
@synthesize totalPhotoSetCount = _totalPhotoSetCount;

- (id) initWithUserLogin:(FLUserLogin*) userLogin objectStorage:(id<FLObjectStorage>) objectStorage {
    self = [super initWithObjectStorage:objectStorage];
    if(self) {
        FLAssertNotNil(objectStorage);
        _userLogin = FLRetain(userLogin);
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_userLogin release];
    [super dealloc];
}
#endif


+ (id) loadGroupHierarchyOperation:(FLUserLogin*) userLogin objectStorage:(id<FLObjectStorage>) objectStorage {
    return FLAutorelease([[[self class] alloc] initWithUserLogin:userLogin objectStorage:objectStorage]);
}

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {

    [self sendMessage:@selector(loadGroupHierarchyOperation:willDownloadGroupListForUser:) toListener:observer withObject:_userLogin];

    FLHttpRequest* request = [ZFHttpRequest loadGroupHierarchyHttpRequest:_userLogin.userName];
    FLAssertNotNil(request);

    [self abortIfNeeded];

    ZFGroup* group = FLThrowIfError([context runWorker:request withObserver:nil]);
    FLAssertNotNil(group);
    
    [self.objectStorage writeObject:group];

    [self sendMessage:@selector(loadGroupHierarchyOperation:didDownloadGroupList:) toListener:observer withObject:group];

    ZFDownloadPhotoSetsOperation* downloadPhotosets = [ZFDownloadPhotoSetsOperation downloadPhotoSetsWithGroup:group objectStorage:self.objectStorage];
    
/*    FLResult result =  */
    FLThrowIfError([context runWorker:downloadPhotosets withObserver:observer]);
    
    return group;
}

//- (void) photoSetDownloader:(ZFDownloadPhotoSetsOperation*) operation didDownloadPhotoSet:(ZFPhotoSet*) photoSet {
//    [self sendMessage:@"syncGroupHierarchy:didDownloadPhotoSet:" withObject:photoSet];
//}

@end
