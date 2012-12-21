//
//  FLAssertions.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAssertions.h"
#if DEBUG
id _FLAssertObjectIsType(id object, NSString* className) {
    if(object) {
        Class aClass = NSClassFromString(className);
        FLAssertNotNil_v(aClass, @"class for %@ is nil", className);
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
#endif