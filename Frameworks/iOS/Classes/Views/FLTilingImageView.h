//
//	FLTilingImageView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/7/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLTilingImageView : UIView {
@private
	UIImage* _image;
}

@property (readwrite, retain, nonatomic) UIImage* tiledImage;

@end
