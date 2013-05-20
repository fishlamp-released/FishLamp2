//
//	GtPhotoCollectionMapViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtPhotoMapViewController.h"

@protocol GtPhotoCollectionMapViewControllerDelegate;

@interface GtPhotoCollectionMapViewController : GtPhotoMapViewController {
@private
	id<GtPhotoCollectionMapViewControllerDelegate> m_delegate;
	NSUInteger m_totalCount;
	NSUInteger m_count;
	UIProgressView* m_progressView;
}

- (id) initWithPhotoCount:(NSUInteger) count;

@property (readwrite, assign, nonatomic) id<GtPhotoCollectionMapViewControllerDelegate> delegate;

- (void) beginLoadingNextPhoto;
- (void) addPhoto:(id) photo 
	name:(NSString*) name 
	coordinate:(CLLocationCoordinate2D) coordinate	   
	thumbnail:(UIImage*) thumbnail;

@end

@protocol GtPhotoCollectionMapViewControllerDelegate
- (void) photoMapViewController:(GtPhotoCollectionMapViewController*) controller beginLoadingPhotoAtIndex:(NSUInteger) idx;
- (void) photoMapViewControllerDidFinishLoadingPhotos:(GtPhotoCollectionMapViewController*) controller;
- (void) photoMapViewController:(GtPhotoCollectionMapViewController*) controller	photoWasSelected:(id) photo;
@end

@interface GtPhotoMapAnnotation : MKPointAnnotation {
	id m_photo;
	UIImage* m_thumbnail;
}
@property (readwrite, retain, nonatomic) id photo;
@property (readwrite, retain, nonatomic) UIImage* thumbnail;
@end
