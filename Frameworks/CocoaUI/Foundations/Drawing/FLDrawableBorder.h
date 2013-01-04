//
//  FLDrawableBorder.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDrawable.h"

@interface FLDrawableBorder : NSObject<FLDrawable> {
@private
	CGFloat _cornerRadius;
	UIColor* _borderColor;
	CGFloat _lineWidth;
}

@property (readwrite, assign, nonatomic) CGFloat lineWidth;
@property (readwrite, assign, nonatomic) CGFloat cornerRadius;
@property (readwrite, strong, nonatomic) UIColor* borderColor;

@end
