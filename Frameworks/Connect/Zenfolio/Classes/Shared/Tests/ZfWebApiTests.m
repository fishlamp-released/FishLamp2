//
//  ZFWebApiTest.m
//  ZenLib
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFWebApiTests.h"
#import "ZFHttpRequest.h"
#import "ZFAuthenticator.h"

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
//        self.context = [ZFUserContext create];

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
//    FLThrowError([operation runSynchronously]);
    
//    FLConfirm_([self.context userService].isAuthenticated);
//    FLConfirm_([self.context userService].userLogin.isAuthenticatedValue);
}

- (void) setupTests {
   FLConfirmNotNil_(self.context);
//   FLConfirmNotNil_(ZFHttpRequest);
//   
   [self findTestCaseForSelector:@selector(testAuthentication)].priority = FLTestCasePriorityHigh;
}

- (void) testLoadAllGroupsWithOneCall {
//    FLOperation* operation = [ZFWebService]
}


@end

