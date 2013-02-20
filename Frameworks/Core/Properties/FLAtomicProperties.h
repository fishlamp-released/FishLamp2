//
//  FLAtomicProperties.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"
#import "FLAtomic.h"

#define FLSythesizeAtomicInt32Getter(__GETTER__, __TYPE__, __MEMBER_NAME__) \
    - (__TYPE__) __GETTER__ { \
        return (__TYPE__) FLAtomicGet32((int32_t*) &(__MEMBER_NAME__)); \
        } 

#define FLSythesizeAtomicInt32Setter(__SETTER__, __TYPE__, __MEMBER_NAME__) \
    - (void) __SETTER__:(__TYPE__) value { \
        FLAtomicSet32((int32_t*) &(__MEMBER_NAME__), (int32_t)value); \
        }

#define FLSythesizeAtomicInt32Property(__GETTER__, __SETTER__, __TYPE__, __MEMBER_NAME__) \
    FLSythesizeAtomicInt32Getter(__GETTER__, __TYPE__, __MEMBER_NAME__) \
    FLSythesizeAtomicInt32Setter(__SETTER__, __TYPE__, __MEMBER_NAME__)
    
    
extern id FLAtomicPropertyGet(id __strong * addr);
extern void FLAtomicPropertySet(id __strong * addr, id newValue, dispatch_block_t setter);
extern void FLAtomicPropertyCopy(id __strong * addr, id newValue, dispatch_block_t setter);

//- (NSString *) name {
//    return FLAtomicGetPropertyValue(&_name);
//}
//- (void)setName:(NSString *) name {
//    FLAtomicSetPropertyValue(&_name, name, NO);
//}
