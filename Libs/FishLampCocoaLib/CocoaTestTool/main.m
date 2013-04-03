//
//  main.m
//  FLCocoaTests
//
//  Created by Mike Fullerton on 4/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTestPath @"/Users/mike/Library/Application Support/com.fishlamp.tests"

//extern int FLTestToolMain(int argc, const char *argv[]);

int main(int argc, const char * argv[]) {

    @autoreleasepool {
        @try {
            NSError* error = nil;
            NSArray* allItems = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:kTestPath error:&error];
            if(error) {
                NSLog([error description]);
                return 1;
            }
            
            for(NSString* path in allItems) {
                NSBundle *framework = [[NSBundle alloc ] initWithPath:path];
                if([framework preflightAndReturnError:&error]) {
                    if([framework load]) {
                        NSLog(@"Loaded: %@", [path lastPathComponent]);
                        [framework unload];
                    }
                }
                else {
                    NSLog([error localizedDescription]);
                }
                FLRelease(framework);
            }

        
            return 0;
        }
        @catch(NSException* ex) {
            NSLog(@"uncaught exception: %@", [ex reason]);
            return 1;
        }
        
        return 0;
    }
    
}

