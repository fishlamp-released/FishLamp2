//
//	FLPhotoCollectionMapViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLPhotoMapViewController.h"

@protocol FLPhotoCollectionMapViewControllerDelegate;

@interface FLPhotoCollectionMapViewController : FLPhotoMapViewController {
@private
	__unsafe_unretained id<FLPhotoCollectionMapViewControllerDelegate> _delegate;
	NSUInteger _totalCount;
	NSUInteger _count;
	UIProgressView* _progressView;
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
	id _photo;
	UIImage* _thumbnail;
}
@property (readwrite, retain, nonatomic) id photo;
@property (readwrite, retain, nonatomic) UIImage* thumbnail;
@end
