//
//  FishLampCocoa.h
//  PackMule
//
//  Created by Mike Fullerton on 6/21/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FishLampCore.h"

#import "FishlampCocoaCompatibility.h"
#import "NSObject+GtTheme.h"

#import "UIColor+More.h"

#import "NSObject+Blocks.h"

//#define GtRelease(o) GtRelease(o)

//return \[([A-Za-z_0-9:.\ \(\)\[\]]*)\ autorelease]

// regext to remove GtAlloc:
// find: GtAlloc\(([A-Za-z_0-9\[\]]*)\)
// replace: [\1 alloc]

// regext to add GtRelease:
// \[([A-Za-z_0-9\[\]]*)\ release]
// GtRelease(\1)
#if DEBUG
    #define GT_SHIP_ONLY_INLINE 
#else
    #define GT_SHIP_ONLY_INLINE NS_INLINE
#endif
