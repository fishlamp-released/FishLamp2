//
//  FishLampCompatibility.h
//  FishLampCompatibility
//
//  Created by Mike Fullerton on 1/6/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#if OSX
#import "UIKit+OSX.h"
#define FLCompatible(__NAME__) NS##__NAME__
#endif

#if IOS
#import "AppKit+iOS.h"
#define FLCompatible(__NAME__) UI##__NAME__
#endif

