//
//  CFHTTPStreamWrapper.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "CFStreamWrapper.h"
#import "CFHTTPMessageWrapper.h"

@interface CFHTTPStreamWrapper : CFReadStreamWrapper {
}

- (id) initWithStreamedHTTPRequest:(CFHTTPMessageWrapper*) message
                       requestBody:(NSInputStream*) requestBody;
    
- (id) initWithHTTPRequest:(CFHTTPMessageWrapper*) message;

@property (readonly, retain, nonatomic) CFHTTPMessageWrapper* responseHeader;

@property (readonly, assign, nonatomic) unsigned long long bytesSent;

@end
