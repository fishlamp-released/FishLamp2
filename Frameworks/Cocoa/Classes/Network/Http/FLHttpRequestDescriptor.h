//
//  FLHttpRequestDescriptor.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/30/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLHttpRequestDescriptor <NSObject>
- (NSString*) location;
- (NSString*) operationName;
- (NSString*) targetNamespace;
- (id) input;
- (id) output;

@optional
// soap
- (NSString*) soapAction;

- (NSString*) httpMethod;

@end
