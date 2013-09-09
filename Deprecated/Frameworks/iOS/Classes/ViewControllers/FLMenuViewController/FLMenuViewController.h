//
//  FLMenuViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/15/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLViewController.h"
#import "FLMenuView.h"

@interface FLMenuViewController : FLViewController {
@private
    FLMenuView* _menuView;
}

@property (readonly, retain, nonatomic) FLMenuView* menuView;

- (id) initWithTitle:(NSString*) title;

+ (FLMenuViewController*) menuViewController:(NSString*) title;

- (void) updateLayout;

@end
