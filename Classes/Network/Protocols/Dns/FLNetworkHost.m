//
//  FLNetworkHost.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkHost.h"

#if IOS
    #import <CFNetwork/CFNetwork.h>
#else
    #import <CoreServices/CoreServices.h>
#endif

#include <netdb.h>

@interface FLNetworkHost ()

@property (readwrite, nonatomic, assign) CFHostRef hostRef;
@property (readwrite, nonatomic, strong) NSString* hostName;
@property (readwrite, nonatomic, strong) NSData* addressData;
@property (readwrite, nonatomic, strong) NSArray* resolvedAddresses;
@property (readwrite, nonatomic, strong) NSArray* resolvedAddressStrings;
@property (readwrite, nonatomic, strong) NSArray* resolvedHostNames;
@end

@implementation FLNetworkHost

@synthesize hostRef = _hostRef;
@synthesize hostName = _hostHame;
@synthesize addressData = _addressData;
@synthesize resolved = _resolved;
@synthesize resolvedAddresses = _resolvedAddresses;
@synthesize resolvedAddressStrings = _resolvedAddressStrings;
@synthesize resolvedHostNames = _resolvedHostNames;

- (void) _failIfInvalidHost {
    if(!_hostRef) {
        FLAutorelease(self);
        FLConfirmIsNotNil_(_hostRef);
    }
}

- (id) initWithName:(NSString*) name {
    self = [super init];
    if(self) {
        FLAssertStringIsNotEmpty_v(name, nil);
        
        self.hostName = name;
        _hostRef = CFHostCreateWithName(nil, (__bridge_fl CFStringRef) name );
        [self _failIfInvalidHost];
    }
    
    return self;
}

- (id) initWithAddress:(NSData*) address {
    self = [super init];
    if(self) {
        self.addressData = address;
        _hostRef = CFHostCreateWithAddress(NULL, (__bridge_fl CFDataRef) address);
        [self _failIfInvalidHost];
    }
    
    return self;
}

-  (id) initWithAddressString:(NSString*) addressString {
    self = [super init];
    if(self) {
        
        // Use a BSD-level routine to convert the address string into an address.  It's
        // important that we specificy AI_NUMERICHOST and AI_NUMERICSERV so that this routine 
        // just does numeric conversion; without that, if addressString was a DNS name, 
        // we would hit the network trying to resolve it, and do that synchronously.
        
        struct addrinfo *   result;
        struct addrinfo     template;
        memset(&template, 0, sizeof(template));
        template.ai_flags = AI_NUMERICHOST | AI_NUMERICSERV;
        int err = getaddrinfo([addressString UTF8String], NULL, &template, &result);

        if (err == 0) {
            self.addressData = [NSData dataWithBytes:result->ai_addr length:result->ai_addrlen];
            freeaddrinfo(result);
        }
        
        if(self.addressData) {
            _hostRef = CFHostCreateWithAddress(NULL, (__bridge_fl CFDataRef) self.addressData);
        }
        
        [self _failIfInvalidHost];

    }
    
    return self;
}

+ (FLNetworkHost*) networkHostWithName:(NSString*) name {
    return FLReturnAutoreleased([[FLNetworkHost alloc] initWithName:name]);
}

+ (FLNetworkHost*) networkHostWithAddress:(NSData*) data {
    return FLReturnAutoreleased([[FLNetworkHost alloc] initWithAddress:data]);
}

+ (FLNetworkHost*) networkHostWithAddressString:(NSString*) addressString {
    return FLReturnAutoreleased([[FLNetworkHost alloc] initWithAddressString:addressString]);
}

- (NSArray *) resolvedAddresses {
    FLAssertIsNotNil_v(_hostRef, nil);
    
    if(!_resolvedAddresses && _hostRef) {
        NSArray* result = (__bridge_fl NSArray *) CFHostGetAddressing(_hostRef, (Boolean*) &_resolved);
        if (_resolved ) {
            self.resolvedAddresses  = result;
        }
    }
    return _resolvedAddresses;
}

- (NSArray *) resolvedAddressStrings {
    FLAssertIsNotNil_v(_hostRef, nil);
    
    if(!_resolvedAddressStrings && _hostRef) {
    
            // Get the resolved addresses and convert each in turn to an address string.
        NSArray* addresses = self.resolvedAddresses;
        
        if (addresses != nil) {
            NSMutableArray*  result = [NSMutableArray array];
            for (NSData * address in addresses) {
                int         err;
                char        addrStr[NI_MAXHOST];
                
                FLAssertIsKindOfClass_v(address, NSData, nil);
                               
                err = getnameinfo((const struct sockaddr *) [address bytes], (socklen_t) [address length], addrStr, sizeof(addrStr), NULL, 0, NI_NUMERICHOST);
                if (err == 0) {
                    [result addObject:[NSString stringWithUTF8String:addrStr]];
                } else {
                    result = nil;
                    break;
                }
            }

            self.resolvedAddressStrings = result;
        }
        
    }
    
    return _resolvedAddressStrings;
}

- (NSArray *)resolvedHostNames {
    FLAssertIsNotNil_v(_hostRef, nil);
    
    if(!_resolvedHostNames && _hostRef) {
        NSArray* result = (__bridge_fl NSArray *) CFHostGetNames(_hostRef, (Boolean*) &_resolved);
        if (_resolved) {
            self.resolvedHostNames = result;
        }
    }
    return _resolvedHostNames;
}

- (CFHostInfoType) hostInfoType {
    return FLStringIsNotEmpty(self.hostName) ? kCFHostAddresses : kCFHostNames;
}

- (void) dealloc {

    if (_hostRef) {
        CFHostSetClient(_hostRef, nil, nil);
        CFRelease(_hostRef);
    }
    
    FLRelease(_resolvedHostNames);
    FLRelease(_resolvedAddressStrings);
    FLRelease(_resolvedAddresses);
    FLRelease(_hostHame);
    FLRelease(_addressData);
    FLSuperDealloc();
}

@end
