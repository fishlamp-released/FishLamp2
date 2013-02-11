//
//	FLZenfolioRandomPhotoDownloader.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/1/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import <Foundation/Foundation.h>

#import "FLJpegFile.h"
#import "FLProgressViewController.h"
#import "FLAction.h"

typedef void (^FLZenfolioRandomDownloaderCompletionBlock)(FLJpegFile* file, NSError* error);

@protocol FLZenfolioRandomPhotoDownloaderDelegate;

@interface FLZenfolioRandomPhotoDownloader : NSObject {
@private
	NSMutableSet* _downloadedPhotos;
	id<FLProgressViewController> _mainProgress;
	FLWeakReference* _action;
	FLOperationContext* _operationContext;

	NSInteger _retryCount;
	BOOL _hasPhotosToChooseFrom;
    FLZenfolioRandomDownloaderCompletionBlock _completionBlock;
}

@property (readwrite, retain, nonatomic) FLOperationContext* actionContext;

- (void) requestCancel;

- (void) beginDownloadingRandomImage:(NSString*) progressString 
                     completionBlock:(FLZenfolioRandomDownloaderCompletionBlock) completionBlock;

- (void) beginLoadingSelectedPhoto:(FLZenfolioPhoto*) photo 
                    progressString:(NSString*) progressString
                   completionBlock:(FLZenfolioRandomDownloaderCompletionBlock) completionBlock;

@end
#endif