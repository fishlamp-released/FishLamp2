//
//	FLBackButtonShapeWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
