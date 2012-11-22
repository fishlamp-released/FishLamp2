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
    
    
    
// EXPERIMENTAL

// NOT TESTED 

// from: http://cocoawithlove.com/2009/10/memory-and-thread-safe-custom-property.html

#define FLAtomicRetainedSetToFrom(dest, source) \
    objc_setProperty(self, _cmd, (ptrdiff_t)(&dest) - (ptrdiff_t)(self), source, YES, NO)

#define FLAtomicCopiedSetToFrom(dest, source) \
    objc_setProperty(self, _cmd, (ptrdiff_t)(&dest) - (ptrdiff_t)(self), source, YES, YES)

#define FLAtomicAutoreleasedGet(source) \
    objc_getProperty(self, _cmd, (ptrdiff_t)(&source) - (ptrdiff_t)(self), YES)

#define FLAtomicStructToFrom(dest, source) \
    objc_copyStruct(&dest, &source, sizeof(__typeof__(source)), YES, NO)

// synthesize for atomic ints