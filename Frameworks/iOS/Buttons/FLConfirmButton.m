//
//  FLYesButton.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"OK", nil) onPress:onPress]);
}

+ (FLButton*) okButton {
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"OK", nil)]);
}

+ (FLButton*) yesButton {
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"Yes", nil)]);
}

+ (FLButton*) yesButton:(FLButtonPress)onPress {
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"Yes", nil) onPress:onPress]);
}

+ (FLButton*) saveButton:(FLButtonPress)onPress {
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"Save", nil) onPress:onPress]);
}

+ (FLButton*) saveButton {
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"Save", nil)]);
}





@end
