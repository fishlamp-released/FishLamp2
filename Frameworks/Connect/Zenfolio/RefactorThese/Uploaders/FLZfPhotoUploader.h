//
//	FLZfPhotoUploader.h
//	MyZen
//
//	Created by Mike Fullerton on 9/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#if REFACTOR

#import <Foundation/Foundation.h>
#import "FLZfUploadQueue.h"
#import "FLZfSyncTask.h"
#import "FLRectLayout.h"

// UGH. This is a mess.

@protocol FLZfPhotoUploaderDelegate;

#define FLZfPhotoUploaderErrorDomain @"FLZfPhotoUploaderErrorDomain"
#define FLZfPhotoUploaderErrorUploadGalleryWasDeleted -3000
#define FLZfPhotoUploaderErrorMissingUploadGallery -3001

#define FLZfMissingUploadGalleryId @"FLZfMissingUploadGalleryId"

typedef enum {
    FLZfPhotoUploaderStateInit,
    
    FLZfPhotoUploaderStateCheckUploadGalleries,

    FLZfPhotoUploaderStateBeginUpload,
    FLZfPhotoUploaderStateSaveToDevice,
    FLZfPhotoUploaderStatePrepareImage,
    FLZfPhotoUploaderStateUploadBytes,
    FLZfPhotoUploaderStateUploadMetadata,
    FLZfPhotoUploaderStateDone
}  FLZfPhotoUploaderState;

@interface FLZfPhotoUploader : FLZfSyncTask {
@private
    FLZfQueuedPhoto* _uploadingPhoto;
	FLJpegFile* _imageFile;

    FLZfPhotoUploaderState _state;
	unsigned long long _bytesUploaded;
	unsigned long long _uploadSize;
    
    FLZfUploadQueue* _uploadQueue;
}

- (id) initWithUploadQueue:(FLZfUploadQueue*) uploadQueue;

@property (readonly, retain, nonatomic) FLZfUploadQueue* uploadQueue;

@property (readonly, assign, nonatomic) FLZfPhotoUploaderState uploadState;

@property (readwrite, retain, nonatomic) FLZfQueuedPhoto* photo; 
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

- (void) changeState:(FLZfPhotoUploaderState) state;

- (FLZfPhotoUploaderState) nextStateForState:(FLZfPhotoUploaderState) state;

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

@protocol FLZfPhotoUploaderDelegate <NSObject>

- (void) photoUploader:(FLZfPhotoUploader*) uploader 
     finishedWithError:(NSError*) error; // error can be a cancel error

@end


#endif



