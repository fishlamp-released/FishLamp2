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

- (id) initWithUserLogin:(FLUserLogin*) userLogin {
    self = [super init];
    if(self) {
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


+ (id) loadGroupHierarchyOperation:(FLUserLogin*) userLogin {
    return FLAutorelease([[[self class] alloc] initWithUserLogin:userLogin]);
}

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {

    [observer postObservation:@selector(loadGroupHierarchyOperation:willDownloadGroupListForUser:) withObject:self withObject:_userLogin];

    FLHttpRequest* request = [FLZenfolioHttpRequest loadGroupHierarchyHttpRequest:_userLogin.userName];
    FLAssertNotNil_(request);

    [self abortIfNeeded];

    FLZenfolioGroup* group = FLThrowIfError([context runWorker:request withObserver:nil]);

    [observer postObservation:@selector(loadGroupHierarchyOperation:didDownloadGroupList:) withObject:self withObject:group];

    FLZenfolioDownloadPhotoSetsOperation* downloadPhotosets = [FLZenfolioDownloadPhotoSetsOperation downloadPhotoSetsWithGroup:group];
    
/*    FLResult result =  */
    FLThrowIfError([context runWorker:downloadPhotosets withObserver:observer]);
    
    return group;
}

//- (void) photoSetDownloader:(FLZenfolioDownloadPhotoSetsOperation*) operation didDownloadPhotoSet:(FLZenfolioPhotoSet*) photoSet {
//    [self postObservation:@selector(syncGroupHierarchy:didDownloadPhotoSet:) withObject:photoSet];
//}

@end
