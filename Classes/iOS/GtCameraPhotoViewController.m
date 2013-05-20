//
//	GtCameraPhotoViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/31/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCameraPhotoViewController.h"
#import "GtJpegFile.h"
#import "GtFolder.h"
#import "GtCameraViewController.h"
#import "GtSaveScaledImagesWithOriginalImage.h"
#import "GtCameraExifViewController.h"
#import "GtOldProgressView.h"

#if GT_CUSTOM_CAMERA
#if __IPHONE_4_0
@implementation GtCameraPhotoViewController

- (id) initWithArrayOfCameraPhotos:(NSMutableArray*) array	folder:(GtFolder*) folder
{
	if(self = [super initWithNibNameAndPhotoCount:@"GtCameraPhotoView" photoCount:array.count currentPhotoIndex:array.count-1])
	{
        [self createActionContext];
    
		m_folder = GtRetain(folder);
		m_array = GtRetain(array);
		self.title = NSLocalizedString(@"Lightbox", nil);
		self.photoViewControllerDelegate = self;
		
		[self setOptions:YES showBalloon:NO showComposeButton:NO];
	}
	
	return self;
}

- (void) showExif:(id) sender
{
	NSDictionary* exif = [[m_array objectAtIndex:self.currentPhotoIndex] original].properties;

	GtCameraExifViewController* controller = [[GtCameraExifViewController alloc] init];
	controller.exifBuilder.masterExif = exif;
	[self.navigationController pushViewController:controller animated:YES];
	GtRelease(controller);
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
	GtRelease(exifButton);

}

- (void) dealloc
{
	GtReleaseWithNil(m_folder);
	GtReleaseWithNil(m_array);
	GtSuperDealloc();
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
		[[m_array objectAtIndex:idx] deleteFiles];
		[m_array removeObjectAtIndex:idx];
		[self handleUserDeletedPhotoAtCurrentPhotoIndex];
	}
}

- (IBAction) handleDeletePress:(id) sender
{
	[super handleDeletePress:sender];
	
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Remove this photo from your Lightbox?" 
				message:@"This will permanently delete the photo and cannot be undone." 
				delegate:self
				cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
		
	[alert show];
	GtReleaseWithNil(alert);
}

- (void) photoViewController:(GtPhotoViewController*) photoViewController 
	actionDidComplete:(GtAction*) action
	loadingState:(GtPhotoViewLoadingState*) loadingState
{
	if(action.didFinishWithoutError)
	{
		GtJpegFileImageAsset* photo = [[action lastOperation] operationOutput];

		if(photo.fullScreen.hasImage)
		{
			[self updatePhotoView:loadingState.photoView withImage:photo.fullScreen.image forImageSize:GtPhotoViewImageSizeFullScreen];
		}
		else if(photo.original.hasImage)
		{
			[self updatePhotoView:loadingState.photoView withImage:photo.original.image forImageSize:GtPhotoViewImageSizeHighResolution];
		}
	}
}

- (GtAction*) photoViewController:(GtPhotoViewController*) photoViewController 
	createLoadAction:(GtPhotoViewLoadingState*) loadingState
{
GtAssertFailed(@"incomment and fix this");
//	  BOOL showProgress = YES;
//	GtCameraPhoto* photo = (GtCameraPhoto*) loadingState.photoView.displayPhoto;
//	  if(photo.original.hasImage)
//	  {
//		  showProgress = NO;
//		  [self updatePhotoView:loadingState.photoView withImage:photo.original.image];
//	  }

	GtAction* action = [GtAction actionWithActionContext:self.actionContext];
//	  if(showProgress)
//	  {
//		  action.progressView = [GtOldProgressView defaultProgressView];
//	  }
//	  [action.progressView setStartDelay:0.3]; 
//	[action.progressView setAutoLayoutMode:GtRectLayoutMake( GtRectLayoutHorizontalCentered, GtRectLayoutVerticalBottom)];
//	  [action.progressView setProgressViewAlpha:0.4];
//	  action.actionDescription.actionType = GtActionDescriptionTypeLoad;
//	  
//	  GtBitMask options = 0;
//	  if(loadingState.imageSize == GtPhotoViewImageSizeHighResolution)
//	  {
//		  options = GtLoadOriginal;
//		  action.actionDescription.itemName = GtActionDescriptionItemNameHighResolutionPhoto;
//	  }
//	  else
//	  {
//		  options = GtLoadFullScreen|GtLoadThumbnail;
//		  action.actionDescription.itemName = GtActionDescriptionItemNamePhoto;
//	  }
//
//	  GtSaveScaledImagesWithOriginalImage* operation = [[GtSaveScaledImagesWithOriginalImage alloc] 
//			  initWithPhotoInput:photo
//			  folder:m_folder			 
//			  saveOptions:options];
//	  [action queueOperation:operation];
//	  GtReleaseWithNil(operation);
	
	return action;
}
	
- (id) photoViewController:(GtPhotoViewController*) controller photoAtIndex:(NSUInteger) idx
{
	return [m_array objectAtIndex:idx];
}

- (void) photoViewController:(GtPhotoViewController*) controller 
	releaseMemoryForPhotoView:(GtPhotoView*) photoView
	photoAtIndex:(NSUInteger) idx
{
	[photoView resetState];
	GtCameraPhoto* photo = [m_array objectAtIndex:idx];
	[photo.original releaseImageAndJpegData];
	[photo.fullScreen releaseImageAndJpegData];
}

- (NSString*) photoViewGetFailedToLoadStringForDisplay:(GtPhotoView*) view
{
	return NSLocalizedString(@"Failed to load photo.", nil);
}
- (NSString*) photoViewGetNameOfDetailsStringForDisplay:(GtPhotoView*) view
{
	return @"";
}
- (NSString*) photoViewGetEmptyDetailsStringForDisplay:(GtPhotoView*) view
{
	return @"";
}

- (void) _updateTitle
{

}	

- (NSString*) photoViewController:(GtPhotoViewController*) controller
		   detailsForPhotoAtIndex:(NSUInteger) idx
{
	return @""; // [[m_photoSet photoAtIndex:idx] Caption];
}

- (NSString*) photoViewController:(GtPhotoViewController*) controller
			 titleForPhotoAtIndex:(NSUInteger) idx
{
	return @""; // [[m_photoSet photoAtIndex:idx] displayName];
}

@end

#endif
#endif