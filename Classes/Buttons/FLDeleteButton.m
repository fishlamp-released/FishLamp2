//
//  FLDeleteButton.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
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
    return autorelease_([[[self class] alloc] initWithTitle:NSLocalizedString(@"Delete", nil)]);
}

+ (FLButton*) deleteButton:(FLButtonPress)onPress {
    return autorelease_([[[self class] alloc] initWithTitle:NSLocalizedString(@"Delete", nil) onPress:onPress]);
}

+ (FLButton*) removeButton {
    return autorelease_([[[self class] alloc] initWithTitle:NSLocalizedString(@"Remove", nil)]);
}

+ (FLButton*) removeButton:(FLButtonPress)onPress {
    return autorelease_([[[self class] alloc] initWithTitle:NSLocalizedString(@"Remove", nil) onPress:onPress]);
}



@end
