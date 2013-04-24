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

@interface ZFPhotoDownloader ()
@property (readwrite, strong) ZFDownloadSpec* downloadSpec; 
@end

@implementation ZFPhotoDownloader

@synthesize downloadSpec = _downloadSpec;

- (id) initWithDownloadSpec:(ZFDownloadSpec*) downloadSpec {	
    FLAssertNotNil(downloadSpec);
	self = [super initWithRequestURL:[downloadSpec.photo urlForImageWithSize:downloadSpec.mediaType]];
	if(self) {
		self.downloadSpec = downloadSpec;
	}
	return self;
}

+ (id) photoDownloader:(ZFDownloadSpec*) downloadSpec {
    return FLAutorelease([[[self class] alloc] initWithDownloadSpec:downloadSpec]);
}

- (void) requestDidFinishWithResult:(id) result {
    [super requestDidFinishWithResult:result];
    if(![result error]) {
        FLPerformSelector1(self.delegate, @selector(photoDownloaderDidDownloadPhoto:), self);
    }
}

- (void) startAsyncOperation {
    
    NSString* filePath = _downloadSpec.fullPathToFile;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        FLPerformSelector1(self.delegate, @selector(photoDownloaderDidSkipPhoto:), self);
        [self setFinished];
    }
    else {


    // TODO: abstract which sink is used    
        self.inputSink = [FLHiddenFolderFileSink hiddenFolderFileSink:filePath
                                                              folderPath:self.downloadSpec.tempFolder]; 

        [super startAsyncOperation];
    }
}
@end
