 //
//  FLZenfolioLoadGroupHierarchyOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioLoadGroupHierarchyOperation.h"
#import "FLZenfolioDownloadPhotoSetsOperation.h"
#import "FLZenfolioWebApi.h"

@interface FLZenfolioLoadGroupHierarchyOperation ()
@property (readwrite, assign) int downloadedPhotoSetCount;
@property (readwrite, assign) int totalPhotoSetCount;
@end

@implementation FLZenfolioLoadGroupHierarchyOperation

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

    FLHttpRequest* request = [FLZenfolioHttpRequest loadGroupHierarchyHttpRequest:_userLogin.userName];
    FLAssertNotNil(request);

    [self abortIfNeeded];

    FLZenfolioGroup* group = FLThrowIfError([context runWorker:request withObserver:nil]);
    FLAssertNotNil(group);
    
    [self.objectStorage writeObject:group];

    [self sendMessage:@selector(loadGroupHierarchyOperation:didDownloadGroupList:) toListener:observer withObject:group];

    FLZenfolioDownloadPhotoSetsOperation* downloadPhotosets = [FLZenfolioDownloadPhotoSetsOperation downloadPhotoSetsWithGroup:group objectStorage:self.objectStorage];
    
/*    FLResult result =  */
    FLThrowIfError([context runWorker:downloadPhotosets withObserver:observer]);
    
    return group;
}

//- (void) photoSetDownloader:(FLZenfolioDownloadPhotoSetsOperation*) operation didDownloadPhotoSet:(FLZenfolioPhotoSet*) photoSet {
//    [self sendMessage:@"syncGroupHierarchy:didDownloadPhotoSet:" withObject:photoSet];
//}

@end
