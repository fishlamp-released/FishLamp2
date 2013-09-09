//
//  FLAlertView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/31/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLWidgetView.h"
#import "FLButtonContainerView.h"
#import "FLTriangleShapeWidget.h"

typedef enum {
    FLAlertViewColorBarSideLeft,
    FLAlertViewColorBarSideRight,
    FLAlertViewColorBarSideTop,
    FLAlertViewColorBarSideBottom
} FLAlertViewColorBarSide;


@interface FLAlertView : FLWidgetView {
@private
    UILabel* _messageLabel;
    UILabel* _title;
    FLGradientWidget* _colorBar;
    FLTriangleShapeWidget* _triangleShapeWidget;
    FLButtonContainerView* _buttonBox;

    CGFloat _colorBarSize;
    CGFloat _triangleSize;
    CGSize _buttonSize;
    CGFloat _buttonCornerRadius;
    CGFloat _titleHeight;
}

@property (readwrite, assign, nonatomic) CGFloat triangleSize;
@property (readwrite, assign, nonatomic) CGFloat colorBarSize;
@property (readwrite, assign, nonatomic) CGSize buttonSize;
@property (readwrite, assign, nonatomic) CGFloat buttonCornerRadius;
@property (readwrite, assign, nonatomic) CGFloat titleHeight;

// title
@property (readonly, strong, nonatomic) UILabel* titleLabel;
@property (readwrite, strong, nonatomic) NSString* title;

// message
@property (readwrite, nonatomic, strong) NSString* alertMessage;

// optional buttons
@property (readonly, strong, nonatomic) FLButtonContainerView* buttonContainerView;
- (void) addButton:(FLButton*) button;
                
// experimental

// TODO: add "Adornment"? 

// color bar
@property (readonly, strong, nonatomic) FLGradientWidget* colorBar; // hidden by default
- (void) setColorBarWithColorRange:(FLColorRange*) range    
                            onSide:(FLAlertViewColorBarSide) side;

// corner triangle
@property (readonly, strong, nonatomic) FLTriangleShapeWidget* cornerTriangle;
- (void) setCornerTriangleWithColorRange:(FLColorRange*) colorRange 
                                inCorner:(FLTriangleCorner) corner;



@end
