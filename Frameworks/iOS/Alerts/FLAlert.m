//
//  FLAlert.m
//  FishLamp-iOS
//
//  Created by Mike Fullerton on 5/13/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAlert.h"
#import "FLDialogShapeView.h"
#import "UIImage+Colorize.h"

@interface FLAlert ()
@property (readwrite, strong, nonatomic) FLButton* pressedButton;
@end

@implementation FLAlert


@synthesize pressedButton = _pressedButton;
@synthesize autoDismiss = _autoDismiss;

+ (CGSize) defaultAutoPostionedViewSize {
    return DeviceIsPad() ? CGSizeMake(320,200) : CGSizeMake(260,200);
}

+ (id<FLPresentationBehavior>) defaultPresentationBehavior {
    return [FLModalPresentationBehavior instance];
}

+ (FLPopinViewControllerAnimation*) defaultTransitionAnimation {
    return [FLPopinViewControllerAnimation viewControllerTransitionAnimation];
}


- (id) init  {
    FLAssertWithComment([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    self = [super init];
    if(self) {
        self.transitionAnimation = [FLPopinViewControllerAnimation viewControllerTransitionAnimation];
        self.presentationBehavior = [FLModalPresentationBehavior instance];
        self.autoDismiss = YES;

//        self.dialogViewStyle = FLAlertStyleDefault;
    }
    return self;   
}

- (id) initWithTitle:(NSString*) title {
    self = [self init];
    if(self) {
        self.title = title;
    }
    
    return self;
}

- (id) initWithTitle:(NSString*) title
             message:(NSString*) message {
    self = [self initWithTitle:title];
    if(self) {
        self.message = title;
    }
    
    return self;
}

+ (id) alertViewController:(NSString*) title {
    return FLAutorelease([[[self class] alloc] initWithTitle:title]);
}

+ (id) alertViewController:(NSString*) title
                   message:(NSString*) message {
    return FLAutorelease([[[self class] alloc] initWithTitle:title message:message]);
}

- (UIView*) createAutoPositionedViewWithFrame:(CGRect) frame {
    return FLAutorelease([[FLDialogShapeView alloc] initWithFrame:frame]);
}

- (void) applyTheme:(FLTheme*) theme  {
    [super applyTheme:theme];
    
}

+ (id) alertViewController {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) setMessage:(NSString*) message {
    self.alertView.alertMessage = message;
    
}

- (NSString*) message {
    return self.alertView.alertMessage;
}

- (void) viewDidLoad {
    FLAssertWithComment([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");
    [super viewDidLoad];
}

- (void) setTitle:(NSString*) title {
    [super setTitle:title];
    [self.alertView setTitle:title];
}

- (void) addButton:(FLButton*) button {

    FLButtonPress onPress = button.onPress;
    button.onPress = ^(id theButton) {
        self.pressedButton = theButton;
        if(onPress) {
            onPress(self);
        }
        self.pressedButton = nil;
        
        if(self.autoDismiss) {
            [self hideViewController:YES];
        }
    };

    [self.alertView addButton:button];
}

- (FLAlertView*) alertView {
    return (FLAlertView*) self.view;
}


@end




