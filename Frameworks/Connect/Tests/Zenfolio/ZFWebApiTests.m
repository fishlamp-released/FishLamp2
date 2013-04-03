//
//  ZFWebApiTest.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFWebApiTests.h"
#import "ZFWebApi.h"
#import "ZFChallengeResponseAuthenticationOperation.h"

//@implementation ZFTestSession
//
//- (id) init {
//    self = [super init];
//    if(self) {
//    }
//    return self;
//}
//@end


@implementation ZFWebApiTests

- (id) init {
    self = [super init];
    if(self) {
//        self.context = [ZFUserService create];

//        FLUserLogin* user = [FLUserLogin userLogin];
//        user.userName = @"zentester";
//        user.password = @"z3nf0li0";
//        [self.context setUserLogin: user];
    }   

    return self;
}

- (BOOL) willRunTests {
    return YES;
}

- (void) testAuthentication {
    
//    ZFAuthenticater* operation = [ZFAuthenticater loginOperation];
//    FLThrowIfError([operation runChildSynchronously]);
    
//    FLConfirm([self.context userService].isAuthenticated);
//    FLConfirm([self.context userService].userLogin.isAuthenticatedValue);
}

- (void) setupTests {
//   FLConfirmNotNil(self.userContext);
//   FLConfirmNotNil(ZFHttpRequest);
//   
   [self findTestCaseForSelector:@selector(testAuthentication)].priority = FLTestCasePriorityHigh;
}

- (void) testLoadAllGroupsWithOneCall {
//    FLSynchronousOperation* operation = [ZFWebService]
}


@end

