//
//  FLAlertViewController.h
//  FishLamp-iOS
//
//  Created by Mike Fullerton on 5/13/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAutoPositionedViewController.h"
#import "FLAlertView.h"

@interface FLAlertViewController : FLAutoPositionedViewController {
@private
    BOOL _autoDismiss;
    FLButton* _pressedButton;
}

// Note: Use setTitle to set title.
@property (readonly, strong, nonatomic) FLAlertView* alertView;

@property (readonly, strong, nonatomic) FLButton* pressedButton;

@property (readwrite, assign, nonatomic) BOOL autoDismiss;

@property (readwrite, strong, nonatomic) NSString* message;

- (id) initWithTitle:(NSString*) title;

- (id) initWithTitle:(NSString*) title
             message:(NSString*) message;

+ (id) alertViewController;

+ (id) alertViewController:(NSString*) title;

+ (id) alertViewController:(NSString*) title
                   message:(NSString*) message;
                                       
- (void) addButton:(FLButton*) button;
                                      
@end
