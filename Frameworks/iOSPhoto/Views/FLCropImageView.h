//
//  FLCropImageView.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

@interface FLCropImageView : UIView {
@private
    UIImageView* _imageView;
}

@property (readwrite, retain, nonatomic) UIImage* image;

@end
