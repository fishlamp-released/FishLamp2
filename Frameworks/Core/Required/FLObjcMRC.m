//
//  FLObjcMRC.m
//  Downloader
//
//  Created by Mike Fullerton on 12/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLObjcMRC.h"

#if FL_MRC

void FLPerformBlockInAutoreleasePool(void (^callback)()) {
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    @try {
        if(callback) {
            callback();
        }
        [pool drain];
    }
    @catch(id exception) {
        [exception retain];
        [pool drain];
        [exception autorelease];
        @throw;
    }
}

#endif

