//
//  GtCropImageView.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

@interface GtCropImageView : UIView {
@private
    UIImageView* m_imageView;
}

@property (readwrite, retain, nonatomic) UIImage* image;

@end
