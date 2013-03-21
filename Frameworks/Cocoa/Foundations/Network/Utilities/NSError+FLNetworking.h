//
//  NSError+_FLNetworking_.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (FLNetworking)
@property (readonly, nonatomic) BOOL didLoseNetwork;
@property (readonly, nonatomic) BOOL isNotConnectedToInternetError;
@end
