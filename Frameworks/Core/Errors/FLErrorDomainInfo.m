//
//  FLErrorDomainInfo.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLErrorDomainInfo.h"

#import "FLFrameworkErrorDomain.h"
#import "FLAssertionFailureErrorDomain.h"

@implementation FLErrorDomainInfo

FLSynthesizeSingleton(FLErrorDomainInfo);

- (id) init {	
	self = [super init];
	if(self) {
		_domains = [[NSMutableDictionary alloc] init];
	}
	return self;
}

#if FL_MRC
- (void) dealloc {
	[_domains release];
	[super dealloc];
}
#endif

- (FLErrorDomainInfo*) infoForErrorDomain:(NSString*) errorDomain {
    return [_domains objectForKey:errorDomain];
}

- (void) setInfo:(FLErrorDomainInfo*) info forDomain:(NSString*) domain {
    [_domains setObject:info forKey:domain];
}

+ (void) initialize {
    [[FLErrorDomainInfo instance] setInfo:[FLFrameworkErrorDomainInfo frameworkErrorDomainInfo] forDomain:FLFrameworkErrorDomain];
    [[FLErrorDomainInfo instance] setInfo:[FLAssertionFailureErrorDomainInfo assertionFailureErrorDomainInfo] forDomain:FLAssertionFailureErrorDomain];
}

- (NSString*) stringFromErrorCode:(int) errorCode {
    return nil;
}

- (NSString*) stringFromErrorCode:(int) errorCode withDomain:(NSString*) domain {
    @synchronized(self) {
        return [[[FLErrorDomainInfo instance] infoForErrorDomain:domain] stringFromErrorCode:errorCode];
    }
}

@end