//
//  FLErrorDomain.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLErrorDomain.h"


@interface NSObject (FLErrorDomain)
+ (id) errorDomain;
- (id) errorDomain;
- (NSString*) errorDomainName;
@end

@implementation FLErrorDomain

- (NSString*) errorDomainName {
    return nil;
}

- (NSString*) descriptionForError:(NSError*) error {
    return nil;
}

+ (id) instance {
    return self;
}

+ (id) errorDomain {
    return [self instance];
}

- (id) errorDomain {
    return self;
}


+ (id) errorDomainFromObject:(id) object {
    return [object errorDomain];
}

+ (NSString*) errorDomainNameFromObject:(id) object {
    return [object errorDomainName];
}


@end

@implementation NSObject (FLErrorDomain)
+ (id) errorDomain {
    return nil;
}

- (id) errorDomain {
    return [[self class] errorDomain];
}

- (NSString*) errorDomainName {
    return nil;
}
@end

@implementation NSString (FLErrorDomain)

- (id) errorDomain {
    return self;
}

- (NSString*) errorDomainName {
    return self;
}

@end

