//
//  FLZenfolioBatchPhotoDownloadOperation.h
//  ZenfolioDownloader
//
//  Created by patrick machielse on 20-8-07.
//  Copyright 2007 GreenTongue Software, LLC.. All rights reserved.
//

#import "FLZenfolioWebApi.h"
#import "FLOperation.h"
#import "FLZenfolioGroupElementSelection.h"

@interface FLZenfolioBatchPhotoDownloadOperation : FLOperation {
@private
    FLZenfolioGroup* _rootGroup;
    NSString* _destination;		//	folder where the account is downloaded

    NSMutableDictionary* _photoCache;		
    NSMutableDictionary* _uniquePaths;		
	
    FLZenfolioGroupElementSelection* _selection;
    FLZenfolioPhotoSet* _currentSet;		//	photoset currently being loaded
	FLZenfolioPhoto* _currentPhoto;		//	photo currently being loaded
	
    long long _totalBytes;			//	total amount of bytes loaded
	long long _bytesDownloaded;
    int _photosDownloaded;
    int _totalPhotoCount;		//	number of downloaded photos
	int _totalSetCount;			//	number of downloaded photo sets
	
	NSDate* _startDate;			//	time when loading was (re)started
	NSTimeInterval _loadTime;			//	total time spend downloading

	BOOL _paused;				//	paused flag
}

//	creation
+ (id) photoLoader:(FLZenfolioGroup*) rootGroup destination:(NSString*) destination;

// maybe this should be a copy??
@property (readwrite, strong) FLZenfolioGroupElementSelection* selection;

@property (readonly, strong) NSString* destination;

@property (readonly, strong) FLZenfolioPhotoSet* currentSet;
@property (readonly, strong) FLZenfolioPhoto* currentPhoto;

@property (readonly, assign) int totalPhotoCount;
@property (readonly, assign) int totalSetCount;
@property (readonly, assign) long long totalBytes;

@property (readonly, assign) long long bytesDownloaded;
@property (readonly, assign) int photosDownloaded;

//@property (readonly, strong) NSDate* startDate;
@property (readonly, assign) NSTimeInterval loadTime;

@property (readonly, assign, getter=isPaused) BOOL paused;
- (void) pauseDownload;

@end

@protocol FLZenfolioDownloadStateObserver <NSObject>
- (void) batchPhotoDownloader:(FLZenfolioBatchPhotoDownloadOperation*) downloader didDownloadPhoto:(FLZenfolioPhoto*) photo;
@end
