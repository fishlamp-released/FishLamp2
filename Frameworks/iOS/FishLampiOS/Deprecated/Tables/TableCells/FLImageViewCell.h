//
//	FLImageViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/11/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
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
