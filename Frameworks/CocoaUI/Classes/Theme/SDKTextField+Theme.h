//
//  SDKTextField+Theme.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLTheme.h"

@interface SDKTextField (Theme)

@end

@interface FLTheme (SDKTextField) 
- (void) applyThemeToTextField:(SDKTextField*) textField;
@end