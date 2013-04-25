//
//  ZFBITSCloseSessionHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//
#if REFACTOR

#import "ZFBITSCloseSessionHttpRequest.h"
#import "ZFUploadQueue.h"

#import "ZFBitsUploadProtocolResponse.h"

@implementation ZFBITSCloseSessionHttpRequest

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

- (id) initWithUploadablePhoto:(ZFQueuedPhoto*) photo
                   sessionInfo:(ZFBitsUploadProtocolResponse*) sessionInfo
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

//- (id<FLAsyncResult>) runHttpRequestWithInput:(id) input {
//
//    if(FLStringIsEmpty(self.queuedPhoto.uploadGallery.uploadUrl)) {
//        FLThrowErrorCodeWithComment(ZFErrorDomain, ZFErrorCodeUploadPhotoSetNotFound, @"PhotoSet not found: %@", self.queuedPhoto.uploadGallery.name);
//    }
//    if(FLStringIsEmpty(self.queuedPhoto.assetFileName)) {
//        FLThrowErrorCodeWithComment(ZFErrorDomain, ZFErrorCodeUploadFileNameEmpty, @"FileName is empty");
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
//    FLHttpResponse* httpResponse = [self.requestSender runChildSynchronously:httpRequest];
//
//    FLAssertIsNotNil(httpResponse);
//    FLAssertIsKindOfClass(httpResponse, FLHttpResponse);
//
//    NSData* data = httpResponse.responseData;
//    if(data && data.length) {
//        NSString* responseStr = FLAutorelease([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);    
//        self.queuedPhoto.uploadedAssetId = [s_formatter numberFromString:responseStr]; 
//        if(self.queuedPhoto.uploadedAssetIdValue == 0) {
//            FLThrowErrorCodeWithComment(ZFErrorDomain, ZFErrorCodeUnknownObjectId, @"Photo id is zero");
//        }
//    }
//        
//    ZFBitsUploadProtocolResponse* response = [ZFBitsUploadProtocolResponse bitsUploadProtocolResponse];
//
//    NSDictionary* headers = httpResponse.responseHeaders;
//    NSError* error = [response setDataWithHTTPHeaders:headers];
//    if(error) {
//        FLThrowIfError(error);
//    }
//
//// TODO: decouple this        
//    ZFUploadQueue* uploadQueue = [self.context uploadQueue];
//    [uploadQueue saveAsset:self.queuedPhoto];
//    
//    return response;
//}

@end
#endif