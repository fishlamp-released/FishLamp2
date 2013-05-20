//
//	GtWidgetView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/12/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidget.h"

//#if VIEW_AUTOLAYOUT
#if 0

#import "UIView+GtViewAutoLayout.h"
#import "GtViewLayout.h"
@protocol GtViewDelegate;

// TODO: get rid of this.
@protocol GtWidgetView <NSObject>
@property (readwrite, assign, nonatomic) GtRectLayout autoLayoutMode;
@property (readwrite, assign, nonatomic) GtViewContentsDescriptor superviewContentsDescriptor;
@property (readwrite, assign, nonatomic) id<GtViewDelegate> viewDelegate;
@property (readwrite, assign, nonatomic) CGSize lastSuperviewSize;
- (void) setPositionInSuperview;
- (void) clearViewDelegate;
@end

@interface GtWidgetView : UIView<GtWidgetView> {
@private
	GtThemeState m_themeState;
    
// TODO: move this to view controllers.    
	CGSize m_lastSuperviewSize;
	id<GtViewDelegate> m_viewDelegate;
	GtRectLayout m_autoLayoutMode;
	GtViewContentsDescriptor m_superviewContentsDescriptor;
}
@end
// TODO: get rid of this.
@protocol GtViewDelegate <NSObject>
- (GtViewContentsDescriptor) viewGetSuperviewContentsDescriptor:(UIView*) view;
@end

extern void GtViewDidLayoutSubviews(UIView<GtWidgetView>* view);
extern void GtViewDidMoveToSuperview(UIView<GtWidgetView>* view);
extern void GtViewSetPositionInSuperview(UIView<GtWidgetView>* view);

NS_INLINE
void GtViewSetPositionInSuperviewWithLayout(UIView* view, 
                                            GtRectLayout autoLayoutMode, 
                                            GtViewContentsDescriptor superviewContentsDescriptor)
{
	[view setPositionInSuperviewWithRectLayout:autoLayoutMode superviewContents:superviewContentsDescriptor];
}

#else

@interface GtWidgetView : UIView {
@private
	GtThemeState m_themeState;
    GtWidget* m_widget;
}
@property (readwrite, retain, nonatomic) GtWidget* widget;
@end

#endif