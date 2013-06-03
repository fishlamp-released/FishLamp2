//
//	FLGradientButton.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/14/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLLegacyButton.h"
#import "FLGradientWidget.h"
#import "FLWidget.h"
#import "FLButtonBackgroundWidget.h"
#import "FLShapeWidget.h"

@class FLGradientButtonBaseClass;

typedef void (*FLButtonColorizerDeprecated)(id button);

#define FLButtonColorDefault nil
extern void FLGradientButtonColorRed(id button);
extern void FLGradientButtonColorPaleBlue(id button);
extern void FLGradientButtonColorBrightBlue(id button);

extern void FLGradientButtonDarkGray(id button);
extern void FLGradientButtonDarkGrayWithBlueTint(id button);

extern void FLGradientButtonBlack(id button);

extern void FLGradientButtonColorGray(id button);
extern void FLGradientButtonColorLightGray(id button);

@interface FLGradientButtonBaseClass : FLLegacyButton {
@private
    FLButtonColorizerDeprecated _buttonColorizer;
    FLButtonBackgroundWidget* _backgroundWidget;
	FLShapeWidget* _shapeWidget;
}

@property (readwrite, assign, nonatomic) FLButtonColorizerDeprecated buttonColorizer;
@property (readwrite, retain, nonatomic) FLButtonBackgroundWidget* backgroundWidget;
@property (readwrite, retain, nonatomic) FLShapeWidget* shapeWidget; // shape widget is self.widget

- (id) initWithColor:(FLButtonColorizerDeprecated) color	title:(NSString*) title	 image:(UIImage*) image target:(id) target action:(SEL) action; //designated 

- (id) initWithColor:(FLButtonColorizerDeprecated) color	title:(NSString*) title	 target:(id) target action:(SEL) action;
- (id) initWithTitle:(NSString*) title	target:(id) target action:(SEL) action;
- (id) initWithTitle:(NSString*) title	image:(UIImage*) image target:(id) target action:(SEL) action;
@end

@interface FLGradientButton : FLGradientButtonBaseClass
+ (FLGradientButton*) gradientButton:(FLButtonColorizerDeprecated) color title:(NSString*) title target:(id) target action:(SEL) action;
+ (FLGradientButton*) gradientButton:(NSString*) title target:(id) target action:(SEL) action;
@end

@interface FLToolbarButtonDeprecated : FLGradientButtonBaseClass
+ (FLToolbarButtonDeprecated*) toolbarButton:(FLButtonColorizerDeprecated) color title:(NSString*) title target:(id) target action:(SEL) action;
+ (FLToolbarButtonDeprecated*) toolbarButton:(NSString*) title target:(id) target action:(SEL) action;
@end

@interface FLBackButtonDeprecated : FLToolbarButtonDeprecated
+ (FLBackButtonDeprecated*) backButton:(FLButtonColorizerDeprecated) color title:(NSString*) title target:(id) target action:(SEL) action;
+ (FLBackButtonDeprecated*) backButton:(NSString*) title target:(id) target action:(SEL) action;
@end

@interface FLMenuButtonDeprecated : FLGradientButtonBaseClass
+ (FLMenuButtonDeprecated*) menuButton:(FLButtonColorizerDeprecated) color title:(NSString*) title target:(id) target action:(SEL) action;
+ (FLMenuButtonDeprecated*) menuButton:(NSString*) title target:(id) target action:(SEL) action;
@end

@interface FLSmallButtonDeprecated : FLGradientButtonBaseClass
+ (FLSmallButtonDeprecated*) smallButton:(FLButtonColorizerDeprecated) color title:(NSString*) title target:(id) target action:(SEL) action;
+ (FLSmallButtonDeprecated*) smallButton:(NSString*) title target:(id) target action:(SEL) action;
@end

@interface FLFatButtonDeprecated : FLGradientButtonBaseClass
+ (FLFatButtonDeprecated*) fatButton:(FLButtonColorizerDeprecated) color title:(NSString*) title image:(UIImage*) image target:(id) target action:(SEL) action;
+ (FLFatButtonDeprecated*) fatButton:(NSString*) title image:(UIImage*) image target:(id) target action:(SEL) action;
@end