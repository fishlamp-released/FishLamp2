//
//  ZFHttpController.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 3/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFHttpController.h"
#import "ZFRegisteredUserAuthenticationService.h"

#import "FLDictionaryObjectStorage.h"

#import "FLGlobalNetworkActivityIndicator.h"

#import "ZFLoadGroupHierarchyOperation.h"
#import "ZFDownloadPhotoSetsOperation.h"

@interface ZFHttpController ()
@property (readwrite, strong) FLUserService* userService;
@property (readwrite, strong) id<FLObjectStorage> objectCache;
@property (readwrite, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;
@end

@implementation ZFHttpController
@synthesize userService = _userLoginService;
@synthesize objectCache = _objectCacheService;
@synthesize httpRequestAuthenticator = _httpRequestAuthenticator;
@synthesize user = _user;

+ (id) httpController {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) init {
    self = [super initWithRootNameForDelegateMethods:@"httpController"];
    if(self) {
        _objectCacheService = [[FLObjectStorageService alloc] init];
        [_objectCacheService setObjectStorage:[FLDictionaryObjectStorage dictionaryObjectStorage]];
        [self addSubService:_objectCacheService];
        
        self.httpRequestAuthenticator = [ZFRegisteredUserAuthenticationService registeredUserAuthenticationService];
        self.httpRequestAuthenticator.delegate = self;
        [self addSubService:self.httpRequestAuthenticator];    
                
        self.userService = [FLUserService userService];
        self.userService.authenticationDomain = @"www.zenfolio.com";
        self.userService.delegate = self;
//        [self addSubService:self.userContext];   

        
    }
    return self;
}

//- (void) openService {
//    [super openService];
//    [self.delegate httpControllerDidOpenService:self];
//}
//
//- (void) closeService {
//    [super closeService];
//    [self.delegate httpControllerDidCloseService:self];
//}

#if FL_MRC
- (void) dealloc {
    [_user release];
    [_httpRequestAuthenticator release];
    [_objectCacheService release];
    [_userLoginService release];
    [super dealloc];
}
#endif

- (void) didStartWorking {
    [super didStartWorking];
    [FLGlobalNetworkActivityIndicator instance].networkBusy = YES;
}

- (void) didStopWorking {
    [super didStopWorking];
    [FLGlobalNetworkActivityIndicator instance].networkBusy = NO;
}

- (void) userServiceDidOpen:(FLUserService*) service {
    [self openService:self];
}

- (void) userServiceDidClose:(FLUserService*) service {
    [self closeService:self];
}

- (void) httpRequestAuthenticationService:(FLHttpRequestAuthenticationService*) service 
                      didAuthenticateUser:(ZFHttpUser*) userLogin {
    
    [self.delegate httpController:self didAuthenticateUser:userLogin];
}

//
//- (BOOL) isContextAuthenticated {
//    return self.httpRequestAuthenticator.isAuthenticated;
//}

- (void) logoutUser {
    [self.user setUnathenticated];
    [self.userService closeService:self];
    [self.delegate httpController:self didLogoutUser:self.user];
}

- (id<FLWorkerContext>) httpRequestAuthenticationServiceGetWorkerContext:(FLHttpRequestAuthenticationService*) service {
    return self;
}

- (FLHttpUser*) httpRequestAuthenticationServiceGetUser:(FLHttpRequestAuthenticationService*) service {
    return self.user;
}

//- (void) didAddWorker:(id) object {
//    [super didAddWorker:object];
//    if([object respondsToSelector:@selector(delegate)]) {
//        if(![object delegate]) {
//            [object setDelegate:self];
//        }
//    }
//}
//
//- (void) didRemoveWorker:(id) object {
//    [super didRemoveWorker:object];
//    if([object respondsToSelector:@selector(delegate)]) {
//        if([object delegate] == self) {
//            [object setDelegate:nil];
//        }
//    }
//}

- (FLFinisher*) beginDownloadingPhotoSetsForRootGroup:(id) observer 
                           downloadedPhotoSetSelector:(SEL) photoSetSelector
                                     finishedSelector:(SEL) finishedSelector {

    ZFDownloadPhotoSetsOperation* operation = 
        [ZFDownloadPhotoSetsOperation downloadPhotoSetsWithGroup:self.user.rootGroup];
    
    operation.delegate = self;
    operation.observer = observer;
    operation.downloadedPhotoSetSelector = photoSetSelector;
    operation.finishSelectorForObserver = finishedSelector;

    return [operation startInContext:self completion:^(FLResult result) {

    }];
}        

- (FLFinisher*) beginDownloadingRootGroup:(id) observer finishedSelector:(SEL) finishedSelector {
    
    ZFLoadGroupHierarchyOperation* operation = 
        [ZFLoadGroupHierarchyOperation loadGroupHierarchyOperation:self.user.credentials]; 

    operation.delegate = self;
    operation.observer = observer;
    operation.finishSelectorForObserver = finishedSelector;

    return [operation startInContext:self completion:^(FLResult result) {
        if(![result error]) {
            self.user.rootGroup = result;
        }
    }];
}

- (id<FLObjectStorage>) operationGetObjectStorage:(FLOperation*) operation {
    return [self.objectCache objectStorage];
}


//- (id) operationDownloadPhotoSetsInRootGroup {
//    ZFDownloadPhotoSetsOperation* downloadPhotosets = [ZFDownloadPhotoSetsOperation downloadPhotoSetsWithGroup:self.user.rootGroup];
//    downloadPhotosets.delegate = self;
//    
///*    FLResult result =  */
//    [self runWorker: downloadPhotosets];
//
//}


//- (FLFinisher*) beginDownloadingGroupList:(id) observer 
//                               completion:(FLBlockWithResult) completion {
//
//
//    FLUserLogin* userLogin = self.user.credentials;
//    
//    ZFLoadGroupHierarchyOperation* operation =
//        [ZFLoadGroupHierarchyOperation loadGroupHierarchyOperation:userLogin]; 
//
//    operation.observer = observer;
//
//    return [operation startInContext:self completion:completion];
//}

@end
