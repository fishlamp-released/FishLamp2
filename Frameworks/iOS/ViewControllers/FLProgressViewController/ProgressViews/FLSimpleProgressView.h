//
//  FLSimpleProgressView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/23/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLWidgetView.h"

@interface FLSimpleProgressView : FLWidgetView {
@private
	UILabel* _textLabel;
	UILabel* _statusMessage;
	UIActivityIndicatorView* _spinner;
    CGSize _minSize;
}

@property (readonly, strong, nonatomic) UILabel* textLabel;
@property (readonly, strong, nonatomic) UIActivityIndicatorView* spinner;

@property (readwrite, assign, nonatomic) CGSize minSize;

@property (readwrite, retain, nonatomic) NSString* title;

- (void) showStatusMessage:(NSString*) string 
                  animated:(BOOL) animated;

- (void) hideStatusMessageAnimated:(BOOL) animated;

- (void) layoutProgressViews;

@end


@interface FLLargerSimpleProgressView : FLSimpleProgressView {
}

@end