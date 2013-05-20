//
//  SDKApplication+FLAdditionas.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/30/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "SDKApplication+FLAdditions.h"
#import "NSBundle+FLAdditions.h"

@implementation SDKApplication (FLAdditionas)

+ (void) openURLFromBundleWithKey:(NSString*) key {
    
    NSURL* url = [[NSBundle mainBundle] URLInInfoDictionaryForKey:key];
    if(url) {
#if OSX    
        [[NSWorkspace sharedWorkspace] openURL:url];
#else 

#endif
    }


}

@end
