//
//  FLDeleteButton.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLDeleteButton.h"

@implementation FLDeleteButton

- (id) init {
    self = [super init];
    if(self) {
        self.buttonRole = FLButtonRoleDelete;
    }
    
    return self;
}

+ (FLButton*) deleteButton {
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"Delete", nil)]);
}

+ (FLButton*) deleteButton:(FLButtonPress)onPress {
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"Delete", nil) onPress:onPress]);
}

+ (FLButton*) removeButton {
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"Remove", nil)]);
}

+ (FLButton*) removeButton:(FLButtonPress)onPress {
    return FLAutorelease([[[self class] alloc] initWithTitle:NSLocalizedString(@"Remove", nil) onPress:onPress]);
}



@end
