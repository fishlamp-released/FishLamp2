//
//  FLGeometryCompatibility.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>


#if IOS
    #define FLEdgeInsets                UIEdgeInsets
#else
    #define CGSizeFromString            NSSizeFromString
    #define NSStringFromCGSize          NSStringFromSize
    
    #define CGRectFromString            NSRectFromString
    #define NSStringFromCGRect          NSStringFromRect
    
    #define CGPointFromString           NSPointFromString
    #define NSStringFromCGPoint         NSStringFromPoint

    #define FLEdgeInsets                NSEdgeInsets
#endif

