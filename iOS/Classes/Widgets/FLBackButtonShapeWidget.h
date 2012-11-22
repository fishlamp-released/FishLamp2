//
//	FLBackButtonShapeWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLShapeWidget.h"

@interface FLBackButtonShapeWidget : FLShapeWidget {
@private
	CGFloat _pointSize;
}

@property (readwrite, assign, nonatomic) CGFloat pointSize;

+ (FLBackButtonShapeWidget*) backButtonShapeWidget:(CGFloat) point;

@end
