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

- (void) httpRequest:(FLHttpRequest*) httpRequest didWriteBytes:(NSNumber*) amount {
 
    [self sendObservation:@selector(didDownloadBytes:forPhoto:) withObject:amount withObject:self.downloadSpec];
}

- (id) startAsyncOperation {
    
    NSString* filePath = _downloadSpec.fullPathToFile;

    [self sendObservation:@selector(willDownloadPhoto:) withObject:_downloadSpec];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [self setFinishedWithReturnedObject:_downloadSpec hint:ZFPhotoDownloaderHintPhotoWasSkipped];
    }
    else {

        FLHttpRequest* request = [FLHttpRequest httpRequest:[_downloadSpec.photo urlForImageWithSize:_downloadSpec.mediaType]];

    // TODO: abstract which sink is used    
        request.inputSink = [FLHiddenFolderFileSink hiddenFolderFileSink:filePath
                                                              folderPath:self.downloadSpec.tempFolder]; 

        [self runChildAsynchronously:request completion:^(id<FLAsyncResult> result) {
            [self setFinishedWithResult:result];
        }];
    }
    
    return _downloadSpec;
}

- (void) sendStartMessagesWithInitialData:(id) initialData {
    [self sendObservation:@selector(willDownloadPhoto:) withObject:_downloadSpec];
}

- (void) sendFinishMessagesWithResult:(id<FLAsyncResult>) result {
    [self sendObservation:@selector(didDownloadPhotoWithResult:) withObject:result];
}




@end
