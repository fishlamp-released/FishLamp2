//
//  NSObject+Copying.h
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLamp.h"

@protocol FLCopyable <NSObject>
- (void) copySelfTo:(id) object;
@end

@interface NSObject (FLCopyable)
- (void) copySelfTo:(id) object;
@end

extern id FLCopyOrRetainObject(id src);
