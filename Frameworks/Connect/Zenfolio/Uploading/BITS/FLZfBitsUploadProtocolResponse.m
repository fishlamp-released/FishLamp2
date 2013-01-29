//
//  FLZfBitsUploadProtocolResponse+HTTPHeaders.m
//  myZenfolio
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLZfBitsUploadProtocolResponse.h"

@implementation FLZfBitsUploadProtocolResponse (HTTPHeaders)

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
        return [NSError errorWithDomain:FLZfBitsUploaderErrorDomain code:FLZfServerError 
            userInfo:
                [NSDictionary dictionaryWithObjectsAndKeys:
                    NSLocalizedDescriptionKey, [NSString stringWithFormat:@"Upload failed (BITS). Context: %@, Code: %@", self.errorContext, self.errorCode],
                    [FLZfBitsUploadProtocolResponse errorCodeKey], self.errorCode, 
                    [FLZfBitsUploadProtocolResponse errorContextKey], self.errorContext,
                    nil]];
    }

    return nil;
}
@end
