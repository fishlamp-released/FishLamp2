//
//  FLFormViewController.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/30/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
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
