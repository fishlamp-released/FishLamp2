//
//  FLAssertions.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/7/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAssertions.h"
#import "FishLampCore.h"

id _FLAssertIsClass(id object, Class aClass) {
    if(object) {
        FLAssertNotNilWithComment(aClass, @"class for %@ is nil", NSStringFromClass(aClass));
        FLAssertWithComment([object isKindOfClass:aClass], 
            @"expecting type of %@ but got %@", 
            NSStringFromClass(aClass), 
            NSStringFromClass([object class]));
    }
    return object;
}

id _FLAssertConformsToProtocol(id object, Protocol* proto) {
    if(object) {
        FLAssertWithComment([object conformsToProtocol:proto], @"expecting object to implement protocol: %@", NSStringFromProtocol(proto));
    }
    return object;
}
