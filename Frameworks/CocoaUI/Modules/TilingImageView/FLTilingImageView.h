//
//  FLTilingImageView.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/8/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoa.h"
#import "FLView.h"

@interface FLTilingImageView : FLView {
@private
    UIImage* _image;
}
@property (readwrite, strong, nonatomic) UIImage* image;

@end