//
//  GtCachedAuthenticationToken.h
//  MyZen
//
//  Created by Mike Fullerton on 2/5/10.
//  Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtCachedAuthenticationTokenBase.h"

@interface GtCachedAuthenticationToken : GtCachedAuthenticationTokenBase {
}

+ (void) deleteFromCache;
+ (void) saveToCache:(NSString*) token;
+ (BOOL) loadFromCache:(NSString**) outToken;

@end
