//
//	GtTilingImageView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/7/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@interface GtTilingImageView : UIView {
@private
	UIImage* m_image;
}

@property (readwrite, retain, nonatomic) UIImage* tiledImage;

@end
