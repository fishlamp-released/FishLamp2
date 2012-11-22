//
//  FLDefaultTheme.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/21/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLDefaultTheme.h"

#import "FLDefaultAlertViewThemeApplicator.h"

@implementation FLDefaultTheme

FLSynthesizeSingleton(FLDefaultTheme);

- (id) init {
    self = [super init];
    if(self) {
        self.alertViewThemeApplicator = [FLDefaultAlertViewThemeApplicator alertViewThemeApplicator];
    }
    
    return self;
}

@end
