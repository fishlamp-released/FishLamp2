//
//	PhotoMapView.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLViewController.h"
#import "FLPhotoExif.h"

@protocol FLPhotoMapViewControllerDelegate;

@interface FLPhotoMapViewController : FLViewController<MKMapViewDelegate> {
@private
	IBOutlet id _mapSwitcher;
	IBOutlet MKMapView* _mapView;
}

@property (readonly, retain, nonatomic) MKMapView* mapView;

- (IBAction) mapSwitched:(UISegmentedControl*) mapSwitcher;

- (void) addPin:(NSString*) name
	coordinate:(CLLocationCoordinate2D) coordinate;	 
	
- (void) removeAllPins;

@end



