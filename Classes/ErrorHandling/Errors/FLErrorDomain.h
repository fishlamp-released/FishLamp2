//
//  FLErrorDomain.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLProperties.h"

@interface FLErrorDomain : NSObject 
- (NSString*) descriptionForError:(NSError*) error;

+ (id) errorDomainFromObject:(id) object;
+ (NSString*) errorDomainNameFromObject:(id) object;
@end

// if you're getting an error like "unexpected @ in program" make sure
// parameter to FLDeclareErrorDomain isn't already defined
#define FLDeclareErrorDomain(__DOMAIN_OBJECT_NAME__) \
            @interface __DOMAIN_OBJECT_NAME__ : FLErrorDomain {} \
            FLSingletonProperty(__DOMAIN_OBJECT_NAME__); \
            @end \
            extern NSString* const __DOMAIN_OBJECT_NAME__##Name

// if you're getting an error like "unexpected @ in program" make sure
// parameter to FLSynthesizeErrorDomain isn't already defined
#define FLSynthesizeErrorDomain(__DOMAIN_OBJECT_NAME__, __URL__) \
            NSString* const __DOMAIN_OBJECT_NAME__##Name = __URL__; \
            @implementation __DOMAIN_OBJECT_NAME__ \
            - (NSString*) errorDomainName { return __DOMAIN_OBJECT_NAME__##Name; }  \
            FLSynthesizeSingleton(__DOMAIN_OBJECT_NAME__); \
            @end


// if you're getting an error like "expected expression" you're probably not sending in a string
// or any object - maybe you're sending in the NAME of a class?
#define __OBJECT_OR_STRING_CHECK(this_must_be_a_string_or_object) this_must_be_a_string_or_object

#define FLGetErrorDomain(__THING__) [FLErrorDomain errorDomainFromObject:__OBJECT_OR_STRING_CHECK(__THING__)]

// helper
#define FLURLErrorDomain        NSURLErrorDomain
