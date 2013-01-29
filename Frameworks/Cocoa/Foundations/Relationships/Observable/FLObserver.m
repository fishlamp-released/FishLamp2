//
//  FLObserver.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObserver.h"

@interface FLObserver ()
@property (readwrite, strong) id listener;
@end

@implementation FLObserver

@synthesize listener = _listener;

- (id) initWithListener:(id) listener {
    self = [super init];
    if(self) {
        self.listener = listener;
    }
    return self;
}

+ (id) observer:(id) listener {
    return FLAutorelease([[[self class] alloc] initWithListener:listener]);
}

#if FL_MRC
- (void) dealloc {
    [_listener release];
    [super dealloc];
}
#endif

- (void) postObservation:(SEL) selector 
              withObject:(id) object1 
              withObject:(id) object2
              withObject:(id) object3
              argCount:(NSInteger) argCount {

    dispatch_async(dispatch_get_main_queue(), ^{
        @try {  
            switch(argCount) {
                case 0: 
                    if(!FLPerformSelector(self, selector)) {
                        FLPerformSelector(_listener, selector);
                    }
                break;

                case 1: 
                    if(!FLPerformSelector1(self, selector, object1)) {
                        FLPerformSelector1(_listener, selector, object1);
                    }
                break;
                
                case 2: 
                    if(!FLPerformSelector2(self, selector, object1, object2)) {
                        FLPerformSelector2(_listener, selector, object1, object2);
                    }
                break;

                case 3: 
                    if(!FLPerformSelector3(self, selector, object1, object2, object3)) {
                        FLPerformSelector3(_listener, selector, object1, object2, object3);
                    }
                break;
            }
        }
        @catch(NSException* ex) {  
            FLAssertFailed_v(@"Not allowed to throw exceptions from object: %@", ex.reason);  
        } 
    });
}              


- (void) postObservation:(SEL) selector  
              fromObject:(id) object {
    [self postObservation:selector withObject:fromObject withObject:nil withObject:nil argCount:1];
}

- (void) postObservation:(SEL) selector 
              withObject:(id) object  
              fromObject:(id) fromObject {
    [self postObservation:selector withObject:fromObject withObject:object withObject:nil argCount:2];
}              

- (void) postObservation:(SEL) selector 
              withObject:(id) object1 
              withObject:(id) object2
              fromObject:(id) fromObject  {
    [self postObservation:selector withObject:fromObject withObject:object1 withObject:object2 argCount:3];
}              

              
@end
