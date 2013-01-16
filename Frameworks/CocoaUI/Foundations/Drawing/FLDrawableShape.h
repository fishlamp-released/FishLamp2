//
//  FLDrawableShape.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDrawable.h"
#import "FLDrawableGradient.h"

@interface FLDrawableShape : NSObject<FLDrawable> {
@private
	CGFloat _cornerRadius;
	UIColor* _innerBorderColor;
	CGFloat _lineWidth;
	FLDrawableGradient* _borderGradient;
    CGPathRef _path;
}

@property (readwrite, assign, nonatomic) CGPathRef pathRef;

@property (readonly, strong, nonatomic) FLDrawableGradient* borderGradient;
@property (readwrite, assign, nonatomic) CGFloat borderLineWidth;
@property (readwrite, assign, nonatomic) CGFloat cornerRadius;
@property (readwrite, strong, nonatomic) UIColor* innerBorderColor;

// override this if you don't set pathRef
- (void) createPathForShapeInRect:(CGMutablePathRef) path rect:(CGRect) rect;
@end


@interface FLDrawableBackButtonShape : FLDrawableShape {
@private
    CGFloat _pointSize;
}

@property (readwrite, assign, nonatomic) CGFloat pointSize;
- (id) initWithPointSize:(CGFloat) pointSize;

@end

@interface FLDrawableForwardButtonShape : FLDrawableShape {
@private
    CGFloat _pointSize;
}

@property (readwrite, assign, nonatomic) CGFloat pointSize;
- (id) initWithPointSize:(CGFloat) pointSize;

@end