//
//  FLDenyButton.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLDenyButton.h"

@implementation FLDenyButton

- (id) init {
    self = [super init];
    if(self) {
        self.buttonRole = FLButtonRoleCancel;
    }
    
    return self;
}

+ (FLButton*) cancelButton:(FLButtonPress)onPress {
    return FLReturnAutoreleased([[[self class] alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) onPress:onPress]);
}

+ (FLButton*) cancelButton {
    return FLReturnAutoreleased([[[self class] alloc] initWithTitle:NSLocalizedString(@"Cancel", nil)]);
}

+ (FLButton*) noButton {
    return FLReturnAutoreleased([[[self class] alloc] initWithTitle:NSLocalizedString(@"No", nil)]);
}

+ (FLButton*) noButton:(FLButtonPress)onPress {
    return FLReturnAutoreleased([[[self class] alloc] initWithTitle:NSLocalizedString(@"No", nil) onPress:onPress]);
}


@end
