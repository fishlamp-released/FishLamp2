//
//	GtGradientButton.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/14/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtButton.h"
#import "GtGradientWidget.h"
#import "GtWidget.h"
#import "GtButtonBackgroundWidget.h"
#import "GtShapeWidget.h"

@class GtGradientButtonBaseClass;
typedef void (*GtButtonColorizer)(GtGradientButtonBaseClass*);

#define GtButtonColorDefault nil
extern void GtButtonColorRed(GtGradientButtonBaseClass*);
extern void GtButtonColorPaleBlue(GtGradientButtonBaseClass*);
extern void GtButtonColorBrightBlue(GtGradientButtonBaseClass*);

extern void GtButtonDarkGray(GtGradientButtonBaseClass* button);
extern void GtButtonDarkGrayWithBlueTint(GtGradientButtonBaseClass* button);

extern void GtButtonBlack(GtGradientButtonBaseClass* button);

extern void GtButtonColorGray(GtGradientButtonBaseClass* button);
extern void GtButtonColorLightGray(GtGradientButtonBaseClass* button);

@interface GtGradientButtonBaseClass : GtButton {
@private 
	GtButtonColorizer m_buttonColorizer;
	GtButtonBackgroundWidget* m_backgroundWidget;
    GtShapeWidget* m_shapeWidget;
}
@property (readwrite, assign, nonatomic) GtButtonColorizer buttonColorizer;
@property (readwrite, retain, nonatomic) GtButtonBackgroundWidget* backgroundWidget;
@property (readwrite, retain, nonatomic) GtShapeWidget* shapeWidget; // shape widget is self.widget

- (id) initWithColor:(GtButtonColorizer) color	title:(NSString*) title	 image:(UIImage*) image target:(id) target action:(SEL) action; //designated 

- (id) initWithColor:(GtButtonColorizer) color	title:(NSString*) title	 target:(id) target action:(SEL) action;
- (id) initWithTitle:(NSString*) title	target:(id) target action:(SEL) action;
- (id) initWithTitle:(NSString*) title	image:(UIImage*) image target:(id) target action:(SEL) action;
@end

@interface GtGradientButton : GtGradientButtonBaseClass
+ (GtGradientButton*) gradientButton:(GtButtonColorizer) color title:(NSString*) title target:(id) target action:(SEL) action;
+ (GtGradientButton*) gradientButton:(NSString*) title target:(id) target action:(SEL) action;
@end

@interface GtToolbarButton : GtGradientButtonBaseClass
+ (GtToolbarButton*) toolbarButton:(GtButtonColorizer) color title:(NSString*) title target:(id) target action:(SEL) action;
+ (GtToolbarButton*) toolbarButton:(NSString*) title target:(id) target action:(SEL) action;
@end

@interface GtBackButton : GtToolbarButton
+ (GtBackButton*) backButton:(GtButtonColorizer) color title:(NSString*) title target:(id) target action:(SEL) action;
+ (GtBackButton*) backButton:(NSString*) title target:(id) target action:(SEL) action;
@end

@interface GtMenuButton : GtGradientButtonBaseClass
+ (GtMenuButton*) menuButton:(GtButtonColorizer) color title:(NSString*) title target:(id) target action:(SEL) action;
+ (GtMenuButton*) menuButton:(NSString*) title target:(id) target action:(SEL) action;
@end

@interface GtSmallButton : GtGradientButtonBaseClass
+ (GtSmallButton*) smallButton:(GtButtonColorizer) color title:(NSString*) title target:(id) target action:(SEL) action;
+ (GtSmallButton*) smallButton:(NSString*) title target:(id) target action:(SEL) action;
@end

@interface GtFatButton : GtGradientButtonBaseClass
+ (GtFatButton*) fatButton:(GtButtonColorizer) color title:(NSString*) title image:(UIImage*) image target:(id) target action:(SEL) action;
+ (GtFatButton*) fatButton:(NSString*) title image:(UIImage*) image target:(id) target action:(SEL) action;
@end