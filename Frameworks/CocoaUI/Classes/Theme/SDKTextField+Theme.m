//
//  SDKTextField+Theme.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "SDKTextField+Theme.h"

@implementation SDKTextField (Theme)
+ (SEL) themeSelector {
    return @selector(applyThemeToTextField:);
}
@end

@implementation FLTheme (SDKTextField)
- (void) applyThemeToTextField:(SDKTextField*) textField {
    [textField setTextColor:self.applicationTextStyle.enabledStyle.textColor];
    [textField setFont:self.applicationTextStyle.textFont];
    
//    [self.applicationFont themeFontWithIBFont:[textField font]]];
}
@end