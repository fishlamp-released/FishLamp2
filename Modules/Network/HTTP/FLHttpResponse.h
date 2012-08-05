//
//  FLHttpResponse.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

@interface FLHttpResponse : NSObject {
@private
    NSInteger _responseStatusCode;
    NSString* _responseStatusLine;
    NSMutableData* _responseData;
    NSDictionary* _responseHeaders;
}

@property (readwrite, retain, nonatomic) NSDictionary* responseHeaders;
@property (readwrite, assign, nonatomic) NSInteger responseStatusCode;
@property (readwrite, retain, nonatomic) NSMutableData* responseData;
@property (readwrite, retain, nonatomic) NSString* responseStatusLine;


- (NSString*) headerValue:(NSString*) header;

@property (readonly, assign, nonatomic) BOOL wantsRedirect;
@property (readonly, assign, nonatomic) BOOL responseCodeIsRedirect;

/** returns an error for responses >= 400 */
- (NSError*) simpleHttpResponseErrorCheck;

@end
