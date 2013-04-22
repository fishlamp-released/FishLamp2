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
@property (readwrite, assign) unsigned long long downloadedByteCount;
@property (readwrite, assign) NSTimeInterval startTime;
@property (readwrite, assign) NSTimeInterval lastTime;
@property (readwrite, strong) ZFDownloadSpec* downloadSpec; 
@end

@implementation ZFPhotoDownloader

@synthesize downloadedByteCount = _downloadedByteCount;
@synthesize downloadSpec = _downloadSpec;
@synthesize startTime = _startTime;
@synthesize lastTime = _lastTime;


- (id) initWithDownloadSpec:(ZFDownloadSpec*) downloadSpec {	
	self = [super init];
	if(self) {
		self.downloadSpec = downloadSpec;
	}
	return self;
}

+ (id) photoDownloader:(ZFDownloadSpec*) downloadSpec {
    return FLAutorelease([[[self class] alloc] initWithDownloadSpec:downloadSpec]);
}

- (void) httpRequest:(FLHttpRequest*) httpRequest didReadBytes:(NSNumber*) amount {
    self.downloadedByteCount += [amount longLongValue];
    self.lastTime = [NSDate timeIntervalSinceReferenceDate]; 
    
    FLPerformSelector2(self.delegate, @selector(photoDownloader:didReadBytes:), self, amount);
}

- (NSTimeInterval) elapsedTime {
    return self.lastTime - self.startTime;
}

- (void) performUntilFinished:(FLFinisher*) finisher { 
    [super performUntilFinished:finisher];
    
    NSString* filePath = _downloadSpec.fullPathToFile;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        FLPerformSelector1(self.delegate, @selector(photoDownloaderDidSkipPhoto:), self);
        [self setFinished];
    }
    else {
        FLHttpRequest* request = 
            [FLHttpRequest httpRequest:[self.downloadSpec.photo urlForImageWithSize:self.downloadSpec.mediaType]];

        self.startTime = [NSDate timeIntervalSinceReferenceDate];

    // TODO: abstract which sink is used    
        request.inputSink = [FLHiddenFolderFileSink hiddenFolderFileSink:filePath
                                                              folderPath:self.downloadSpec.tempFolder]; 

        request.delegate = self;
                         
        [self runChildAsynchronously:request completion:^(FLResult result) {
            self.lastTime = [NSDate timeIntervalSinceReferenceDate]; 
            
            if(![result error]) {
                FLPerformSelector1(self.delegate, @selector(photoDownloaderDidDownloadPhoto:), self);
            }
            
            [self setFinishedWithResult:result];
        }];
    }
}
@end
