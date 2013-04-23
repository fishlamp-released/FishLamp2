////
////  ZFDownloadQueue.m
////  FishLampConnect
////
////  Created by Mike Fullerton on 4/19/13.
////  Copyright (c) 2013 Mike Fullerton. All rights reserved.
////
//
//#import "ZFDownloadQueue.h"
//
//@interface ZFBatchQueue ()
//@property (readonly, nonatomic, strong) NSMutableArray* queue;
//@end
//
//@implementation ZFBatchQueue
//
//@synthesize queue = _queue;
//
//- (id) init {	
//	self = [super init];
//	if(self) {
//		_queue = [[NSMutableArray alloc] init];
//	}
//	return self;
//}
//
//#if FL_MRC
//- (void) dealloc {
//	[_queue release];
//	[super dealloc];
//}
//#endif
//
//- (void) addObject:(id) object {
//    [_queue addObject:object];
//}
//
//
//@end
//
//@interface ZFDownloadQueue ()
//
//@property (readwrite, assign) NSUInteger totalPhotoCount;
//@property (readwrite, assign) NSUInteger downloadedPhotoCount;
//@property (readwrite, assign) unsigned long long totalPhotoSize;
//@property (readwrite, assign) unsigned long long downloadedPhotoSize;
//
//@property (readwrite, assign) NSUInteger totalVideoCount;
//@property (readwrite, assign) NSUInteger downloadedVideoCount;
//@property (readwrite, assign) unsigned long long totalVideoSize;
//@property (readwrite, assign) unsigned long long downloadedVideoSize;
//
//@property (readwrite, assign) NSTimeInterval elapsedTime;
//
//@end
//
//@implementation ZFDownloadQueue
//@synthesize totalPhotoCount = _totalPhotoCount;
//@synthesize downloadedPhotoCount = _downloadedPhotoCount;
//@synthesize totalPhotoSize = _totalPhotoSize;
//@synthesize downloadedPhotoSize = _downloadedPhotoSize;
//@synthesize totalVideoCount = _totalVideoCount;
//@synthesize downloadedVideoCount = _downloadedVideoCount;
//@synthesize totalVideoSize = _totalVideoSize;
//@synthesize downloadedVideoSize = _downloadedVideoSize;
//@synthesize elapsedTime = _elapsedTime;
//
//- (void) addObject:(id) object {
//    [super addObject:object];
//    
//    if([[object photo] IsVideoValue]) {
//        self.totalVideoCount++;
//        self.totalVideoSize += [[object photo] SizeValue];
//    }
//    else {
//        self.totalPhotoCount++;
//        self.totalPhotoSize += [[object photo] SizeValue];
//    }
//}
//
//+ (id) downloadQueue {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//- (ZFDownloadSpec*) popDownloadSpec {
//    if(self.queue.count) {
//        ZFDownloadSpec* first = FLRetainWithAutorelease([self.queue objectAtIndex:0]);
//        [self.queue removeObjectAtIndex:0];
//        return first;
//    }
//        
//    return nil;
//}
//
//@end
