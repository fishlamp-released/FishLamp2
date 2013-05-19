//
//  FLSimpleCamera.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSimpleCamera.h"
#import "FLSaveImageAssetToStorageOperation.h"
#import "FLAction.h"
#import "FLGeometry.h"
#import "FLTimer.h"
#import "NSFileManager+FLExtras.h"
#import "FLGpsUtilities.h"
#import "FLUserSession.h"
#import "FLJpegFileImageAsset.h"
#import "FLGpsUtilities.h"
#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"

@interface FLOverlayCameraView : UIView {
@private    
    UILabel* _label;
}
- (void) setText:(NSString*) text;
@end

@implementation FLOverlayCameraView

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 18)];
        _label.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        _label.textColor = [UIColor lightGrayColor];
        _label.shadowColor = [UIColor blackColor];
        _label.textAlignment = UITextAlignmentRight;
        _label.backgroundColor = [UIColor clearColor];
        [self addSubview:_label];
    }
    
    return self;
}

- (void) setText:(NSString*) text
{
    _label.text = text;
}

- (void) dealloc
{
    FLRelease(_label);
    FLSuperDealloc();
}

- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}

- (void) layoutSubviews
{
    _label.frameOptimizedForSize = FLRectSetOrigin(_label.frame, self.bounds.size.width - _label.frame.size.width - 10, self.frame.size.height - 80);
    [super layoutSubviews];
}

@end

@interface FLSimpleCamera ()
@property (readwrite, strong, nonatomic) CLLocationManager* locationManager;
@property (readwrite, strong, nonatomic) UIImagePickerController* picker;
@property (readwrite, assign, nonatomic) UIViewController* viewController;
@end

@implementation FLSimpleCamera
@synthesize locationManager = _locationManager;
@synthesize picker = _picker;
@synthesize viewController = _viewController;

- (id) init {
    self = [super init];
    if(self) {
    	_picker = [[UIImagePickerController alloc] init];
        _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        _picker.delegate = self;
    }
    
    return self;
}

- (void) dealloc {
	if(_locationManager) {
		_locationManager.delegate = nil;
		[_locationManager stopUpdatingLocation];
	}
    
    _picker.delegate = nil;

#if FL_MRC
	[_locationManager release];
    [_overlayView release];
    [_picker release];
	[super dealloc];
#endif
}


- (void) _addLocationOverlay {
    _overlayView = FLAutorelease([[FLOverlayCameraView alloc] initWithFrame:CGRectMake(0,50,320,480)]);
    _overlayView.userInteractionEnabled = YES;
    _overlayView.exclusiveTouch = NO;
    _overlayView.multipleTouchEnabled = YES;
    _overlayView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    _overlayView.autoresizesSubviews = NO;
    _overlayView.backgroundColor = [UIColor clearColor];
    self.picker.cameraOverlayView = _overlayView;
}

- (void) _startLocationManager
{
    if(!_locationManager) {
    	if([CLLocationManager locationServicesEnabled]) {
            switch([CLLocationManager authorizationStatus]) {
                
                case kCLAuthorizationStatusNotDetermined:
                case kCLAuthorizationStatusAuthorized: 
                    _locationManager = [[CLLocationManager alloc] init];
                    _locationManager.delegate=self;
                    _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
                    _locationManager.purpose = NSLocalizedString(@"Store GPS Location data in Photo EXIF", nil);
                    [_locationManager startUpdatingLocation];
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
    if( !FLFloatEqualToFloat(newLocation.coordinate.longitude, oldLocation.coordinate.longitude) ||
        !FLFloatEqualToFloat(newLocation.coordinate.latitude, oldLocation.coordinate.latitude))
    {
        [_overlayView setText:FLPrettyStringForCoordinate(newLocation.coordinate)];
    }
}

- (void) addLocationToExif:(NSMutableDictionary*) exif {
    if(_locationManager) {
        CLLocation* lastLocation = _locationManager.location;
        if(lastLocation && CLLocationCoordinate2DIsValid(lastLocation.coordinate)) {
            NSMutableDictionary* locDict = FLAutorelease([[exif objectForKey:(NSString*)kCGImagePropertyGPSDictionary] mutableCopy]);
            
            if(!locDict) {
                locDict = [NSMutableDictionary dictionary];
            }
            
            FLAddLocationToGpsExif(locDict, lastLocation);		
            
            [exif setObject:locDict forKey:(NSString*)kCGImagePropertyGPSDictionary];
        }
    }
}


//- (void) onSaveImage:(FLAction*) action {
//	if(action.didSucceed) {
//		if(_delegate) {
//			[_delegate mediaPicker:self didFinishPickingImage:[action.operations lastOperationOutput]
//				isCameraImage:(self.sourceType == UIImagePickerControllerSourceTypeCamera)
//			];
//		}
//		
//		if(self.sourceType == UIImagePickerControllerSourceTypeCamera) {
//			[self dismissPicker:self.animated];
//		}
//	}
//}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {

    NSMutableDictionary* exif = [[info objectForKey:UIImagePickerControllerMediaMetadata] mutableCopy];
    FLAutorelease(exif);
    
    if(!exif) {
        exif = [NSMutableDictionary dictionary];
    }
    
    [self addLocationToExif:exif];

    
                // IPTC doesn't work.	 
    //		  NSMutableDictionary* iptc = [[NSMutableDictionary alloc] init];
    //		  [iptc setObject:[NSFileManager appName] forKey:(NSString*)kCGImagePropertyIPTCOriginatingProgram];
    //		  [iptc setObject:[NSFileManager appVersion] forKey:(NSString*)kCGImagePropertyIPTCProgramVersion];
    //		  [exif setObject:iptc forKey:(NSString*) kCGImagePropertyIPTCDictionary];
    //		  FLReleaseWithNil(iptc);
                
    FLSimplePhoto* simplePhoto = [FLSimplePhoto simplePhoto:[info objectForKey:UIImagePickerControllerOriginalImage] exif:exif];
    
    [self sendMessage:@"simpleCamera:tookPhoto:" withObject:simplePhoto];

}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if(error.code == kCLErrorDenied)
    {
//        [self _showDeniedAlert];
    }

//    [self _setButtonImage:_overlayView.button];
    
    [_locationManager stopUpdatingLocation];
    FLReleaseWithNil(_locationManager);
}


- (void) showCameraInViewController:(UIViewController*) inController
                           animated:(BOOL) animated
                        geoTagPhoto:(BOOL) geoTagPhoto {

    self.viewController = inController;
    _animated = animated;
    
    if(geoTagPhoto) {
        [self _addLocationOverlay];
        [self _startLocationManager];
    }
    
    [self.viewController presentModalViewController:self.picker animated:animated];
}

- (void) hideCamera {
    if(!_hidden) {
        _hidden = YES;
        [self.viewController hideViewController:_animated completion:^{
            [self sendMessage:@"simpleCameraDidClose:"];
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self hideCamera];
}


@end





//- (void) _startLocationManagerIfNeeded {
//    
//    if(_locationEnabled)
//    {
//        if(self.picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//        {
//        }
//    }
//
///*
//
//// this has a fatal flaw
//
//// This button in the overlay view doesn't really work. The problem
//// is that if you tap on it, the autofocus kicks in for the point the user tapped.
//// I don't know how to disable the autofocus for the case of tapping
//// on the button, short of drastic hacks.
////
//// The alternative is to provide all our own controls, but then
//// we might as well just used the FL custom camera code.
//
//
//    if(OSVersionIsAtLeast4_1())
//    {
//        if(_picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//        {
//            _overlayView = [[[FLOverlayCameraView alloc] initWithFrame:CGRectMake(0,50,320,480)]);
//            _overlayView.userInteractionEnabled = YES;
//            _overlayView.exclusiveTouch = NO;
//            _overlayView.multipleTouchEnabled = YES;
//            _overlayView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
//            _overlayView.autoresizesSubviews = NO;
//            _overlayView.backgroundColor = [UIColor clearColor];
//            
//            UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [self _setButtonImage:button];
//            [button addTarget:self action:@selector(_toggleButton:) forControlEvents:UIControlEventTouchUpInside];
//            button.enabled = YES;
//            button.showsTouchWhenHighlighted = YES;
//            button.frame = CGRectMake(0, 0, 80, 80);
//            button.autoresizesSubviews = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//            [_overlayView addSubview:button];
//            _overlayView.button = button;
//            
//            _picker.cameraOverlayView = _overlayView;
//        }
//    }
// */
//}