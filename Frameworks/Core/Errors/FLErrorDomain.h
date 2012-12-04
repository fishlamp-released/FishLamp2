//
//  FLErrorDomain.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLRequired.h"
#import "FLProperties.h"

@protocol FLErrorDomain <NSObject>
+ (id) instance;
- (NSString*) stringFromErrorCode:(int) errorCode;
- (NSString*) errorDomainString;
@end

extern id<FLErrorDomain> FLErrorDomainFromObject(id object);

extern NSString* FLErrorDomainNameFromObject(id object);

NS_INLINE
id FLGetErrorDomain(id obj) {
    id domain = FLErrorDomainFromObject(obj);
    if(domain) {
        return domain;
    }

    return FLErrorDomainNameFromObject(obj);
}



