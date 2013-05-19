//
//  FLDenyButton.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"Cancel", nil) onPress:onPress]);
}

+ (FLButton*) cancelButton {
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"Cancel", nil)]);
}

+ (FLButton*) noButton {
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"No", nil)]);
}

+ (FLButton*) noButton:(FLButtonPress)onPress {
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"No", nil) onPress:onPress]);
}


@end
