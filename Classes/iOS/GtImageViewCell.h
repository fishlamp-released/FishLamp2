//
//	GtImageViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/11/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtEditObjectTableViewCell.h"

@interface GtImageViewCell : GtEditObjectTableViewCell {
@private
	UIImageView* m_imageView;
}

@property (readwrite, retain, nonatomic) UIImage* image; 

- (id) initWithImage:(UIImage*) image;

+ (GtImageViewCell*) imageViewCell:(UIImage*) image;

@end
