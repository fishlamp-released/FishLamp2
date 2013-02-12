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
	UIColor* _edgeInsetColor;
	CGFloat _edgeInset;
	FLDrawableGradient* _borderGradient;
    UIColor* _backgroundColor;
}
@property (readwrite, strong, nonatomic) UIColor* backgroundColor;
@property (readonly, strong, nonatomic) FLDrawableGradient* borderGradient;
@property (readwrite, strong, nonatomic) UIColor* edgeInsetColor;


@property (readwrite, assign, nonatomic) CGFloat edgeInset; 

@property (readwrite, assign, nonatomic) CGFloat cornerRadius;

// override this if you don't set pathRef
- (void) createPathForShapeInRect:(CGMutablePathRef) path rect:(CGRect) rect;
@end


@interface FLDrawableBackButtonShape : FLDrawableShape {
@private
    CGFloat _shapeSize;
}

@property (readwrite, assign, nonatomic) CGFloat shapeSize;
- (id) initWithShapeSize:(CGFloat) shapeSize;

@end

@interface FLDrawableForwardButtonShape : FLDrawableShape {
@private
    CGFloat _shapeSize;
}

@property (readwrite, assign, nonatomic) CGFloat shapeSize;
- (id) initWithShapeSize:(CGFloat) shapeSize;

@end