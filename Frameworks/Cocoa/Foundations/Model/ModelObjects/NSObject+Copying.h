//
//  NSObject+Copying.h
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCore.h"

@protocol FLCopyable <NSObject>
- (void) copySelfTo:(id) object;
@end

@interface NSObject (FLCopyable)
- (void) copySelfTo:(id) object;
@end

extern id FLCopyOrRetainObject(id src);
