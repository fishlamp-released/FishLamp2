//
//	FLBitFlags.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <libkern/OSAtomic.h>
#import "FLCoreFlags.h"
#import "FLCoreObjC.h"

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

typedef uint32_t FLBit;

#define INLINE_BIT_VERSIONS 0

// don't want to use a macro here because of the repeated bitValue
NS_INLINE BOOL FLBitTest(FLBit mask, FLBit bitValue) {
    return (mask & bitValue) == bitValue;
}

// atomic

// don't want use a macro here because bitValue is modified.
NS_INLINE FLBit FLBitAndAtomic(FLBit mask, FLBit bitValue) {
    return OSAtomicAnd32( mask, &bitValue);
}

// don't want use a macro here because bitValue is modified.
NS_INLINE BOOL FLBitTestAnyAtomic(FLBit mask, FLBit bitValue) {
    return OSAtomicAnd32( mask, &bitValue) > 0;
}

// don't want to use a macro here because of the repeated bitValue
NS_INLINE BOOL FLBitTestAtomic(FLBit mask, FLBit bitValue) {
    FLBit val = bitValue;
    OSAtomicAnd32( mask, &val);
    return val == bitValue; 
}

#if INLINE_BIT_VERSIONS

    NS_INLINE FLBit FLBitAnd(FLBit mask, FLBit bitValue) {
        return mask & bitValue;
    }
    NS_INLINE BOOL FLBitTestAny(FLBit mask, FLBit bitValue) {
        return (mask & bitValue) > 0;
    }
    NS_INLINE void FLBitClear(FLBit* mask, FLBit bitValue) {
        *mask &= ~bitValue;
    }
    NS_INLINE void FLBitSet(FLBit* mask, FLBit bitValue) {
        *mask |= bitValue;
    }
    NS_INLINE void FLBitChange(FLBit* mask, FLBit bitValue, BOOL enableBits) {
        if(enableBits) {
            *mask |= bitValue;
        }
        else {
            *mask &= ~bitValue;
        }
    }
    NS_INLINE BOOL FLBitTest(FLBit mask, FLBit bitValue) {
        return (mask & bitValue) == bitValue;
    }

    // atomic

    NS_INLINE void _FLBitClearAtomic(FLBit* mask, FLBit bitValue) {
        OSAtomicTestAndClear(bitValue, mask);
    }

    NS_INLINE void _FLBitSetAtomic(FLBit* mask, FLBit bitValue) {
        OSAtomicTestAndSet(bitValue, mask);
    }

    NS_INLINE void _FLBitChangeAtomic(FLBit* mask, FLBit bitValue, BOOL enableBits) {
        if(enableBits) {
            OSAtomicTestAndSet(bitValue, mask); 
        } 
        else {
            OSAtomicTestAndClear(bitValue, mask);
        }
    }

#else 

    #define FLBitTestAny(__MASK__, __BIT_VALUE__) (((__MASK__) & (__BIT_VALUE__)) > 0)

// Note modifiers expect pointer to the mask value, eg. FLBitAnd(&myMask, value)

    #define FLBitAnd(__MASK__, __BIT_VALUE__) ((__MASK__) & (__BIT_VALUE__))

    #define FLBitClear(__MASK__, __BIT_VALUE__) ((__MASK__) &= ~(__BIT_VALUE__))

    #define FLBitSet(__MASK__, __BIT_VALUE__) ((__MASK__) |= (__BIT_VALUE__))

    #define FLBitChange(__MASK__, __BIT_VALUE__, __SET_OR_CLEAR__) \
        if(__SET_OR_CLEAR__) FLBitSet(__MASK__, __BIT_VALUE__); else FLBitClear(__MASK__, __BIT_VALUE__)

    // atomic

    #define FLBitClearAtomic(__MASK__, __BIT_VALUE__) OSAtomicTestAndClear(__BIT_VALUE__, &(__MASK__))

    #define FLBitSetAtomic(__MASK__, __BIT_VALUE__) OSAtomicTestAndSet(__BIT_VALUE__, &(__MASK__))

    #define FLBitChangeAtomic(__MASK__, __BIT_VALUE__, __SET_OR_CLEAR__) \
        if(__SET_OR_CLEAR__) OSAtomicTestAndSet(__BIT_VALUE__, &(__MASK__)); else OSAtomicTestAndClear(__BIT_VALUE__, &(__MASK__));



#endif

NS_INLINE
void FLAtomicSet64(int64_t *target, int64_t new_value) {
    while (true) {
        int64_t old_value = *target;
        if (OSAtomicCompareAndSwap64Barrier(old_value, new_value, target)) {
            return;
        }
    }
}

NS_INLINE
uint64_t FLAtomicGet64(int64_t *target) {
    while (true) {
        int64_t value = *target;
        if (OSAtomicCompareAndSwap64Barrier(value, value, target)) {
            return value;
        }
    }
    
    return 0;
}

NS_INLINE
void FLAtomicSet32(int32_t *target, int32_t new_value) {
    while (true) {
        int32_t old_value = *target;
        if (OSAtomicCompareAndSwap32Barrier(old_value, new_value, target)) {
            return;
        }
    }
}

NS_INLINE
uint32_t FLAtomicGet32(int32_t *target) {
    while (true) {
        int32_t value = *target;
        if (OSAtomicCompareAndSwap32Barrier(value, value, target)) {
            return value;
        }
    }
    
    return 0;
}





