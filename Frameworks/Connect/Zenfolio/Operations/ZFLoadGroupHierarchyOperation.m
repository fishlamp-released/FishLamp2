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

- (FLResult) runOperation {

    [self sendObservation:@selector(loadGroupHierarchyOperation:willDownloadGroupListForUser:) withObject:_userLogin];

    FLHttpRequest* request = [ZFHttpRequest loadGroupHierarchyHttpRequest:_userLogin.userName];
    FLAssertNotNil(request);

    [self abortIfNeeded];

    ZFGroup* group = FLThrowIfError([self runWorker:request]);
    FLAssertNotNil(group);
    
    [self.objectStorage writeObject:group];

    [self sendObservation:@selector(loadGroupHierarchyOperation:didDownloadGroupList:)  withObject:group];

    ZFDownloadPhotoSetsOperation* downloadPhotosets = [ZFDownloadPhotoSetsOperation downloadPhotoSetsWithGroup:group objectStorage:self.objectStorage];
    
/*    FLResult result =  */
    FLThrowIfError([self runWorker: downloadPhotosets]);
    
    return group;
}

//- (void) photoSetDownloader:(ZFDownloadPhotoSetsOperation*) operation didDownloadPhotoSet:(ZFPhotoSet*) photoSet {
//    [self sendMessage:@"syncGroupHierarchy:didDownloadPhotoSet:" withObject:photoSet];
//}

@end
