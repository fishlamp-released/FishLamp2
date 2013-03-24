//
//  ZFAuthenticationService.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequestAuthenticationService.h"

#define ZFHttpAuthenticationTimeout ((60 * 60) * 12.0f)

@interface ZFAuthenticationService : FLHttpRequestAuthenticationService {
@private
}

+ (id) authenticationService;

@end




