//
//	PhotoMapView.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLPhotoMapViewController.h"
#import "FLGpsUtilities.h"
#import "FLThumbnailButton.h"

#import "FLImage+Colorize.h"
#import "MKMapView+FLExtras.h"
#import "FLFloatingViewController.h"



@implementation FLPhotoMapViewController

@synthesize mapView = _mapView;

- (id) init
{
	if((self = [super initWithNibName:@"FLPhotoMapView" bundle:nil]))
	{
        self.contentSizeForViewInFloatingView = FLSizeMake( 500, 500);
	}
	
	return self;
}

- (void) dealloc
{	
	mrc_release_(_mapView);
	mrc_release_(_mapSwitcher);
	mrc_super_dealloc_();
}

- (void) _resetZoom:(id) zoom
{
	[self.mapView zoomToFitMapAnnotationsAnimated:NO];
	[self.mapView setCenterCoordinate:self.mapView.region.center zoomLevel:10 animated:YES];
}

//- (void) _zoomOut:(id) sender
//{
//	NSInteger zoomLevel = self.mapView.zoomLevel;
//	  [self.mapView setCenterCoordinate:self.mapView.region.center zoomLevel:(zoomLevel - 2) animated:YES];
//}
//
//- (void) _zoomIn:(id) sender
//{
//	NSInteger zoomLevel = self.mapView.zoomLevel + 2;
//	  if(_zoomLevel < zoomLevel)
//	  {
//		[self.mapView zoomToFitMapAnnotationsAnimated:NO];
//	  }
//	  [self.mapView setCenterCoordinate:self.mapView.region.center zoomLevel:zoomLevel animated:YES];
//}


- (void) viewDidLoad
{
	[super viewDidLoad];
	self.mapView.zoomEnabled = YES;
	self.mapView.scrollEnabled = YES;
	self.mapView.frame = self.view.bounds;
	
	[self.buttonbar addViewToRightSide:[FLDeprecatedButtonbarView createImageButtonByName:@"map_pin.png" imageColor:FLImageColorBlack target:self action:@selector(_resetZoom:)] forKey:@"zoom" animated:NO];
	
	[self.view bringSubviewToFront:_mapSwitcher];
	
	CLLocationCoordinate2D centerCoord = { 37.33182, -122.03118 }; // apple headquarters
	[self.mapView setCenterCoordinate:centerCoord zoomLevel:1 animated:NO];

//    self.contentSizeForViewInFloatingView = FLSizeMake( 500, MIN(600, self.view.frame.size.height));
}

- (IBAction) mapSwitched:(UISegmentedControl*) mapSwitcher
{
	switch(mapSwitcher.selectedSegmentIndex)
	{
		case 0: self.mapView.mapType =	MKMapTypeStandard; break;
		case 1: self.mapView.mapType =	MKMapTypeSatellite; break;
		case 2: self.mapView.mapType =	MKMapTypeHybrid; break;
	}
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>) annotation
{
	MKPinAnnotationView *annView= autorelease_([[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"]);
	annView.pinColor = MKPinAnnotationColorGreen;
	annView.animatesDrop=YES;
	annView.canShowCallout = YES;
	annView.selected = NO;
	return annView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
	if(self.mapView.annotations.count == 1)
	{
		[self.mapView selectAnnotation:[self.mapView.annotations objectAtIndex:0] animated:YES];
	}
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
}

- (void) addPin:(NSString*) name
	coordinate:(CLLocationCoordinate2D) coordinate
{
	MKPointAnnotation* annotation = [[MKPointAnnotation alloc] init];
	annotation.coordinate = coordinate; 
	annotation.title = name;
	annotation.subtitle = FLPrettyStringForCoordinate(coordinate);
	[self.mapView addAnnotation:annotation];
	mrc_release_(annotation);
	
	self.title = name;
	
	[self _resetZoom:nil];
}

- (void) removeAllPins
{
	[self.mapView removeAnnotations:self.mapView.annotations];
}


//- (void) viewWillAppear:(BOOL)animated
//{
//	[super viewWillAppear:animated];
//	
//	FLFloatingViewController* popover = self.floatingViewController;
//	if(popover)
//	{
//		self.contentSizeForViewInPopup = FLSizeMake(500, MIN(600, self.view.frame.size.height));
//	}
//}

@end

