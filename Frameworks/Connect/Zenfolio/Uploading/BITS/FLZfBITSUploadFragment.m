//
//  FLZfBITSUploadFragment.m
//  myZenfolio
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLZfBITSUploadFragment.h"
#import "FLZfBitsUploadProtocolResponse.h"
#import "FLZfBitsUploadProtocolResponse.h"
#import "FLZfErrors.h"

@implementation FLZfBITSUploadFragment

@synthesize amountWritten = _amountWritten;

- (id) initWithUploadablePhoto:(FLZfQueuedPhoto*) photo 
                 preparedImage:(FLStorableImage*) image
                   startOffset:(unsigned long long) startOffset
                     chunkSize:(unsigned long long) chunkSize
                      fileSize:(unsigned long long) fileSize
                   sessionInfo:(FLZfBitsUploadProtocolResponse*) sessionInfo {
	
    if((self = [super init])) {
        
        _chunkSize = chunkSize;
        _fileOffset = startOffset;
        _fileSize = fileSize;
        _sessionInfo = FLRetain(sessionInfo);
        _imageFile = FLRetain(image);
    
        unsigned long long remainingBytes = _fileSize - _fileOffset;
        if(remainingBytes <= _chunkSize) {
            _chunkSize = remainingBytes;
        }
    
        FLAssert_v(_chunkSize > 0, @"invalid chunk size");
        FLAssert_v(_fileOffset < _fileSize, @"invalid offset");
                                        
        [_imageFile releaseAllImageData]; // don't want it loaded in memory because we're going to stream it in chunks from file
    }
	
	return self;
}

#if FL_MRC
- (void) dealloc {
    [_imageFile release];
    [_sessionInfo release];
    [super dealloc];
}
#endif

- (FLHttpResponse*) sendRequest {

#if FIXME
    NSFileHandle* file = [NSFileHandle fileHandleForReadingAtPath:_imageFile.filePath];
    [file seekToFileOffset:_fileOffset];
    NSData* data = [file readDataOfLength: (unsigned long) _chunkSize];
    
    FLHttpRequest* httpRequest = [FLHttpRequest httpPostRequestWithURL:[self.queuedPhoto buildUploadURL:YES]];
    [httpRequest setValue:@"Fragment" forHTTPHeaderField:@"BITS-Packet-Type"];
    [httpRequest setValue:[NSString stringWithFormat:@"%@", _sessionInfo.sessionId] forHTTPHeaderField:@"BITS-Session-Id"];
    [httpRequest setValue:_imageFile.fileName forHTTPHeaderField:@"Content-Name"];
    
    [httpRequest setValue:[NSString stringWithFormat:@"Bytes %qu-%qu/%qu",
        _fileOffset,
        _fileOffset + _chunkSize - 1,
        _fileSize]
        forHTTPHeaderField:@"Content-Range"];
    
    [httpRequest setContentWithData:data typeContentHeader:@"image/jpeg"];

    return [self sendHttpRequest:httpRequest withAuthenticator:self.requestAuthenticator];
#endif

    return nil;
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
//    FLHttpResponse* httpResponse = [self sendRequest];
//    
//    _amountWritten = _chunkSize;
//
//    FLZfBitsUploadProtocolResponse* bitsResponse = [FLZfBitsUploadProtocolResponse bitsUploadProtocolResponse];
//
//    NSDictionary* headers = httpResponse.responseHeaders;
//    NSError* error = [bitsResponse setDataWithHTTPHeaders:headers];
//    if(error) {
//        FLThrowError(error);
//    }
//    
//    bitsResponse.protocol =  [headers objectForKey:@"Bits-Protocol"];   
//    
//    // NOTE: we may need to parse this and use this to set _fileOffset if the server ever
//    // can return a size different than we uploaded in the last packet. I don't think
//    // the server will do this so we *should* be okay.
//    bitsResponse.receivedContentRange = [headers objectForKey:@"Bits-Received-Content-Range"];   
//    bitsResponse.replyURL = [headers objectForKey:@"Bits-Reply-URL"];   
//            
//    return bitsResponse;
//}

@end
