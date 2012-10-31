//
//  FLYesButton.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLConfirmButton.h"

@implementation FLConfirmButton

- (id) init {
    self = [super init];
    if(self) {
        self.buttonRole = FLButtonRoleConfirm;
    }
    
    return self;
}

+ (FLButton*) okButton:(FLButtonPress)onPress {
    return autorelease_([[[self class] alloc] initWithTitle:NSLocalizedString(@"OK", nil) onPress:onPress]);
}

+ (FLButton*) okButton {
    return autorelease_([[[self class] alloc] initWithTitle:NSLocalizedString(@"OK", nil)]);
}

+ (FLButton*) yesButton {
    return autorelease_([[[self class] alloc] initWithTitle:NSLocalizedString(@"Yes", nil)]);
}

+ (FLButton*) yesButton:(FLButtonPress)onPress {
    return autorelease_([[[self class] alloc] initWithTitle:NSLocalizedString(@"Yes", nil) onPress:onPress]);
}

+ (FLButton*) saveButton:(FLButtonPress)onPress {
    return autorelease_([[[self class] alloc] initWithTitle:NSLocalizedString(@"Save", nil) onPress:onPress]);
}

+ (FLButton*) saveButton {
    return autorelease_([[[self class] alloc] initWithTitle:NSLocalizedString(@"Save", nil)]);
}





@end
