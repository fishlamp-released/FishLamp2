//
//	FLPhotoCollectionMapViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLPhotoMapViewController.h"

@protocol FLPhotoCollectionMapViewControllerDelegate;

@interface FLPhotoCollectionMapViewController : FLPhotoMapViewController {
@private
	id<FLPhotoCollectionMapViewControllerDelegate> m_delegate;
	NSUInteger m_totalCount;
	NSUInteger m_count;
	UIProgressView* m_progressView;
}

- (id) initWithPhotoCount:(NSUInteger) count;

@property (readwrite, assign, nonatomic) id<FLPhotoCollectionMapViewControllerDelegate> delegate;

- (void) beginLoadingNextPhoto;
- (void) addPhoto:(id) photo 
	name:(NSString*) name 
	coordinate:(CLLocationCoordinate2D) coordinate	   
	thumbnail:(UIImage*) thumbnail;

@end

@protocol FLPhotoCollectionMapViewControllerDelegate
- (void) photoMapViewController:(FLPhotoCollectionMapViewController*) controller beginLoadingPhotoAtIndex:(NSUInteger) idx;
- (void) photoMapViewControllerDidFinishLoadingPhotos:(FLPhotoCollectionMapViewController*) controller;
- (void) photoMapViewController:(FLPhotoCollectionMapViewController*) controller	photoWasSelected:(id) photo;
@end

@interface FLPhotoMapAnnotation : MKPointAnnotation {
	id m_photo;
	UIImage* m_thumbnail;
}
@property (readwrite, retain, nonatomic) id photo;
@property (readwrite, retain, nonatomic) UIImage* thumbnail;
@end
