//
//  NSObject+Copying.h
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"

@interface NSObject (Copying)
- (void) copySelfTo:(id) object;
@end
