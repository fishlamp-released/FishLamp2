//
//  FLNonRetainedObject.h
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 2/5/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampCore.h"
#import "FLObjectRef.h"

@interface FLNonretainedObject : FLObjectRef

@property (readonly, assign, nonatomic) id object;

+ (FLNonretainedObject*) nonretainedObject:(id) object;

@end

#define FLNonretainedObject(obj) [FLNonretainedObject nonretained:obj]