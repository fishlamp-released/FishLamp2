//
//  FLDialogShapeView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/31/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLWidgetView.h"

#import "FLWidgetView.h"
#import "FLGradientWidget.h"
#import "FLRoundRectWidget.h"

@interface FLDialogShapeView : FLWidgetView {
@private
    FLRoundRectWidget* _roundRect;
    FLGradientWidget* _backgroundGradient;
//    UIView* _contentView;
}

@property (readwrite, assign, nonatomic) CGFloat cornerRadius;

@property (readonly, strong, nonatomic) FLRoundRectWidget* shapeWidget;
@property (readonly, strong, nonatomic) FLGradientWidget* backgroundGradient;


@end
