//
//  FLHttpServerService.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLHttpRequest.h"
#import "FLMutableHTTPRequest.h"

@interface FLHttpServerService : FLService {
@private
    id<FLHttpRequestAuthenticator> _httpRequestAuthenticator;
}

@property (readwrite, strong) id<FLHttpRequestAuthenticator> httpRequestAuthenticator;

@end
