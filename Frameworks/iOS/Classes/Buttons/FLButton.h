//
//  FLButton.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/21/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "FLWidget.h"
#import "FLButtonBackgroundWidget.h"

@class FLButton;

typedef void (^FLButtonPress)(id button);
typedef void (^FLButtonColorizer)(FLButton* button);
typedef void (^FLButtonStylizer)(FLButton* button);

typedef enum {
    FLButtonRoleNormal,
    FLButtonRoleDone,
    FLButtonRoleConfirm,
    FLButtonRoleCancel,
    FLButtonRoleDelete
} FLButtonRole;

@interface FLButton : UIButton {
@private
    FLButtonBackgroundWidget* _backgroundWidget;
    FLWidget* _shapeWidget;
    FLButtonPress _onPress;
    FLButtonColorizer _colorizer;
    FLButtonStylizer _stylizer;
    FLButtonRole _role;
}

- (id) initWithTitle:(NSString*) title;

- (id) initWithTitle:(NSString*) title
             onPress:(FLButtonPress) onPress;

+ (FLButton*) button;

+ (FLButton*) buttonWithTitle:(NSString*) title;

+ (FLButton*) buttonWithTitle:(NSString*) title
                      onPress:(FLButtonPress) onPress;

@property (readwrite, copy, nonatomic) FLButtonPress onPress;

// All of these properties depend on the context the button is being used in.

@property (readwrite, strong, nonatomic) id shapeWidget;

@property (readwrite, strong, nonatomic) FLButtonBackgroundWidget* backgroundWidget;

@property (readwrite, copy, nonatomic) FLButtonColorizer buttonColors;

@property (readwrite, copy, nonatomic) FLButtonStylizer buttonStyle;

@property (readwrite, assign, nonatomic) FLButtonRole buttonRole;

- (void) setShapeToRoundRect:(CGFloat) cornerRadius;
- (void) setLightText;
- (void) setDarkText;

@end

extern FLButtonColorizer FLButtonColorRed;
extern FLButtonColorizer FLButtonColorPaleBlue;
extern FLButtonColorizer FLButtonColorBrightBlue;
extern FLButtonColorizer FLButtonColorDarkGray;
extern FLButtonColorizer FLButtonColorDarkGrayWithBlueTint;
extern FLButtonColorizer FLButtonColorBlack;
extern FLButtonColorizer FLButtonColorGray;
extern FLButtonColorizer FLButtonColorLightGray;


