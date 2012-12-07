//
//  FLGeometryCompatibility.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#if IOS
    #define CGPoint CGPoint
    #define CGRect CGRect
    #define FLSize CGSize
    #define FLEdgeInsets UIEdgeInsets
#else
//    #define CGPoint CGPoint
//    #define CGRect CGRect
//    #define FLSize CGSize

//    #define CGPoint NSPoint
//    #define CGRect NSRect
//    #define FLSize NSSize
    #define FLEdgeInsets NSEdgeInsets
#endif

