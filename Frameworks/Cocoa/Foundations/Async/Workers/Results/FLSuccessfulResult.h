//
//  FLSuccessfulResult.h
//  Downloader
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLResultObject.h"

// this is essentially a singleton.
@interface FLSuccessfulResult : FLResultObject
+ (id) successfullResult;
@end