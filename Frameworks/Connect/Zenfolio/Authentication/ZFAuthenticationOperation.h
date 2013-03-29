//
//  ZFAuthenticationOperation.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFHttpUser.h"
#import "FLOperation.h"

@protocol ZFAuthenticationOperationDelegate;

@interface ZFAuthenticationOperation : FLOperation {
@private
    ZFHttpUser* _credentials;
}

@property (readonly, strong, nonatomic) ZFHttpUser* user;

- (id) initWithHttpUser:(ZFHttpUser*) user;
+ (id) authenticationOperation:(ZFHttpUser*) user;

@end

@protocol ZFAuthenticationOperationDelegate <NSObject>
- (void) authenticationOperation:(ZFAuthenticationOperation*) operation 
             didAuthenticateUser:(ZFHttpUser*) user;
@end