//
//  FLErrorDomain.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLErrorDomain.h"


@implementation NSString (FLErrorDomain) 
- (NSString*) errorDomainString {
    return self;
}
@end

NSString* FLErrorDomainNameFromObject(id object) {
    return [object respondsToSelector:@selector(errorDomainString)] ? [object errorDomainString] : nil;
}

id<FLErrorDomain> FLErrorDomainFromObject(id object) {
    return [object conformsToProtocol:@protocol(FLErrorDomain)] ? (id<FLErrorDomain>) object : nil;
}