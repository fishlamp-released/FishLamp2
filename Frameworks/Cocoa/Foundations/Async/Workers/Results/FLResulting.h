//
//  FLResulting.h
//  Downloader
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@protocol FLResulting <NSObject>
@property (readonly, strong) NSError* error;
@property (readonly, strong) id result;
@property (readonly, assign) BOOL succeeded;
@property (readonly, assign) BOOL failed;
@end
