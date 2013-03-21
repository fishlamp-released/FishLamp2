//
//  FLErrorDomainInfo.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLRequired.h"
#import "FLProperties.h"

@protocol FLErrorDomainInfo <NSObject>
- (NSString*) stringFromErrorCode:(int) errorCode;

@end

@interface FLErrorDomainInfo : NSObject {
@private
    NSMutableDictionary* _domains;
}

FLSingletonProperty(FLErrorDomainInfo);

- (FLErrorDomainInfo*) infoForErrorDomain:(NSString*) errorDomain;
- (void) setInfo:(FLErrorDomainInfo*) info forDomain:(NSString*) domain;

- (NSString*) stringFromErrorCode:(int) errorCode withDomain:(NSString*) domain;


@end


