//
//  FLResultProducing.h
//  Downloader
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLResult.h"

@protocol FLResultProducing <NSObject>
@property (readonly, strong) FLResult result;
@end

