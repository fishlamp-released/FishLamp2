//
//  FLTilingImageView.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/8/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

@interface FLTilingImageView : UIView {
@private
    UIImage* _image;
}
@property (readwrite, strong, nonatomic) UIImage* image;

@end
