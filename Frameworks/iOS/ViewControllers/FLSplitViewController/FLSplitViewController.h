//
//  FLSplitViewController.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/4/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLViewController.h"
#import "FLSplitterView.h"

@interface FLSplitViewController : FLViewController<FLSplitterViewDelegate> {
@private
    UIViewController* _topViewController;
    UIViewController* _bottomViewController;
    
    FLSplitterView* _splitterView;
    CGFloat _bottomPercentage;
}

@property (readonly, strong, nonatomic) UIViewController* topViewController;
@property (readonly, strong, nonatomic) UIViewController* bottomViewController;

- (id) initWithTopViewController:(UIViewController*) topViewController 
            bottomViewController:(UIViewController*) bottomViewController;

+ (FLSplitViewController*) splitViewController:(UIViewController*) topViewController
                          bottomViewController:(UIViewController*) bottomViewController;



@end
