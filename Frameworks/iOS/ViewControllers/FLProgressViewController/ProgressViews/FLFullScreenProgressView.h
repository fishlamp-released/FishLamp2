//
//  FLFullScreenProgress.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/30/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLWidgetView.h"
#import "FLProgressViewController.h"
#import "FLGradientWidget.h"

@interface FLFullScreenProgressView : FLWidgetView<FLProgressView> {
@private
    FLGradientWidget* _backgroundWidget;
	UILabel* _titleLabel;
    UIProgressView* _progress;
    UIActivityIndicatorView* _spinner;
}

@property (readwrite, retain, nonatomic) NSString* title;

@property (readwrite, assign, nonatomic) BOOL progressBarHidden;

- (void) updateProgress:(unsigned long long) amountWritten 
            totalAmount:(unsigned long long) totalAmount;

@end
