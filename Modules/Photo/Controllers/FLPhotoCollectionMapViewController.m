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
@synthesize photo = m_photo;
@synthesize thumbnail = m_thumbnail;
- (void) dealloc
{
	FLRelease(m_thumbnail);
	FLRelease(m_photo);
	FLSuperDealloc();
}
@end

@implementation FLPhotoCollectionMapViewController

@synthesize delegate = m_delegate;

- (void) addPhoto:(id) photo 
	name:(NSString*) name 
	coordinate:(CLLocationCoordinate2D) coordinate
	thumbnail:(UIImage*) thumbnail
{
	FLAssertIsNotNil(thumbnail);

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
		m_totalCount = count;
	}
	
	return self;
}
- (void) beginLoadingNextPhoto
{
	if(!m_progressView && m_totalCount > 0)
	{
		m_progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
		m_progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | 
			UIViewAutoresizingFlexibleRightMargin |
			UIViewAutoresizingFlexibleTopMargin | 
			UIViewAutoresizingFlexibleBottomMargin;
			
		m_progressView.frame = CGRectMake(10, FLRectGetBottom(self.view.bounds) - 20, self.view.bounds.size.width - 20.0f, 10.0f);
		m_progressView.alpha = 1.0; // 0.6;
		m_progressView.progress = 0.0;
		[self.view addSubview:m_progressView]; 
		[self.view bringSubviewToFront:m_progressView]; 
		
	}

	NSUInteger idx = m_count++;
	
	if(idx < m_totalCount)
	{
		m_progressView.progress = ((CGFloat)m_count) / ((CGFloat) m_totalCount);
		[m_delegate photoMapViewController:self beginLoadingPhotoAtIndex:idx];
		
		[self.mapView zoomToFitMapAnnotationsAnimated:YES];
	}
	else
	{
		m_progressView.progress = 1.0;
		[m_progressView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3f];
		FLReleaseWithNil(m_progressView);
		
		[self.mapView zoomToFitMapAnnotationsAnimated:YES];
		
//		  [self.mapView setCenterCoordinate:self.mapView.region.center zoomLevel:10 animated:YES];
		
		[m_delegate photoMapViewControllerDidFinishLoadingPhotos:self];
	}

	
	[self.view bringSubviewToFront:m_progressView]; 
}

- (void) dealloc
{	
	FLRelease(m_progressView);
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
	
	m_count = 0;
	if(m_totalCount > 0)
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
	MKPinAnnotationView *annView= FLReturnAutoreleased([[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"]);
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

