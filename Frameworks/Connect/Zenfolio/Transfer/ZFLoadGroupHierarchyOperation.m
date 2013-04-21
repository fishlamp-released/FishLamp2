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

- (FLResult) performSynchronously {

    FLAssertNotNil(self.objectStorage);

    FLHttpRequest* request = [ZFHttpRequestFactory loadGroupHierarchyHttpRequest:_userLogin.userName];
    FLAssertNotNil(request);

    [self abortIfNeeded];

    id group = [self runChildSynchronously:request];
    FLThrowIfError(group);
    
    [self.objectStorage writeObject:group];

    return group;
}

@end
