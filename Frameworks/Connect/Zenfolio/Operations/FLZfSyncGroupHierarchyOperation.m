 //
//  FLZfSyncGroupHierarchyOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfSyncGroupHierarchyOperation.h"
#import "FLZfDownloadPhotoSetsOperation.h"
#import "FLZfHttpRequest.h"

@interface FLZfSyncGroupHierarchyOperation ()
@property (readwrite, assign) int downloadedPhotoSetCount;
@property (readwrite, assign) int totalPhotoSetCount;
@end

@implementation FLZfSyncGroupHierarchyOperation

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

- (FLResult) runOperation {

    FLAssertNotNil_(self.context);

//    [self postObservation:@selector(syncGroupHierarchy:willDownloadGroupListForUser:) withObject:_userLogin];

    FLHttpRequest* request = [FLZfHttpRequest loadGroupHierarchyHttpRequest:_userLogin.userName];
    FLAssertNotNil_(request);

    FLZfGroup* group = [request sendSynchronouslyInContext:self.context];

//    [self postObservation:@selector(syncGroupHierarchy:didDownloadGroupList:) withObject:group];

    FLZfDownloadPhotoSetsOperation* downloadPhotosets = [FLZfDownloadPhotoSetsOperation downloadPhotoSetsWithGroup:group];
//    [downloadPhotosets addObserver:self];
    
    FLResult result = [downloadPhotosets runSynchronouslyInContext:self.context];
    
//    [downloadPhotosets removeObserver:self];
    
    return result;
}

//- (void) photoSetDownloader:(FLZfDownloadPhotoSetsOperation*) operation didDownloadPhotoSet:(FLZfPhotoSet*) photoSet {
//    [self postObservation:@selector(syncGroupHierarchy:didDownloadPhotoSet:) withObject:photoSet];
//}

@end
