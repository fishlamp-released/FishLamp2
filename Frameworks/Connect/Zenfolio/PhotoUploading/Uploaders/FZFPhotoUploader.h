//
//	FLZenfolioPhotoUploader.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#if REFACTOR

#import <Foundation/Foundation.h>
#import "FLZenfolioUploadQueue.h"
#import "FLZenfolioSyncTask.h"
#import "FLRectLayout.h"

// UGH. This is a mess.

@protocol FLZenfolioPhotoUploaderDelegate;

#define FLZenfolioPhotoUploaderErrorDomain @"FLZenfolioPhotoUploaderErrorDomain"
#define FLZenfolioPhotoUploaderErrorUploadGalleryWasDeleted -3000
#define FLZenfolioPhotoUploaderErrorMissingUploadGallery -3001

#define FLZenfolioMissingUploadGalleryId @"FLZenfolioMissingUploadGalleryId"

typedef enum {
    FLZenfolioPhotoUploaderStateInit,
    
    FLZenfolioPhotoUploaderStateCheckUploadGalleries,

    FLZenfolioPhotoUploaderStateBeginUpload,
    FLZenfolioPhotoUploaderStateSaveToDevice,
    FLZenfolioPhotoUploaderStatePrepareImage,
    FLZenfolioPhotoUploaderStateUploadBytes,
    FLZenfolioPhotoUploaderStateUploadMetadata,
    FLZenfolioPhotoUploaderStateDone
}  FLZenfolioPhotoUploaderState;

@interface FLZenfolioPhotoUploader : FLZenfolioSyncTask {
@private
    FLZenfolioQueuedPhoto* _uploadingPhoto;
	FLJpegFile* _imageFile;

    FLZenfolioPhotoUploaderState _state;
	unsigned long long _bytesUploaded;
	unsigned long long _uploadSize;
    
    FLZenfolioUploadQueue* _uploadQueue;
}

- (id) initWithUploadQueue:(FLZenfolioUploadQueue*) uploadQueue;

@property (readonly, retain, nonatomic) FLZenfolioUploadQueue* uploadQueue;

@property (readonly, assign, nonatomic) FLZenfolioPhotoUploaderState uploadState;

@property (readwrite, retain, nonatomic) FLZenfolioQueuedPhoto* photo; 
@property (readwrite, retain, nonatomic) FLJpegFile* imageFile;

@property (readwrite, assign, nonatomic) unsigned long long bytesUploaded;
@property (readwrite, assign, nonatomic) unsigned long long uploadSize;

- (NSSet*) uploadGalleries;
- (unsigned long long) calculateInitialUploadSize;

- (void) _handleActionCompleteForState:(FLAction*) action;

/**
    This is called by client.
 */
- (void) createProgress:(FLRectLayout) progressLocation;

+ (NSString*) chooserPromptForError:(NSError*) error;

- (void) changeState:(FLZenfolioPhotoUploaderState) state;

- (FLZenfolioPhotoUploaderState) nextStateForState:(FLZenfolioPhotoUploaderState) state;

- (void) _didFinishWithError:(NSError*) error;

- (void) _updateProgress;

- (void) _beginCheckingUploadGalleries;
- (void) _beginUploadingBytes;
- (void) _beginUploadingMetaData;
- (void) _beginSavingPhotoToDevice;
- (void) _prepareUploadFile;

- (void) changeStateToNextState;

- (void) _handleDoneState;
- (void) _handleInitState;
- (void) _handleBeginUploadState;

- (void) _didUploadBytesNowUpdateCache:(id) operation;

- (void) _updateProgressWhileUploadingImage:(unsigned long long) amountWritten
    totalAmountWritten:(unsigned long long) totalAmountWritten
    totalAmountExpectedToWrite:(unsigned long long) totalAmountExpectedToWrite;

@end

@protocol FLZenfolioPhotoUploaderDelegate <NSObject>

- (void) photoUploader:(FLZenfolioPhotoUploader*) uploader 
     finishedWithError:(NSError*) error; // error can be a cancel error

@end


#endif



