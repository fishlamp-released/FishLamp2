//
//  GtMediaPicker.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/5/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtMediaPicker.h"
#import "GtLowMemoryHandler.h"
#import "GtSaveCameraImage.h"
#import "GtAction.h"
#import "GtGeometry.h"

@implementation GtMediaPicker


#if TEST_PICTURE_UI

static BOOL	s_isFakePicture = NO;
#endif

GtSynthesizeSingleton(GtMediaPicker);

- (id) init
{
	if(self = [super init])
	{
		m_picker = [GtAlloc(UIImagePickerController) init];
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_actionContext);
	[m_picker release];
	[super dealloc];
}

- (void) createActionContext
{
	GtReleaseWithNil(m_actionContext); // just in case
	m_actionContext = [GtAlloc(GtManagedActionContext) initAndActivate:YES];
    
#if DEBUG
    [m_actionContext setDelegateTypeWithClass:[self class]];
#endif
 }

- (void) beginChoosePhotoFromLibrary:(UIViewController*) inController 
	animated:(BOOL) animated 
	delegate:(id) inDelegate
{
    [self createActionContext];
    
	m_delegate = inDelegate;

	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) 
	{
		m_picker.delegate = self;
		m_picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#if FISHLAMP_IPHONE_2_SDK
		m_picker.allowsImageEditing = NO;
#endif
		[GtLowMemoryHandler broadcastReleaseMessage];

		[inController presentModalViewController:m_picker animated:YES];
	}
}

- (void) beginTakePhoto:(UIViewController*) inController 
	animated:(BOOL) animated 
	delegate:(id) inDelegate
{
    [self createActionContext];

	m_delegate = inDelegate;

#if TEST_PICTURE_UI
	s_isFakePicture = NO;
	if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
	{
		s_isFakePicture = YES;
		[self beginChoosePhotoFromLibrary:inController animated:animated delegate:inDelegate];
		return;
	}

#endif
	
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) 
	{
		m_picker.delegate = self;
		m_picker.sourceType = UIImagePickerControllerSourceTypeCamera;
#if FISHLAMP_IPHONE_2_SDK
		m_picker.allowsImageEditing = NO;
#endif
		[GtLowMemoryHandler broadcastReleaseMessage];

		[inController presentModalViewController:m_picker animated:YES];
	}
}

- (void) dismissPicker:(BOOL) animated
{
	[m_picker dismissModalViewControllerAnimated:animated];
	GtReleaseWithNil(m_actionContext);
}

- (void) onSaveImage:(GtAction*) action
{
    if(action.didSucceed)
    {
        id del = m_delegate;
        m_delegate = nil;
        [del mediaPicker:self didFinishPickingImage: [[[action lastOperationOutput] retain] autorelease]

    #if TEST_PICTURE_UI
            isCameraImage:s_isFakePicture || (m_picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    #else
            isCameraImage:(m_picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    #endif
            ];
            
#if TEST_PICTURE_UI
        s_isFakePicture = NO;
#endif
    }
}

- (void) handleGotNewImage:(UIImage*) image
{
	UIView* pickerView = m_picker.view;

	GtSaveCameraImage* saveOperation = [GtAlloc(GtSaveCameraImage) initWithImageInput:image];
	
	GtAction* action = [GtAlloc(GtAction) initWithOperation:saveOperation];
	GtRelease(saveOperation);
	
	[action setCompletedCallback:self selector:@selector(onSaveImage:)];
	action.context = m_actionContext;
	action.progress.superview = pickerView; 
	action.progress.isModal = YES;
    action.progress.text = @"Saving...";
	action.errorStringForUser = @"save photo";
	
    if([m_delegate respondsToSelector:@selector(mediaPicker:configureActionProgress:)])
    {
        [m_delegate mediaPicker:self configureActionProgress:action];
    }
    
	[action beginAction];
		
	GtRelease(action);
}

#if FISHLAMP_IPHONE_2_SDK
- (void)imagePickerController:(UIImagePickerController *)picker 
	didFinishPickingImage:(UIImage *)image 
	editingInfo:(NSDictionary *)editingInfo
{
	[self handleGotNewImage:image];
}
#endif

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[self handleGotNewImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{

#if TEST_PICTURE_UI
	s_isFakePicture = NO;
#endif

	id del = m_delegate;
	m_delegate = nil;
	if([del respondsToSelector:@selector(mediaPickerDidCancel:)])
	{
		[del mediaPickerDidCancel:self];
	}
	else
	{
		[self dismissPicker:YES];
	}
}

@end
