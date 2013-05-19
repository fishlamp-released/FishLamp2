//
//	FLCameraPhotoViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/31/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCameraPhotoViewController.h"
#import "FLJpegFile.h"
#import "FLFolder.h"
#import "FLCameraViewController.h"
#import "FLSaveScaledImagesWithOriginalImage.h"
#import "FLCameraExifViewController.h"
#import "FLLegacyProgressView.h"

#if FL_CUSTOM_CAMERA
#if __IPHONE_4_0
@implementation FLCameraPhotoViewController

- (id) initWithArrayOfCameraPhotos:(NSMutableArray*) array	folder:(FLFolder*) folder
{
	if(self = [super initWithNibNameAndPhotoCount:@"FLCameraPhotoView" photoCount:array.count currentPhotoIndex:array.count-1])
	{
        [self createActionContext];
    
		_folder = FLRetain(folder);
		_array = FLRetain(array);
		self.title = NSLocalizedString(@"Lightbox", nil);
		self.photoViewControllerDelegate = self;
		
		[self setOptions:YES showBalloon:NO showComposeButton:NO];
	}
	
	return self;
}

- (void) showExif:(id) sender
{
	NSDictionary* exif = [[_array objectAtIndex:self.currentPhotoIndex] original].properties;

	FLCameraExifViewController* controller = [[FLCameraExifViewController alloc] init];
	controller.exifBuilder.masterExif = exif;
	[self.navigationController pushViewController:controller animated:YES];
	FLRelease(controller);
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	// add compose button
	UIBarButtonItem* exifButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"info-white.png"]
		style:UIBarButtonItemStylePlain
		target:self
		action:@selector(showExif:)];
	[self.navigationItem setRightBarButtonItem:exifButton];
	FLRelease(exifButton);

}

- (void) dealloc
{
	FLReleaseWithNil(_folder);
	FLReleaseWithNil(_array);
	FLSuperDealloc();
}

- (IBAction) rotateLeft:(id) sender
{
	[self.centerView.imageView rotateImageByDegrees:-90];
}

- (IBAction) rotateRight:(id) sender
{
	[self.centerView.imageView rotateImageByDegrees:90];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 1)
	{
		NSUInteger idx = self.currentPhotoIndex;
		[[_array objectAtIndex:idx] deleteFiles];
		[_array removeObjectAtIndex:idx];
		[self handleUserDeletedPhotoAtCurrentPhotoIndex];
	}
}

- (IBAction) handleDeletePress:(id) sender
{
	[super handleDeletePress:sender];
	
	FLAlert* alert = [FLAlert alertViewController:@"Remove this photo from your Lightbox?" 
				message:@"This will permanently delete the photo and cannot be undone." 
				delegate:self
				cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
		
	[alert showViewControllerAnimated:YES];
	FLReleaseWithNil(alert);
}

- (void) photoViewController:(FLPhotoViewController*) photoViewController 
	actionDidComplete:(FLAction*) action
	loadingState:(FLPhotoViewLoadingState*) loadingState
{
	if(action.didSucceed)
	{
		FLJpegFileImageAsset* photo = [[action lastOperation] operationOutput];

		if(photo.fullScreen.hasImage)
		{
			[self updatePhotoView:loadingState.photoView withImage:photo.fullScreen.image forImageSize:FLPhotoViewImageSizeFullScreen];
		}
		else if(photo.original.hasImage)
		{
			[self updatePhotoView:loadingState.photoView withImage:photo.original.image forImageSize:FLPhotoViewImageSizeHighResolution];
		}
	}
}

- (FLAction*) photoViewController:(FLPhotoViewController*) photoViewController 
	createLoadAction:(FLPhotoViewLoadingState*) loadingState
{
FLAssertFailedWithComment(@"incomment and fix this");
//	  BOOL showProgress = YES;
//	FLCameraPhoto* photo = (FLCameraPhoto*) loadingState.photoView.displayPhoto;
//	  if(photo.original.hasImage)
//	  {
//		  showProgress = NO;
//		  [self updatePhotoView:loadingState.photoView withImage:photo.original.image];
//	  }

	FLAction* action = [FLAction actionWithActionContext:self.actionContext];
//	  if(showProgress)
//	  {
//		  action.progressController = [FLLegacyProgressView defaultProgressView];
//	  }
//	  [action.progressView setStartDelay:0.3]; 
//	[action.progressView setAutoLayoutMode:FLRectLayoutMake( FLRectLayoutHorizontalCentered, FLRectLayoutVerticalBottom)];
//	  [action.progressView setProgressViewAlpha:0.4];
//	  action.actionDescription.actionType = FLActionDescriptionTypeLoad;
//	  
//	  FLBitFlags_t options = 0;
//	  if(loadingState.imageSize == FLPhotoViewImageSizeHighResolution)
//	  {
//		  options = FLLoadOriginal;
//		  action.actionDescription.actionItemName = FLActionDescriptionItemNameHighResolutionPhoto;
//	  }
//	  else
//	  {
//		  options = FLLoadFullScreen|FLLoadThumbnail;
//		  action.actionDescription.actionItemName = FLActionDescriptionItemNamePhoto;
//	  }
//
//	  FLSaveScaledImagesWithOriginalImage* operation = [[FLSaveScaledImagesWithOriginalImage alloc] 
//			  initWithPhotoInput:photo
//			  folder:_folder			 
//			  saveOptions:options];
//	  [action addOperation:operation];
//	  FLReleaseWithNil(operation);
	
	return action;
}
	
- (id) photoViewController:(FLPhotoViewController*) controller photoAtIndex:(NSUInteger) idx
{
	return [_array objectAtIndex:idx];
}

- (void) photoViewController:(FLPhotoViewController*) controller 
	releaseMemoryForPhotoView:(FLPhotoView*) photoView
	photoAtIndex:(NSUInteger) idx
{
	[photoView resetState];
	FLCameraPhoto* photo = [_array objectAtIndex:idx];
	[photo.original releaseImageAndJpegData];
	[photo.fullScreen releaseImageAndJpegData];
}

- (NSString*) photoViewGetFailedToLoadStringForDisplay:(FLPhotoView*) view
{
	return NSLocalizedString(@"Failed to load photo.", nil);
}
- (NSString*) photoViewGetNameOfDetailsStringForDisplay:(FLPhotoView*) view
{
	return @"";
}
- (NSString*) photoViewGetEmptyDetailsStringForDisplay:(FLPhotoView*) view
{
	return @"";
}

- (void) _updateTitle
{

}	

- (NSString*) photoViewController:(FLPhotoViewController*) controller
		   detailsForPhotoAtIndex:(NSUInteger) idx
{
	return @""; // [[_photoSet photoAtIndex:idx] Caption];
}

- (NSString*) photoViewController:(FLPhotoViewController*) controller
			 titleForPhotoAtIndex:(NSUInteger) idx
{
	return @""; // [[_photoSet photoAtIndex:idx] displayName];
}

@end

#endif
#endif