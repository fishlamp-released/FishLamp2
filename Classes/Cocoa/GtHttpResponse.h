//
//  GtHttpResponse.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@interface GtHttpResponse : NSObject {
@private
    NSInteger m_responseStatusCode;
    NSString* m_responseStatusLine;
    NSMutableData* m_responseData;
    NSDictionary* m_responseHeaders;
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
