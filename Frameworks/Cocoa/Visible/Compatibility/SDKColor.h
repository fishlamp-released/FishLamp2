//
//  SDKColor.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FLStaticMemberProperty.h"

#define FLToRgb(__c) (__c * 255.0f) 

#if IOS

    #define SDKColor UIColor

    #define FLRgbColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

    #define FLReturnRGBColor(__RED__,__GREEN__,__BLUE__,__ALPHA__) \
        FLReturnStaticObject([UIColor colorWithRed:__RED__/255.0f green:__GREEN__/255.0f blue:__BLUE__/255.0f alpha:__ALPHA__ ])

    #define FLReturnColor(__RED__,__GREEN__,__BLUE__,__ALPHA__) \
        FLReturnStaticObject([UIColor colorWithRed:__RED__ green:__GREEN__ blue:__BLUE__ alpha:__ALPHA__ ] )
#endif



#if OSX

    #define SDKColor NSColor

    #define FLRgbColor(r,g,b,a) \
        [NSColor colorWithDeviceRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

    #define FLReturnRGBColor(__RED__,__GREEN__,__BLUE__,__ALPHA__) \
        FLReturnStaticObject([NSColor colorWithDeviceRed:__RED__/255.0f green:__GREEN__/255.0f blue:__BLUE__/255.0f alpha:__ALPHA__ ] )

    #define FLReturnColor(__RED__,__GREEN__,__BLUE__,__ALPHA__) \
        FLReturnStaticObject([NSColor colorWithDeviceRed:__RED__ green:__GREEN__ blue:__BLUE__ alpha:__ALPHA__ ] )

#endif


