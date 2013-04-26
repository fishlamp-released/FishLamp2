 //
//  ZFLoadGroupHierarchyOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFLoadGroupHierarchyOperation.h"
#import "ZFWebApi.h"

@interface ZFLoadGroupHierarchyOperation ()
@end

@implementation ZFLoadGroupHierarchyOperation

- (id) initWithCredentials:(FLUserLogin*) userLogin {
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
    return FLAutorelease([[[self class] alloc] initWithCredentials:userLogin]);
}

- (id) startAsyncOperation {

    FLAssertNotNil(self.storageService);

    FLHttpRequest* request = [ZFHttpRequestFactory loadGroupHierarchyHttpRequest:_userLogin.userName];
    FLAssertNotNil(request);

    [self runChildAsynchronously:request completion:^(id<FLAsyncResult> result) {
        if(![result error]) {
            ZFGroup* group = result.returnedObject;
            [self.storageService writeObject:group];
        }
        
        [self setFinishedWithResult:result];
    }];
    
    return nil;
}

- (void) sendStartMessagesWithInitialData:(id) initialData {
    [self sendObservation:@selector(willDownloadRootGroup)];
}

- (void) sendFinishMessagesWithResult:(id<FLAsyncResult>) result {
        FLPerformSelector2(self.delegate, 
        @selector(loadGroupHierarchyOperation:didLoadRootGroupWithResult:), 
        self, 
        result);
    [self sendObservation:@selector(didDownloadRootGroupWithResult:) withObject:result];
}



@end
