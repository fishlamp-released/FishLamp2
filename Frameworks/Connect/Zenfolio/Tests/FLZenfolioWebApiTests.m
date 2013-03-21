//
//  FLZenfolioWebApiTest.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioWebApiTests.h"
#import "FLZenfolioWebApi.h"
#import "FLZenfolioChallengeResponseAuthenticationOperation.h"

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
//        self.context = [FLZenfolioUserService create];

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
//    FLThrowIfError([operation runWorker]);
    
//    FLConfirm([self.context userService].isAuthenticated);
//    FLConfirm([self.context userService].userLogin.isAuthenticatedValue);
}

- (void) setupTests {
//   FLConfirmNotNil(self.userContext);
//   FLConfirmNotNil(FLZenfolioHttpRequest);
//   
   [self findTestCaseForSelector:@selector(testAuthentication)].priority = FLTestCasePriorityHigh;
}

- (void) testLoadAllGroupsWithOneCall {
//    FLOperation* operation = [FLZenfolioWebService]
}


@end

