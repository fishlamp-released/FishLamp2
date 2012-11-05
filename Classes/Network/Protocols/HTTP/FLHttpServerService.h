//
//  FLHttpServerService.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"

#import "FLService.h"
#import "FLHttpOperation.h"

@interface FLHttpServerService : FLService {
@private
    id<FLHttpOperationAuthenticator> _authenticator;
}

@property (readwrite, strong) id<FLHttpOperationAuthenticator> authenticator;

@end
