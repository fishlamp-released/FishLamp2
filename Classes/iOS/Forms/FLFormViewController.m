//
//  FLFormViewController.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/30/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLFormViewController.h"

@interface FLFormViewController ()
@property (readwrite, strong, nonatomic) FLEditController* dataSource;
@end

@implementation FLFormViewController

@synthesize dataSource = _dataSource;

- (id) init {
    self = [super init];
    if(self) {
//        self.dataSource = [FLEditController dataSource];
//        self.dataSource.delegate = self;
    }
    
    return self;
}

- (void) dataSource:(FLEditController*) dataSource
   didReplaceObject:(id) previousObjectOrNil
         withObject:(id) newObjectOrNil
            forPath:(NSString*) path {
}


#if FL_MRC
- (void) dealloc {
    FLRelease(_dataSource);
    FLSuperDealloc();
}
#endif

@end
