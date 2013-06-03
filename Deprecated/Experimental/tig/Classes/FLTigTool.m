//
//  FLTigTool.m
//  TigTool
//
//  Created by Mike Fullerton on 3/27/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTigTool.h"
#import "FLShellCommand.h"

@implementation FLTigTool

+ (id) tigTool {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSString*) toolName {
    return @"tig";
}

- (NSString*) toolIdentifier {
    return @"com.greentongue.tig";
}

- (NSString*) toolVersion {
    return @"1.0.0.0";
}

- (id) init {
    self = [super initWithToolImplementation:self];
    if(self) {
//        [self addToolCommand:[ZFListGroupsCommand toolCommand]];
//    
//        _httpController = [[ZFHttpController alloc] init];
//        
//        [ZFHttpRequestFactory setHttpRequestFactoryClass:[ZFSoapHttpRequestFactory class]];
    }
    return self;
}

//- (void) authenticateUser {
//    [_httpController.userService loadCredentials];
//
//    int attemptCount = 0;
//    while(attemptCount < 3) {
//
//        if(![_httpController.userService canAuthenticate]) {
//            _httpController.userService.userName = [self getInputString:@"Enter user name (or email): " maxLength:1024];
//            _httpController.userService.password = [self getPassword:@"Enter your password: "];
//            _httpController.userService.rememberPassword = YES;
//            [_httpController.userService saveCredentials];    
//        }
//
//        [_httpController openUserService];
// 
//        FLToolLog(@"Authenticating...");
//        
//        FLPromisedResult result = [[_httpController beginDownloadingRootGroup:nil] waitUntilFinished];
//        if([result error] ) {
//            FLToolLog([[result error]  localizedDescription]);
//        }
//        else {
//            FLToolLog(@"Welcome %@", _httpController.user.userName);
//            return;
//        }
//             
//        ++attemptCount;
//    }
//    
//    FLToolLog(@"Authentication Failed.");
//}    
    
//- (void) setCurrentGroup:(id) group {
//}
//
//- (id) currentGroup {
//    return [_httpController.user rootGroup];
//}

- (void) willRunTool:(FLCommandLineTask*) task {

//    [self authenticateUser];
//
//    FLToolLog(@"> %@", [[self currentGroup] Title]);
}

@end
