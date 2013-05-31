//
//  FLCropImageView.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

@interface FLCropImageView : UIView {
@private
    UIImageView* _imageView;
}

@property (readwrite, retain, nonatomic) UIImage* image;

@end
