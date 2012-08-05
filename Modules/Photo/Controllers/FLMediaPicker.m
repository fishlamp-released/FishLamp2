
//
//	FLMediaPicker.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/5/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLMediaPicker.h"
#import "FLLowMemoryHandler.h"
#import "FLSaveImageAssetToStorageOperation.h"
#import "FLAction.h"
#import "FLGeometry.h"
#import "FLToolbarButtonbarView.h"
#import "FLHtmlHelpViewController.h"
#import "FLTimer.h"
#import "NSFileManager+FLExtras.h"
#import "FLGpsUtilities.h"
#import "FLOldUserNotificationView.h"
#import "FLModalPopoverController.h"
#import "NSString+GUID.h"
#import "FLUserSession.h"
#import "FLJpegFileImageAsset.h"
#import "UIImage+FLColorize.h"
#import "FLGpsUtilities.h"
#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"


@interface FLOverlayCameraView : UIView {
@private    
    UILabel* m_label;
}
- (void) setText:(NSString*) text;
@end

@implementation FLOverlayCameraView
- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        m_label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 18)];
        m_label.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        m_label.textColor = [UIColor lightGrayColor];
        m_label.shadowColor = [UIColor blackColor];
        m_label.textAlignment = UITextAlignmentRight;
        m_label.backgroundColor = [UIColor clearColor];
        [self addSubview:m_label];
    }
    
    return self;
}

- (void) setText:(NSString*) text
{
    m_label.text = text;
}

- (void) dealloc
{
    FLRelease(m_label);
    FLSuperDealloc();
}

- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}

- (void) layoutSubviews
{
    m_label.frameOptimizedForSize = FLRectSetOrigin(m_label.frame, self.bounds.size.width - m_label.frame.size.width - 10, self.frame.size.height - 80);
    [super layoutSubviews];
}

@end


@implementation FLMediaPicker

BOOL s_promptDismissed = NO;

@synthesize savedImageCount = m_savedImageCount;

FLSynthesizeSingleton(FLMediaPicker);

FLSynthesizeStructProperty(animated, setAnimated, BOOL, m_flags);
FLSynthesizeStructProperty(busy, setBusy, BOOL, m_flags);

- (id) init
{
	if((self = [super init]))
	{
	}
	
	return self;
}

- (void) dealloc
{
	if(m_locationManager)
	{
		m_locationManager.delegate=nil;
		FLReleaseWithNil(m_locationManager);
	}
	FLReleaseWithNil(m_helpFileName);
	if(m_actionContext)
	{
		m_actionContext.actionContextDelegate = nil;
		FLReleaseWithNil(m_actionContext);
	}
    FLRelease(m_overlayView);
    m_picker.delegate = nil;
	FLRelease(m_picker);
	FLSuperDealloc();
}

- (UIViewController*) actionContextGetViewController:(FLActionContext*) context
{
	return m_picker;
}

- (void) createActionContext
{
	FLReleaseWithNil(m_actionContext); // just in case
	m_actionContext = [[FLManagedActionContext alloc] initAndActivate:YES];
	m_actionContext.actionContextDelegate = self;
}
 
- (void) notificationViewUserClosed:(FLOldNotificationView*) view
{
	s_promptDismissed = YES;
}

- (void) done:(id) sender
{
	[self imagePickerControllerDidCancel:m_picker];
}

//- (void) _setButtonImage:(UIButton*) button
//{
//    if(m_flags.locationEnabled)
//    {
//        [button setImage:[[UIImage imageNamed:@"map-marker.png"] colorizeImage:[UIColor greenColor] blendMode:kCGBlendModeOverlay ] forState:UIControlStateNormal];
//    }
//    else
//    {
//        [button setImage:[[UIImage imageNamed:@"map-marker.png"] colorizeImage:[UIColor whiteColor] blendMode:kCGBlendModeOverlay ] forState:UIControlStateNormal];
//    }
//}

//- (void) _showDeniedAlert
//{
//    FLAlertViewController* alertView = [FLAlertViewController alertViewController:@"Location Services are not enabled" message:@"To fix this..."];
        //delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
//    [alertView presentViewControllerAnimated:YES];
//}

- (void) _startLocationManager
{
    if(m_flags.locationEnabled && !m_locationManager)
    {
    	if([CLLocationManager locationServicesEnabled])
        {
            switch([CLLocationManager authorizationStatus])
            {
                case kCLAuthorizationStatusNotDetermined:
                case kCLAuthorizationStatusAuthorized:
                    m_locationManager =[[CLLocationManager alloc] init];
                    m_locationManager.delegate=self;
                    m_locationManager.desiredAccuracy=kCLLocationAccuracyBest;
                    m_locationManager.purpose = NSLocalizedString(@"Store GPS Location data in Photo EXIF", nil);
                    [m_locationManager startUpdatingLocation];
                break;
                
                default:
//                    [self _showDeniedAlert];
                break;
            }
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
	fromLocation:(CLLocation *)oldLocation
{
    if( newLocation.coordinate.longitude != oldLocation.coordinate.longitude ||
        newLocation.coordinate.latitude != oldLocation.coordinate.latitude)
    {
        [m_overlayView setText:FLPrettyStringForCoordinate(newLocation.coordinate)];
    }
}

- (void)locationManager:(CLLocationManager *)manager
	didFailWithError:(NSError *)error
{
    if(error.code == kCLErrorDenied)
    {
//        [self _showDeniedAlert];
    }

    m_flags.locationEnabled = NO;
//    [self _setButtonImage:m_overlayView.button];
    
    [m_locationManager stopUpdatingLocation];
    FLReleaseWithNil(m_locationManager);
}

//- (void) _toggleButton:(UIButton*) button
//{
//    m_flags.locationEnabled = !m_flags.locationEnabled;
//
//    if(m_flags.locationEnabled)
//    {
//        [self _startLocationManager];
//    }
//
//    [self _setButtonImage:button];
//}

- (void)navigationController:(UINavigationController *)navigationController 
	willShowViewController:(UIViewController *)viewController 
	animated:(BOOL)animated
{
	if(self.sourceType != UIImagePickerControllerSourceTypeCamera)
	{
		UIBarButtonItem* newItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
			target:self
			action:@selector(done:)];
		viewController.navigationItem.rightBarButtonItem = newItem;
		FLReleaseWithNil(newItem);
	}
}

- (void) _initPicker:(UIImagePickerControllerSourceType) sourceType 
	delegate:(id) inDelegate
{
	if(!m_picker)
	{
		m_picker = [[UIImagePickerController alloc] init];
    }

	self.busy = YES;
	m_savedImageCount = 0;
	
	m_delegate = inDelegate;
	[self createActionContext];

	m_picker.delegate = self;
	m_picker.sourceType = sourceType;

    if(OSVersionIsAtLeast4_1() && m_flags.locationEnabled)
    {
        if(m_picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            m_overlayView = FLReturnAutoreleased([[FLOverlayCameraView alloc] initWithFrame:CGRectMake(0,50,320,480)]);
            m_overlayView.userInteractionEnabled = YES;
            m_overlayView.exclusiveTouch = NO;
            m_overlayView.multipleTouchEnabled = YES;
            m_overlayView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
            m_overlayView.autoresizesSubviews = NO;
            m_overlayView.backgroundColor = [UIColor clearColor];
            m_picker.cameraOverlayView = m_overlayView;
        }
    }

/*

// this has a fatal flaw

// This button in the overlay view doesn't really work. The problem
// is that if you tap on it, the autofocus kicks in for the point the user tapped.
// I don't know how to disable the autofocus for the case of tapping
// on the button, short of drastic hacks.
//
// The alternative is to provide all our own controls, but then
// we might as well just used the FL custom camera code.


    if(OSVersionIsAtLeast4_1())
    {
        if(m_picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            m_overlayView = [[[FLOverlayCameraView alloc] initWithFrame:CGRectMake(0,50,320,480)] autorelease];
            m_overlayView.userInteractionEnabled = YES;
            m_overlayView.exclusiveTouch = NO;
            m_overlayView.multipleTouchEnabled = YES;
            m_overlayView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
            m_overlayView.autoresizesSubviews = NO;
            m_overlayView.backgroundColor = [UIColor clearColor];
            
            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
            [self _setButtonImage:button];
            [button addTarget:self action:@selector(_toggleButton:) forControlEvents:UIControlEventTouchUpInside];
            button.enabled = YES;
            button.showsTouchWhenHighlighted = YES;
            button.frame = CGRectMake(0, 0, 80, 80);
            button.autoresizesSubviews = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
            [m_overlayView addSubview:button];
            m_overlayView.button = button;
            
            m_picker.cameraOverlayView = m_overlayView;
        }
    }
 */
}

#if DEPRECATED_ASSETS_PICKER
- (void) beginChoosePhotoFromLibraryWithDelegate:(id<FLMediaPickerDelegate>) inDelegate
{
	if(!self.busy)
	{
		[self _initPicker:UIImagePickerControllerSourceTypePhotoLibrary 
				 delegate:inDelegate 
				];
	}
}
#endif

- (void) presentModallyInViewController:(UIViewController*) viewController animated:(BOOL) animated
{
	m_controller = viewController;
	self.animated = animated;
	
	[m_controller presentModalViewController:self.picker animated:animated];
}

- (FLModalPopoverController*) presentModallyInPopoverFromViewController:(UIViewController*) viewController animate:(BOOL) animated
{
	self.animated = animated;
	
	m_popoverController = [FLModalPopoverController presentViewController:self.picker 
		inViewController:viewController 
		permittedArrowDirections:0 
		fromRect:CGRectZero 
		animated:animated 
		isModal:YES];
	
	return m_popoverController;
}

- (FLModalPopoverController*) presentInPopoverFromViewController:(UIViewController*) viewController 
	permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
	fromRect:(CGRect) rect
	animate:(BOOL) animated
{
	self.animated = animated;
	
	m_popoverController = [FLModalPopoverController presentViewController:self.picker 
		inViewController:viewController 
		permittedArrowDirections:arrowDirections 
		fromRect:rect 
		animated:animated 
		isModal:YES];
	
	return m_popoverController;
}

- (void) beginTakePhoto:(UIViewController*) inController 
	animated:(BOOL) animated 
	delegate:(id<FLMediaPickerDelegate>) inDelegate
    geoTagPhoto:(BOOL) geoTagPhoto
{
    m_flags.locationEnabled = geoTagPhoto;

    [self _startLocationManager];

	if(!self.busy)
	{
		[self _initPicker:UIImagePickerControllerSourceTypeCamera 
				 delegate:inDelegate 
		 ];
		 self.animated = YES;
		m_controller = inController;
		[m_controller presentModalViewController:m_picker animated:animated];
	}
}

-(UIImagePickerController*) picker
{
	return m_picker;
}

- (void) _cleanupPicker
{
	m_actionContext.actionContextDelegate = nil;
	FLAutorelease(m_actionContext);
	m_actionContext = nil;
	m_controller = nil;
	m_popoverController = nil;
	
	FLReleaseWithNil(m_assetsLibrary);
	
	if(m_locationManager)
	{
		m_locationManager.delegate=nil;
		[m_locationManager stopUpdatingLocation];
		FLReleaseWithNil(m_locationManager);
	}
		
	self.busy = NO;
	
	FLReleaseWithNil(m_picker);
}

-(UIImagePickerControllerSourceType) sourceType
{
	return m_picker.sourceType;
}

- (void) dismissPicker:(BOOL) animated
{
	if(m_controller)
	{
		[m_controller dismissModalViewControllerAnimated:animated];
	}
	else
	{
		[m_popoverController dismissPopoverAnimated:animated];
	}
	
	[self _cleanupPicker];
}

- (void) onSaveImage:(FLAction*) action
{
	if(action.didFinishWithoutError)
	{
		++m_savedImageCount;
	
		if(m_delegate)
		{
			[m_delegate mediaPicker:self didFinishPickingImage:[[action lastOperation] operationOutput]
				isCameraImage:(self.sourceType == UIImagePickerControllerSourceTypeCamera)
			];
		}
		
		if(self.sourceType == UIImagePickerControllerSourceTypeCamera)
		{
			[self dismissPicker:self.animated];
		}
	}
	
	[action.state hideShield];
}

- (void) handleGotNewImage:(UIImage*) image properties:(NSDictionary*) exif
{
	FLAction* action = [FLAction action];

#if TIME_PICKER	   
	action.timer = [FLTimer timerWithImmediateStart:NO logEvents:YES];
#endif

	FLJpegFileImageAsset* photo = [[FLJpegFileImageAsset alloc] initWithFolder:[FLUserSession instance].photoFolder assetUID:[NSString guidString]];
	[photo.original setImage:image exifData:exif];
    
    FLProgressViewController* progress = [FLProgressViewController progressViewController:[FLSimpleProgressView class] 
                                                                     presentationBehavior:[FLModalPresentationBehavior instance]];
    
    progress.contentMode = FLContentModeMake(FLContentModeHorizontalCentered, FLContentModeVerticalBottomThird);
    progress.viewContentsDescriptor = [FLViewContentsDescriptor viewContentsDescriptorWithTop:FLViewContentItemToolbar bottom:FLViewContentItemNone hasStatusBar:NO];
    action.progressController = progress;

    if([m_delegate respondsToSelector:@selector(mediaPicker:configureActionProgress:)]) {
        [m_delegate mediaPicker:self configureActionProgress:action];
    }

    [action queueOperation:[FLSaveImageAssetToStorageOperation saveImageAssetToStorageOperation:photo wantsThumbnail:YES]];
    
    action.actionDescription.actionType = FLActionDescriptionTypeSave;
    action.actionDescription.actionItemName = FLActionDescriptionItemNamePhoto;
    action.onFinished = ^(id theAction) { 
        [self onSaveImage:theAction]; 
        };
	
	[m_actionContext beginAction:action];
	
	FLRelease(photo);
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	if(OSVersionIsAtLeast4_1())
	{
		if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
		{
			NSMutableDictionary* exif = [[info objectForKey:UIImagePickerControllerMediaMetadata] mutableCopy];

            if(m_locationManager && m_flags.locationEnabled)
            {
                CLLocation* lastLocation = m_locationManager.location;
                if(lastLocation && CLLocationCoordinate2DIsValid(lastLocation.coordinate))
                {
                    if(!exif)
                    {
                        exif = [NSMutableDictionary dictionary];
                    }
                    
                    NSMutableDictionary* locDict = [[exif objectForKey:(NSString*)kCGImagePropertyGPSDictionary] mutableCopy];
                    if(!locDict)
                    {
                        locDict = [[NSMutableDictionary alloc] init];
                    }
                    
                    FLAddLocationToGpsExif(locDict, lastLocation);		
                    
                    [exif setObject:locDict forKey:(NSString*)kCGImagePropertyGPSDictionary];
                    
                    FLReleaseWithNil(locDict);
                }	
            }
			
						// IPTC doesn't work.	 
			//		  NSMutableDictionary* iptc = [[NSMutableDictionary alloc] init];
			//		  [iptc setObject:[NSFileManager appName] forKey:(NSString*)kCGImagePropertyIPTCOriginatingProgram];
			//		  [iptc setObject:[NSFileManager appVersion] forKey:(NSString*)kCGImagePropertyIPTCProgramVersion];
			//		  [exif setObject:iptc forKey:(NSString*) kCGImagePropertyIPTCDictionary];
			//		  FLReleaseWithNil(iptc);
						
			[self handleGotNewImage:[info objectForKey:UIImagePickerControllerOriginalImage] properties:exif];
			FLReleaseWithNil(exif);
		}
#if DEPRECATED_ASSETS_PICKER
		else
		{
			NSURL* assetUrl = [info objectForKey:UIImagePickerControllerReferenceURL];
			
			if(assetUrl)
			{
				if(!m_assetsLibrary)
				{
					m_assetsLibrary = [[ALAssetsLibrary alloc] init];
				}
				[m_assetsLibrary assetForURL:assetUrl 
					resultBlock:^(ALAsset *asset)
					{
						[self handleGotNewImage:[info objectForKey:UIImagePickerControllerOriginalImage] properties:[asset defaultRepresentation].metadata];
					}
					failureBlock:^(NSError *error)
					{
						[self handleGotNewImage:[info objectForKey:UIImagePickerControllerOriginalImage] properties:nil];
					}
					];
			}
			else
			{
				[self handleGotNewImage:[info objectForKey:UIImagePickerControllerOriginalImage] properties:nil];
			}
		}
#endif
	}
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissPicker:self.animated];
}

@end
