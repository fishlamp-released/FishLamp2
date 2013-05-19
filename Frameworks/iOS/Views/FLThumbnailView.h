//
//	FLThumbnailView.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@interface FLThumbnailView : UIImageView {
@private
	UIImage* _backgroundImage;
	UIImage* _image;
	UIView* _disabledView;
	BOOL _enabled;
}

@property (readwrite, assign, nonatomic) BOOL enabled;

- (void) clearImages;

@property (readwrite, retain, nonatomic) UIImage* backgroundImage;
@property (readwrite, retain, nonatomic) UIImage* foregroundImage;

@end