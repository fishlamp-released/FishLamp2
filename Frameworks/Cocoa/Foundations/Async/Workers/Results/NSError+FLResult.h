//
//  NSError+FLResult.h
//  Downloader
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (FLResult)
+ (id) failedResultError;
@end