//
//  FLZfWebApiTest.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfWebApiTests.h"
#import "FLZfHttpRequest.h"
#import "FLZfAuthenticator.h"

//@implementation FLZfTestSession
//
//- (id) init {
//    self = [super init];
//    if(self) {
//    }
//    return self;
//}
//@end


@implementation FLZfWebApiTests

- (id) init {
    self = [super init];
    if(self) {
//        self.context = [FLZfUserContext create];

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
    
//    FLZfAuthenticater* operation = [FLZfAuthenticater loginOperation];
//    FLThrowError([operation runSynchronously]);
    
//    FLConfirm_([self.context userService].isAuthenticated);
//    FLConfirm_([self.context userService].userLogin.isAuthenticatedValue);
}

- (void) setupTests {
   FLConfirmNotNil_(self.context);
//   FLConfirmNotNil_(FLZfHttpRequest);
//   
   [self findTestCaseForSelector:@selector(testAuthentication)].priority = FLTestCasePriorityHigh;
}

- (void) testLoadAllGroupsWithOneCall {
//    FLOperation* operation = [FLZfWebService]
}


@end

