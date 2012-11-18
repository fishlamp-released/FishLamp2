//
//  main.m
//  Fluffy
//
//  Created by Mike Fullerton on 6/21/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLTestRunner <NSObject>
+ (void) runTests;
@end

int main(int argc, char *argv[]) {
    
    int count = 0;
    for(int i = 1; i < argc; i++) {
        NSString* path = [NSString stringWithCString:argv[i] encoding:NSASCIIStringEncoding];
        if([path hasSuffix:@"bundle"]) {
            NSBundle *bundle = [NSBundle bundleWithPath:path];
            if(bundle) {
                [bundle load];
                id class = NSClassFromString(@"FLUnitTestRunner");
                if(class) {
                    [class runTests];
                    ++count;
                }
                else {
                    NSLog(@"FLUnitTestRunner not found in test bundle");
                }
                [bundle unload];
            }
        }
    }
    
    if(count == 0) {
        NSLog(@"Don't understand input: arguments are paths to FLTestBundles");
        
        for(int i = 0; i < argc; i++) {
            printf("%s ", argv[i]);
        }
        printf("\n");
        
        return 1;
    }
    return 0;
}
