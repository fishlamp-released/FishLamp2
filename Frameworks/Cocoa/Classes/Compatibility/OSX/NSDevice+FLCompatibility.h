//
//  UIDevice.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if OSX
#import <Cocoa/Cocoa.h>

    #define DeviceIsMac()   YES
    #define DeviceIsPad()   NO
    #define DeviceIsPhone() NO
    #define DeviceIsPod()   NO
    #define DeviceIsSimulator() NO

@interface UIDevice : NSObject {
}

@end
#endif

