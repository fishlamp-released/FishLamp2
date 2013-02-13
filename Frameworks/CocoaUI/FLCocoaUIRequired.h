//
//  FLCocoaUIRequired.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FishLampCocoa.h"


#if OSX
#import <Quartz/Quartz.h>
#else
#import <QuartzCore/CoreAnimation.h>
#import <CoreText/CoreText.h>
#endif

#import "NSObject+FLTheme.h"
#import "UIView+FLViewGeometry.h"

#define FLWidgetView UIView

