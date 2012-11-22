//
//  FLToolMain.m
//  FishLampSync
//
//  Created by Mike Fullerton on 11/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLToolMain.h"
#import "FLTool.h"

int FLToolMain(int argc, const char *argv[], Class delegateClass) {
    
    FLTool* tool = nil;
    @autoreleasepool {
        @try {
            FLConfirmNotNil_v(delegateClass, @"FLTool needs a delegate!");
        
            id delegate = [delegateClass create];
            FLConfirmNotNil_v(delegate, @"unable to create delegate class: %@", NSStringFromClass(delegateClass));
            
            tool = [FLTool tool];
            tool.delegate = delegate;

            NSMutableArray* parameters = [NSMutableArray arrayWithCapacity:argc];
            for(int i = 0; i < argc; i++) {
                NSString* parm = [NSString stringWithCString:argv[i] encoding:NSASCIIStringEncoding];
                if(i == 0) {
                    tool.startDirectory = parm;
                }
                else {
                    [parameters addObject:parm];
                }
            }
            
            if([tool runToolWithParameters:parameters]) {
                return 1;
            }
        }
        @catch(NSException* ex) {
            NSLog(@"uncaught exception: %@", [ex reason]);
            return 1;
        }
        @finally {
            tool.delegate = nil;
        }
        
        return 0;
    }
}