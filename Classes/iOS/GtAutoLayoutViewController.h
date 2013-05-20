//
//  GtAutoLayoutViewController.h
//  FishLamp2
//
//  Created by Mike Fullerton on 5/17/13.
//
//

#import "GtViewController.h"
#import "UIView+GtViewAutoLayout.h"
#import "GtWidgetView.h"
#import "GtViewContentsDescriptor.h"

@protocol GtViewDelegate <NSObject>
- (GtViewContentsDescriptor) viewGetSuperviewContentsDescriptor:(UIView*) view;
@end

@interface GtAutoLayoutViewController : GtViewController<GtViewDelegate> {
@private
    UIView* _autoLayoutView;
    GtViewContentsDescriptor _superviewContentsDescriptor;
}
@property (readwrite, assign, nonatomic) GtViewContentsDescriptor superviewContentsDescriptor;

@property (readonly, retain, nonatomic) id autoLayoutView;

- (id) initWithView:(UIView*) view;
+ (id) autoLayoutViewController:(UIView*) view;

@end


@interface UIView (AutoLayoutTemp)
@property (readwrite, assign, nonatomic) id<GtViewDelegate> viewDelegate;
@end

extern void GtViewDidLayoutSubviews(UIView* view);
extern void GtViewDidMoveToSuperview(UIView* view);
extern void GtViewSetPositionInSuperview(UIView* view);

