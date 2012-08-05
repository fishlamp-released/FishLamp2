//
//  FLLoginViewController.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/18/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLLoginViewController.h"

#import "FLEditableItemsContainerView.h"

@interface FLLoginViewController ()

@end

@implementation FLLoginViewController

+ (CGSize) defaultAutoPostionedViewSize {
    return DeviceIsPad() ? CGSizeMake(320,200) : CGSizeMake(300,200);
}

- (id) init {
    self = [super init];
    if(self) {
        self.transitionAnimation = [FLPopinViewControllerAnimation viewControllerTransitionAnimation];
        self.title = @"Log in to your account";
    }
    
    return self;
}

- (UIView*) createContentView {

    FLEditableItemsContainerView* view = FLReturnAutoreleased([[FLEditableItemsContainerView alloc] initWithFrame:CGRectMake(0, 0, 100, 40)]);

    FLEditableItemView* userName = [FLEditableItemView editableItemView];
    userName.placeHolderText = @"Username or E-mail";
    userName.value.keyboardType = UIKeyboardTypeEmailAddress;
    userName.value.autocorrectionType = UITextAutocorrectionTypeNo;
    userName.value.autocapitalizationType = UITextAutocapitalizationTypeNone;
    userName.value.enablesReturnKeyAutomatically = YES;


//    service.onValidate = [FLEditableItemView validateIsNumber];
    [view setEditableItemView:userName forKey:@"username"];
    
    FLEditableItemView* password = [FLEditableItemView editableItemView];
    password.placeHolderText = @"Password";
    password.value.secureTextEntry = YES;
    password.value.keyboardType = UIKeyboardTypeDefault;
    password.value.autocorrectionType = UITextAutocorrectionTypeNo;
    password.value.returnKeyType = UIReturnKeyGo;
    password.value.enablesReturnKeyAutomatically = YES;
    password.value.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [view setEditableItemView:password forKey:@"password"];


    return view;
}

- (void) viewDidLoad {
    [super viewDidLoad];

//    [self addButtonWithTitle:@"Cancel" onPress:^(id controller) {
//        [self dismissViewControllerAnimated:YES];
//    }];
//
//    [self addButtonWithTitle:@"Login" onPress:^(id controller) {
//
//        if([self.contentView validateAllItems]) {
//            [self dismissViewControllerAnimated:YES];
//        }
//    }];

}

@end
