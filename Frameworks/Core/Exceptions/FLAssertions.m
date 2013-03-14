//
//  FLAssertions.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAssertions.h"
id _FLAssertIsClass(id object, Class aClass) {
    if(object) {
        FLAssertNotNil_v(aClass, @"class for %@ is nil", NSStringFromClass(aClass));
        FLAssert_v([object isKindOfClass:aClass], 
            @"expecting type of %@ but got %@", 
            NSStringFromClass(aClass), 
            NSStringFromClass([object class]));
    }
    return object;
}

id _FLAssertConformsToProtocol(id object, Protocol* proto) {
    if(object) {
        FLAssert_v([object conformsToProtocol:proto], @"expecting object to implement protocol: %@", NSStringFromProtocol(proto));
    }
    return object;
}
