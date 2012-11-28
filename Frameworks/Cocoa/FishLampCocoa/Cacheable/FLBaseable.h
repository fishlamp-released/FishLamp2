//
//  FLCacheable.h
//  Downloader
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLCacheable <NSObject>
@property (readonly, strong) id cacheInfo;
@end

@interface FLCacheable : NSObject
@end
