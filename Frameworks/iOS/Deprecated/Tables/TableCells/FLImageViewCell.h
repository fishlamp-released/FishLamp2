//
//	FLImageViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/11/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLEditObjectTableViewCell.h"

@interface FLImageViewCell : FLEditObjectTableViewCell {
@private
	UIImageView* _imageCellView;
}

@property (readwrite, retain, nonatomic) UIImage* image; 

- (id) initWithImage:(UIImage*) image;

+ (FLImageViewCell*) imageViewCell:(UIImage*) image;

@end
