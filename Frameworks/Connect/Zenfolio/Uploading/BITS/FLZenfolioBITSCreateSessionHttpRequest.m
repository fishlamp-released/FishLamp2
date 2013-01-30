//
//  FLZenfolioBITSCreateSessionHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLZenfolioBITSCreateSessionHttpRequest.h"
#import "FLZenfolioQueuedPhoto.h"
#import "FLZenfolioBitsUploadProtocolResponse.h"
#import "FLZenfolioPhoto.h"
#import "FLZenfolioQueuedPhoto.h"
#import "FLZenfolioUploadablePhoto.h"
#import "FLZenfolioErrors.h"
#import "FLZenfolioUtils.h"

// this guid is from the online docs
// http://msdn.microsoft.com/en-us/library/aa362833%28v=VS.85%29.aspx
// note zenfolio server requires all uppercase guid
#define kBITS1_5UploadProtocolGuid @"{7DF0354D-249B-430F-820D-3D2A9BEF4931}"

@implementation FLZenfolioBITSCreateSessionHttpRequest 

//- (FLResult) runHttpRequestWithInput:(id) input {
//
//    if(FLStringIsEmpty(self.queuedPhoto.uploadGallery.uploadUrl)) {
//        FLThrowErrorCode_v(FLZenfolioErrorDomain, FLZenfolioErrorCodeUploadPhotoSetNotFound, @"PhotoSet not found: %@", self.queuedPhoto.uploadGallery.name);
//    }
//    if(FLStringIsEmpty(self.queuedPhoto.assetFileName)) {
//        FLThrowErrorCode_v(FLZenfolioErrorDomain, FLZenfolioErrorCodeUploadFileNameEmpty, @"FileName is empty");
//    }
//
//    FLHttpRequest* httpRequest = [FLHttpRequest httpPostRequestWithURL:[self.queuedPhoto buildUploadURL:YES]];
//    [httpRequest setValue:@"Create-Session"              forHTTPHeaderField:@"BITS-Packet-Type"];
//    [httpRequest setValue:kBITS1_5UploadProtocolGuid     forHTTPHeaderField:@"BITS-Supported-Protocols"];
//  	[httpRequest setUtf8Content:@""]; 
//    
//    FLHttpResponse* httpResponse = [self sendHttpRequest:httpRequest];
//
//    FLZenfolioBitsUploadProtocolResponse* response = [FLZenfolioBitsUploadProtocolResponse bitsUploadProtocolResponse];
//
//    NSDictionary* headers = httpResponse.responseHeaders;
//    NSError* error = [response setDataWithHTTPHeaders:headers];
//    if(error) {
//        FLThrowError(error);
//    }
//    response.acceptEncoding = [headers objectForKey:@"Accept-Encoding"];
//    response.protocol = [headers objectForKey:@"Bits-Protocol"];
//    response.hostId = [headers objectForKey:@"Bits-Host-Id"];
//    response.hostIdFallbackTimeout = [headers objectForKey:@"Bits-Host-Id-Fallback-Timeout"];
//            
//    return response;
//}
@end
