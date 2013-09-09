//
//  FLDefaultTheme.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/21/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
