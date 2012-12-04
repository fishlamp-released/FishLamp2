//
//	FLButtonBackgroundWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"
#import "FLGradientWidget.h"

@interface FLButtonBackgroundWidget : FLWidget {
@private
	FLGradientWidget* _topGradient;
	FLGradientWidget* _bottomGradient;
}

@property (readwrite, assign, nonatomic) CGFloat alpha;

+ (FLButtonBackgroundWidget*) buttonBackgroundWidget;

@property (readwrite, retain, nonatomic) FLGradientWidget* topGradient;
@property (readwrite, retain, nonatomic) FLGradientWidget* bottomGradient;

@end
