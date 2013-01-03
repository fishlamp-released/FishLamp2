//
//	FLPhotoCollectionMapViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLPhotoCollectionMapViewController.h"
#import "FLGpsUtilities.h"
#import "MKMapView+FLExtras.h"

#import "FLThumbnailButton.h"

@implementation FLPhotoMapAnnotation
@synthesize photo = _photo;
@synthesize thumbnail = _thumbnail;
- (void) dealloc
{
	FLRelease(_thumbnail);
	FLRelease(_photo);
	FLSuperDealloc();
}
@end

@implementation FLPhotoCollectionMapViewController

@synthesize delegate = _delegate;

- (void) addPhoto:(id) photo 
	name:(NSString*) name 
	coordinate:(CLLocationCoordinate2D) coordinate
	thumbnail:(UIImage*) thumbnail
{
	FLAssertIsNotNil_(thumbnail);

	FLPhotoMapAnnotation* annotation = [[FLPhotoMapAnnotation alloc] init];
	annotation.coordinate = coordinate; 
	annotation.title = name;
	annotation.photo = photo;
	annotation.subtitle = FLPrettyStringForCoordinate(coordinate);
	annotation.thumbnail = thumbnail;
	[self.mapView addAnnotation:annotation];
	FLRelease(annotation);
	
	self.title = [NSString stringWithFormat:(NSLocalizedString(@"%d Photos", nil)), self.mapView.annotations.count];
	
//	  if(self.mapView.annotations.count == 1)
//	  {
//		  MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(5,5));
//		  [self.mapView setRegion:region animated:NO];
//	  }

	 [self beginLoadingNextPhoto];
}

- (id) initWithPhotoCount:(NSUInteger) count
{
	if((self = [super init]))
	{
		_totalCount = count;
	}
	
	return self;
}
- (void) beginLoadingNextPhoto
{
	if(!_progressView && _totalCount > 0)
	{
		_progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
		_progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | 
			UIViewAutoresizingFlexibleRightMargin |
			UIViewAutoresizingFlexibleTopMargin | 
			UIViewAutoresizingFlexibleBottomMargin;
			
		_progressView.frame = CGRectMake(10, FLRectGetBottom(self.view.bounds) - 20, self.view.bounds.size.width - 20.0f, 10.0f);
		_progressView.alpha = 1.0; // 0.6;
		_progressView.progress = 0.0;
		[self.view addSubview:_progressView]; 
		[self.view bringSubviewToFront:_progressView]; 
		
	}

	NSUInteger idx = _count++;
	
	if(idx < _totalCount)
	{
		_progressView.progress = ((CGFloat)_count) / ((CGFloat) _totalCount);
		[_delegate photoMapViewController:self beginLoadingPhotoAtIndex:idx];
		
		[self.mapView zoomToFitMapAnnotationsAnimated:YES];
	}
	else
	{
		_progressView.progress = 1.0;
		[_progressView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3f];
		FLReleaseWithNil(_progressView);
		
		[self.mapView zoomToFitMapAnnotationsAnimated:YES];
		
//		  [self.mapView setCenterCoordinate:self.mapView.region.center zoomLevel:10 animated:YES];
		
		[_delegate photoMapViewControllerDidFinishLoadingPhotos:self];
	}

	
	[self.view bringSubviewToFront:_progressView]; 
}

- (void) dealloc
{	
	FLRelease(_progressView);
	FLSuperDealloc();
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if(DeviceIsPad())
	{
		if(self.navigationController == nil || self.navigationController.rootViewController == self)
		{

//			FLModalPopoverController* controller = [FLModalPopoverController modalPopoverControllerForViewController:self];
//		  
//			CGSize size = controller.floatingViewContentSize;
//		  
//			  if(UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
//			  {
//				[controller setFloatingViewContentSize: CGSizeMake(600, size.height) animated:NO];
//			  }
//			  else
//			  {
//				[controller setFloatingViewContentSize: CGSizeMake(600, size.height) animated:NO];
//			  }
		}
	}
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	_count = 0;
	if(_totalCount > 0)
	{
		[self beginLoadingNextPhoto];
	}
}

- (void) _showImage:(FLThumbnailButton*) sender
{
	[self.delegate photoMapViewController:self photoWasSelected:[sender userData]];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>) annotation
{
	MKPinAnnotationView *annView= FLAutorelease([[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"]);
	annView.pinColor = MKPinAnnotationColorGreen;
	annView.animatesDrop=YES;
	annView.canShowCallout = YES;
	annView.selected = NO;

	if([annotation isKindOfClass:[FLPhotoMapAnnotation class]])
	{
		FLPhotoMapAnnotation* photoMapAnno = (FLPhotoMapAnnotation*)annotation;
	
		if(photoMapAnno.thumbnail)
		{
			FLThumbnailButton* button = [FLThumbnailButton thumbnailButton];
			[button addTarget:self action:@selector(_showImage:)];
			button.selectedBehavior = FLThumbnailButtonSelectedBehaviorAnimate;
			button.buttonAnimation = [FLBounceButtonAnimation instance];
			button.frame = CGRectMake(0,0, 32,32);
			button.foregroundImage = [photoMapAnno thumbnail];
			button.userData = [photoMapAnno photo];
			annView.rightCalloutAccessoryView = button;
		}
	}
	else
	{
		annView.pinColor = MKPinAnnotationColorRed;
	}
	
	return annView;
}

@end

