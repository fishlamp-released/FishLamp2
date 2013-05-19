//
//  FLDraggableButtonView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/19/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "FLWidgetView.h"
#import "FLVerticalDragBarWidget.h"

@interface FLDraggableButtonView : FLWidgetView {
@private
//    FLVerticalDragBarWidget* _dragBar;
    UIButton* _openButton;
    UIButton* _closeButton;
    FLWidget* _openBackgroundWidget;
}

//@property (readwrite, retain, nonatomic) FLVerticalDragBarWidget* dragBar;
@property (readwrite, retain, nonatomic) UIButton* openButton;
@property (readwrite, retain, nonatomic) UIButton* closeButton;
@property (readwrite, retain, nonatomic) FLWidget* openBackgroundWidget;

- (void) swapButtonsAnimated:(BOOL) animated;
@end