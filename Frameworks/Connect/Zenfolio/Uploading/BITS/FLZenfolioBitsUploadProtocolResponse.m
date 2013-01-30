//
//  FLZenfolioBitsUploadProtocolResponse+HTTPHeaders.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLZenfolioBitsUploadProtocolResponse.h"

@implementation FLZenfolioBitsUploadProtocolResponse (HTTPHeaders)

- (NSError*) setDataWithHTTPHeaders:(NSDictionary*) headers
{
    self.errorCode = [headers objectForKey:@"Bits-Error-Code"];     
    self.errorContext = [headers objectForKey:@"Bits-Error-Context"];     
    self.sessionId = [headers objectForKey:@"Bits-Session-Id"];
    self.packetType =  [headers objectForKey:@"Bits-Packet-Type"];   

    FLAssertStringIsNotEmpty_(self.sessionId);
    FLAssertStringIsNotEmpty_(self.packetType);

    if(FLStringIsNotEmpty(self.errorCode))
    {
        return [NSError errorWithDomain:FLZenfolioBitsUploaderErrorDomain code:FLZenfolioServerError 
            userInfo:
                [NSDictionary dictionaryWithObjectsAndKeys:
                    NSLocalizedDescriptionKey, [NSString stringWithFormat:@"Upload failed (BITS). Context: %@, Code: %@", self.errorContext, self.errorCode],
                    [FLZenfolioBitsUploadProtocolResponse errorCodeKey], self.errorCode, 
                    [FLZenfolioBitsUploadProtocolResponse errorContextKey], self.errorContext,
                    nil]];
    }

    return nil;
}
@end
