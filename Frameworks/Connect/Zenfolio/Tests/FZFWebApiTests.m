//
//  FLZenfolioWebApiTest.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioWebApiTests.h"
#import "FLZenfolioHttpRequest.h"
#import "FLZenfolioAuthenticator.h"

//@implementation FLZenfolioTestSession
//
//- (id) init {
//    self = [super init];
//    if(self) {
//    }
//    return self;
//}
//@end


@implementation FLZenfolioWebApiTests

- (id) init {
    self = [super init];
    if(self) {
//        self.context = [FLZenfolioUserContext create];

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
    
//    FLZenfolioAuthenticater* operation = [FLZenfolioAuthenticater loginOperation];
//    FLThrowError([operation runSynchronously]);
    
//    FLConfirm_([self.context userService].isAuthenticated);
//    FLConfirm_([self.context userService].userLogin.isAuthenticatedValue);
}

- (void) setupTests {
   FLConfirmNotNil_(self.context);
//   FLConfirmNotNil_(FLZenfolioHttpRequest);
//   
   [self findTestCaseForSelector:@selector(testAuthentication)].priority = FLTestCasePriorityHigh;
}

- (void) testLoadAllGroupsWithOneCall {
//    FLOperation* operation = [FLZenfolioWebService]
}


@end

