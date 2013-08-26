//
//  FLNonretained.h
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 2/5/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCoreRequired.h"
#import "FLObjectProxy.h"

@interface FLNonretained : FLObjectProxy {
@private
    __unsafe_unretained id _representedObject;
}

+ (id) nonretained:(id) object;
@end

@interface NSObject (FLNonretained)
- (id) nonretained_fl;
@end