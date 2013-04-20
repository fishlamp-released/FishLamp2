//
//  ZFDownloadPhotoOperation.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "ZFDownloadPhotoOperation.h"
#import "FLHttpRequest.h"
#import "FLHiddenFolderFileSink.h"

@interface ZFDownloadPhotoOperation ()
@property (readwrite, assign) unsigned long long downloadedByteCount;
@property (readwrite, assign) NSTimeInterval startTime;
@property (readwrite, assign) NSTimeInterval lastTime;
@property (readwrite, strong) ZFDownloadSpec* downloadSpec; 
@end

@implementation ZFDownloadPhotoOperation

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

+ (id) downloadPhotoOperation:(ZFDownloadSpec*) downloadSpec {
    return FLAutorelease([[[self class] alloc] initWithDownloadSpec:downloadSpec]);
}

- (void) httpRequest:(FLHttpRequest*) httpRequest didReadBytes:(NSNumber*) amount {
    self.downloadedByteCount += [amount longLongValue];
    self.lastTime = [NSDate timeIntervalSinceReferenceDate]; 
}

- (NSTimeInterval) elapsedTime {
    return self.lastTime - self.startTime;
}

- (FLResult) performSynchronously { 
    
    if([[NSFileManager defaultManager] fileExistsAtPath:self.downloadSpec.destinationPath]) {
//        [self mediaExists:media 
//                 forPhoto:photo 
//                 filePath:[imageFolder pathForFile:fileName]];
    }
    else {
        FLHttpRequest* request = 
            [FLHttpRequest httpRequest:[self.downloadSpec.photo urlForImageWithSize:self.downloadSpec.mediaType]];

        self.startTime = [NSDate timeIntervalSinceReferenceDate];

    // TODO: abstract which sink is used    
        request.inputSink = [FLHiddenFolderFileSink hiddenFolderFileSink:self.downloadSpec.destinationPath 
                                                               folderPath:self.downloadSpec.hiddenFolderPath]; 

        request.asyncObserver = self;
                         
        FLResult result = [self runChildSynchronously:request];
        
        self.lastTime = [NSDate timeIntervalSinceReferenceDate]; 
        
        return result;
    }

    return FLSuccessfullResult;
}
@end
