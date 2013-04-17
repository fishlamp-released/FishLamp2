//
//  FLNetworkErrors.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLErrors.h"

extern NSString* const FLNetworkErrorDomain;

typedef enum {
    FLNetworkErrorCodeSoapFault,
    FLNetworkErrorCodeNoRouteToHost = EHOSTUNREACH
} FLNetworkErrorCode;


//	FLAuthenticationErrorPasswordIncorrect,
//	FLAuthenticationErrorPasswordIncorrectOffline,
