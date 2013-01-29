//
//  FLZfBITSCloseSessionHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLZfBITSCloseSessionHttpRequest.h"
#import "FLZfUploadQueue.h"
#import "FLZfUtils.h"
#import "FLZfBitsUploadProtocolResponse.h"

@implementation FLZfBITSCloseSessionHttpRequest

static NSNumberFormatter* s_formatter = nil;
static NSDateFormatter* s_rfc1123dateFormatter = nil;

+ (void) initialize
{
    static BOOL s_initialized = NO;
    if(!s_initialized)
    {
        s_initialized = YES;
        s_formatter = [[NSNumberFormatter alloc] init];
        
        s_rfc1123dateFormatter = [[NSDateFormatter alloc] init];
        [s_rfc1123dateFormatter setDateFormat:@"E, dd MMM yyyy HH:mm:ss zzz"];
    }
}

- (id) initWithUploadablePhoto:(FLZfQueuedPhoto*) photo
                   sessionInfo:(FLZfBitsUploadProtocolResponse*) sessionInfo
                   fileSize:(unsigned long long) fileSize                   
{
	if((self = [super initWithQueuedPhoto:photo])) {
        _sessionInfo = FLRetain(sessionInfo);
        _fileSize = fileSize;
    }

    return self;
}                

- (void) dealloc {
    FLRelease(_sessionInfo);
	FLSuperDealloc();
}

//- (FLResult) runHttpRequestWithInput:(id) input {
//
//    if(FLStringIsEmpty(self.queuedPhoto.uploadGallery.uploadUrl)) {
//        FLThrowErrorCode_v(FLZfErrorDomain, FLZfErrorCodeUploadPhotoSetNotFound, @"PhotoSet not found: %@", self.queuedPhoto.uploadGallery.name);
//    }
//    if(FLStringIsEmpty(self.queuedPhoto.assetFileName)) {
//        FLThrowErrorCode_v(FLZfErrorDomain, FLZfErrorCodeUploadFileNameEmpty, @"FileName is empty");
//    }
//
//	NSDate* date = self.queuedPhoto.modifiedDate;
//
//	if(!date) {
//		date = [NSDate date];
//	}
//
//	NSString* modDate = [s_rfc1123dateFormatter stringFromDate:date];
//    
//    FLHttpRequest* httpRequest = [FLHttpRequest httpPostRequestWithURL:[self.queuedPhoto buildUploadURL:YES]];
//    [httpRequest setValue:@"Close-Session" forHTTPHeaderField:@"BITS-Packet-Type"];
//    [httpRequest setValue:_sessionInfo.sessionId forHTTPHeaderField:@"BITS-Session-Id"];
//    [httpRequest setValue:modDate forHTTPHeaderField:@"X-Zenfolio-LastModified" ];
//    [httpRequest setValue:[NSString stringWithFormat:@"%qu", _fileSize] forHTTPHeaderField:@"X-Zenfolio-FileSize"];
//    [httpRequest setUtf8Content:@""]; 
//    
//    FLHttpResponse* httpResponse = [self.requestSender sendHttpRequest:httpRequest];
//
//    FLAssertIsNotNil_(httpResponse);
//    FLAssertIsKindOfClass_(httpResponse, FLHttpResponse);
//
//    NSData* data = httpResponse.responseData;
//    if(data && data.length) {
//        NSString* responseStr = FLAutorelease([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);    
//        self.queuedPhoto.uploadedAssetId = [s_formatter numberFromString:responseStr]; 
//        if(self.queuedPhoto.uploadedAssetIdValue == 0) {
//            FLThrowErrorCode_v(FLZfErrorDomain, FLZfErrorCodeUnknownObjectId, @"Photo id is zero");
//        }
//    }
//        
//    FLZfBitsUploadProtocolResponse* response = [FLZfBitsUploadProtocolResponse bitsUploadProtocolResponse];
//
//    NSDictionary* headers = httpResponse.responseHeaders;
//    NSError* error = [response setDataWithHTTPHeaders:headers];
//    if(error) {
//        FLThrowError(error);
//    }
//
//// TODO: decouple this        
//    FLZfUploadQueue* uploadQueue = [self.context uploadQueue];
//    [uploadQueue saveAsset:self.queuedPhoto];
//    
//    return response;
//}

@end
