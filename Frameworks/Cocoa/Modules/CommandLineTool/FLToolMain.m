//
//  FLToolMain.m
//  FishLampSync
//
//  Created by Mike Fullerton on 11/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLToolMain.h"
#import "FLCommandLineTool.h"
#import "NSString+Lists.h"

int FLToolMain(Class toolClass) {

#if FL_MRC    
    @autoreleasepool {
#endif    
        @try {
            FLConfirmNotNil_v(toolClass, @"FLCommandLineTool needs a tool class type to instatiate");
            
            FLCommandLineTool* tool = FLAutorelease([[toolClass alloc] init]);
            FLConfirmNotNil_v(tool, @"unable to create tool class: %@", NSStringFromClass(toolClass)); 
                        
            NSArray* args = [[NSProcessInfo processInfo] arguments];

            [tool setExecutingInShellAtPath:[NSURL fileURLWithPath:[args objectAtIndex:0]]];
            
            NSArray* argsWithoutPath = [args subarrayWithRange:NSMakeRange(1, args.count -1)];
            

            NSString* string = [NSString concatStringArray:argsWithoutPath delimiter:@" "];

            FLConfirmationFailure_v(@"need a live output to printf");
            [tool parseInput:[FLParseableInput parseableInput:string] output:nil];
        }
        @catch(NSException* ex) {
            NSLog(@"uncaught exception: %@", [ex reason]);
            return 1;
        }
        
        return 0;
#if FL_MRC
    }
#endif    
}