//
//  ZFBitsUploadProtocolResponse+HTTPHeaders.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//
#if REFACTOR

#import "ZFBitsUploadProtocolResponse.h"

@implementation ZFBitsUploadProtocolResponse (HTTPHeaders)

- (NSError*) setDataWithHTTPHeaders:(NSDictionary*) headers
{
    self.errorCode = [headers objectForKey:@"Bits-Error-Code"];     
    self.errorContext = [headers objectForKey:@"Bits-Error-Context"];     
    self.sessionId = [headers objectForKey:@"Bits-Session-Id"];
    self.packetType =  [headers objectForKey:@"Bits-Packet-Type"];   

    FLAssertStringIsNotEmpty(self.sessionId);
    FLAssertStringIsNotEmpty(self.packetType);

    if(FLStringIsNotEmpty(self.errorCode))
    {
        return [NSError errorWithDomain:ZFBitsUploaderErrorDomain code:ZFServerError 
            userInfo:
                [NSDictionary dictionaryWithObjectsAndKeys:
                    NSLocalizedDescriptionKey, [NSString stringWithFormat:@"Upload failed (BITS). Context: %@, Code: %@", self.errorContext, self.errorCode],
                    [ZFBitsUploadProtocolResponse errorCodeKey], self.errorCode, 
                    [ZFBitsUploadProtocolResponse errorContextKey], self.errorContext,
                    nil]];
    }

    return nil;
}
@end
#endif