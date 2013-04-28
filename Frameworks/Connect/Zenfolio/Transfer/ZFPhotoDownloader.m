//
//  ZFPhotoDownloader.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFPhotoDownloader.h"
#import "FLHttpRequest.h"
#import "FLHiddenFolderFileSink.h"
#import "ZFAsyncObserving.h"

#import "FLObservable.h"

@interface ZFPhotoDownloader ()
@property (readwrite, strong) ZFDownloadSpec* downloadSpec; 
@end

@implementation ZFPhotoDownloader

@synthesize downloadSpec = _downloadSpec;

static NSUInteger s_maxRetryCount = 3;

+ (void) setDefaultMaxRetryCount:(NSUInteger) maxRetryCount {
    s_maxRetryCount = maxRetryCount;
}

+ (NSUInteger) defaultMaxRetryCount {
    return s_maxRetryCount;
}

- (id) initWithDownloadSpec:(ZFDownloadSpec*) downloadSpec {	
    FLAssertNotNil(downloadSpec);
	self = [super init];
	if(self) {
		self.downloadSpec = downloadSpec;
	}
	return self;
}

+ (id) photoDownloader:(ZFDownloadSpec*) downloadSpec {
    return FLAutorelease([[[self class] alloc] initWithDownloadSpec:downloadSpec]);
}

- (void) httpRequest:(FLHttpRequest*) httpRequest didReadBytes:(FLHttpRequestByteCount*) amount {
    [self.delegate performOptionalSelector:@selector(photoDownloader:didReadBytes:forPhoto:) withObject:self withObject:amount withObject:self.downloadSpec];
}

- (id) startAsyncOperation {
    
    NSString* filePath = _downloadSpec.fullPathToFile;
    _downloadSpec.wasSkipped = NO;
    _downloadSpec.wasDownloaded = NO;

    [self.observer receiveObservation:@selector(willDownloadPhoto:) withObject:_downloadSpec];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        _downloadSpec.wasSkipped = YES;
        [self.finisher setFinishedWithResult:_downloadSpec];
    }
    else {

        FLHttpRequest* request = [FLHttpRequest httpRequest:[_downloadSpec.photo urlForImageWithSize:_downloadSpec.mediaType]];

        request.canRetry = YES;
        request.maxRetryCount = s_maxRetryCount;

    // TODO: abstract which sink is used    
        request.inputSink = [FLHiddenFolderFileSink hiddenFolderFileSink:filePath
                                                              folderPath:self.downloadSpec.tempFolder]; 

        [self runChildAsynchronously:request completion:^(FLPromisedResult result) {
            if(![result error]) {
                _downloadSpec.wasDownloaded = YES;
            }
            [self.finisher setFinishedWithResult:result];
        }];
    }
    
    return _downloadSpec;
}

- (void) sendStartMessagesWithInitialData:(id) initialData {
    [self.observer receiveObservation:@selector(willDownloadPhoto:) withObject:_downloadSpec];
}

- (void) sendFinishMessagesWithResult:(FLPromisedResult) result {
    [self.observer receiveObservation:@selector(didDownloadPhoto:withResult:) withObject:self.downloadSpec withObject:result];
}




@end
