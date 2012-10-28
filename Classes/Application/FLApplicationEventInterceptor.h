//
//  FLApplicationEventInterceptor.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLApplicationEventInterceptor <NSObject>
- (BOOL) didInterceptEvent:(UIEvent*) event;
@end
