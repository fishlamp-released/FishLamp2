////
////  ZFBatchPhotoDownloadOperation.h
////  ZenfolioDownloader
////
////  Created by patrick machielse on 20-8-07.
////  Copyright 2007 GreenTongue Software, LLC.. All rights reserved.
////
//
//#import "FLSynchronousOperation.h"
//#import "ZFGroupElementSelection.h"
//@class ZFPhotoSet;
//@class ZFPhoto;
//@class ZFGroup;
//
//@interface ZFBatchPhotoDownloadOperation : FLSynchronousOperation {
//@private
//    ZFGroup* _rootGroup;
//    NSString* _destination;		//	folder where the account is downloaded
//
//    NSMutableDictionary* _photoCache;		
//    NSMutableDictionary* _uniquePaths;		
//	
//    ZFGroupElementSelection* _selection;
//    ZFPhotoSet* _currentSet;		//	photoset currently being loaded
//	ZFPhoto* _currentPhoto;		//	photo currently being loaded
//	
//    long long _totalBytes;			//	total amount of bytes loaded
//	long long _bytesDownloaded;
//    int _photosDownloaded;
//    int _totalPhotoCount;		//	number of downloaded photos
//	int _totalSetCount;			//	number of downloaded photo sets
//	
//	NSDate* _startDate;			//	time when loading was (re)started
//	NSTimeInterval _loadTime;			//	total time spend downloading
//
//	BOOL _paused;				//	paused flag
//}
//
////	creation
//+ (id) photoLoader:(ZFGroup*) rootGroup destination:(NSString*) destination;
//
//// maybe this should be a copy??
//@property (readwrite, strong) ZFGroupElementSelection* selection;
//
//@property (readonly, strong) NSString* destination;
//
//@property (readonly, strong) ZFPhotoSet* currentSet;
//@property (readonly, strong) ZFPhoto* currentPhoto;
//
//@property (readonly, assign) int totalPhotoCount;
//@property (readonly, assign) int totalSetCount;
//@property (readonly, assign) long long totalBytes;
//
//@property (readonly, assign) long long bytesDownloaded;
//@property (readonly, assign) int photosDownloaded;
//
////@property (readonly, strong) NSDate* startDate;
//@property (readonly, assign) NSTimeInterval loadTime;
//
//@property (readonly, assign, getter=isPaused) BOOL paused;
//- (void) pauseDownload;
//
//@end
//
//@protocol ZFDownloadStateObserver <NSObject>
//- (void) batchPhotoDownloader:(ZFBatchPhotoDownloadOperation*) downloader didDownloadPhoto:(ZFPhoto*) photo;
//@end
