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


+ (id) syncGroupHierarchyOperation:(FLUserLogin*) userLogin {
    return FLAutorelease([[[self class] alloc] initWithUserLogin:userLogin]);
}

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {

//    [self postObservation:@selector(syncGroupHierarchy:willDownloadGroupListForUser:) withObject:_userLogin];

    FLHttpRequest* request = [FLZenfolioHttpRequest loadGroupHierarchyHttpRequest:_userLogin.userName];
    FLAssertNotNil_(request);

    FLZenfolioGroup* group = [context runWorker:request withObserver:observer];

//    FLZenfolioGroup* group = [self sendHttpRequest:request];

//    [self postObservation:@selector(syncGroupHierarchy:didDownloadGroupList:) withObject:group];

    FLZenfolioDownloadPhotoSetsOperation* downloadPhotosets = [FLZenfolioDownloadPhotoSetsOperation downloadPhotoSetsWithGroup:group];
//    [downloadPhotosets addObserver:self];
    
    FLResult result = [context runWorker:downloadPhotosets withObserver:observer];
    
//    [self runSubOperation:downloadPhotosets];
    
//    [downloadPhotosets removeObserver:self];
    
    return result;
}

//- (void) photoSetDownloader:(FLZenfolioDownloadPhotoSetsOperation*) operation didDownloadPhotoSet:(FLZenfolioPhotoSet*) photoSet {
//    [self postObservation:@selector(syncGroupHierarchy:didDownloadPhotoSet:) withObject:photoSet];
//}

@end
