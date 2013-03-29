//
//  ZFAuthenticationService.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequestAuthenticationService.h"
#import "ZFAuthenticationOperation.h"

@interface ZFAuthenticationService : FLHttpRequestAuthenticationService {
@private
}

+ (id) authenticationService;

@end

