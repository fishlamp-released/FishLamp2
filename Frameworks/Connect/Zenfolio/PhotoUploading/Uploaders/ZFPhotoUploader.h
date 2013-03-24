//
//	ZFPhotoUploader.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#if REFACTOR

#import <Foundation/Foundation.h>
#import "ZFUploadQueue.h"
#import "ZFSyncTask.h"
#import "FLRectLayout.h"

// UGH. This is a mess.

@protocol ZFPhotoUploaderDelegate;

#define ZFPhotoUploaderErrorDomain @"ZFPhotoUploaderErrorDomain"
#define ZFPhotoUploaderErrorUploadGalleryWasDeleted -3000
#define ZFPhotoUploaderErrorMissingUploadGallery -3001

#define ZFMissingUploadGalleryId @"ZFMissingUploadGalleryId"

typedef enum {
    ZFPhotoUploaderStateInit,
    
    ZFPhotoUploaderStateCheckUploadGalleries,

    ZFPhotoUploaderStateBeginUpload,
    ZFPhotoUploaderStateSaveToDevice,
    ZFPhotoUploaderStatePrepareImage,
    ZFPhotoUploaderStateUploadBytes,
    ZFPhotoUploaderStateUploadMetadata,
    ZFPhotoUploaderStateDone
}  ZFPhotoUploaderState;

@interface ZFPhotoUploader : ZFSyncTask {
@private
    ZFQueuedPhoto* _uploadingPhoto;
	FLJpegFile* _imageFile;

    ZFPhotoUploaderState _state;
	unsigned long long _bytesUploaded;
	unsigned long long _uploadSize;
    
    ZFUploadQueue* _uploadQueue;
}

- (id) initWithUploadQueue:(ZFUploadQueue*) uploadQueue;

@property (readonly, retain, nonatomic) ZFUploadQueue* uploadQueue;

@property (readonly, assign, nonatomic) ZFPhotoUploaderState uploadState;

@property (readwrite, retain, nonatomic) ZFQueuedPhoto* photo; 
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

- (void) changeState:(ZFPhotoUploaderState) state;

- (ZFPhotoUploaderState) nextStateForState:(ZFPhotoUploaderState) state;

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

@protocol ZFPhotoUploaderDelegate <NSObject>

- (void) photoUploader:(ZFPhotoUploader*) uploader 
     finishedWithError:(NSError*) error; // error can be a cancel error

@end


#endif



