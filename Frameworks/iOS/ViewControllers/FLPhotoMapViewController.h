//
//	PhotoMapView.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/20/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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



