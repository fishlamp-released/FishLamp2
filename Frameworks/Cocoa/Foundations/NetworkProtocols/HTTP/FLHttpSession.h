//
//  FLHttpSession.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSession.h"
#import "FLRequestContext.h"

@interface FLHttpSession : FLSession {
@private
    FLRequestContext* _requestContext;
}

@property (readwrite, strong) FLRequestContext* httpService;

@end
