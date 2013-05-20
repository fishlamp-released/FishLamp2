//
//	GtBitFlags.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#include <libkern/OSAtomic.h>

typedef uint32_t GtBit;

#define INLINE_BIT_VERSIONS 0

// don't want to use a macro here because of the repeated bitValue
NS_INLINE BOOL GtBitTest(GtBit mask, GtBit bitValue) {
    return (mask & bitValue) == bitValue;
}

// atomic

// don't want use a macro here because bitValue is modified.
NS_INLINE GtBit GtBitAndAtomic(GtBit mask, GtBit bitValue) {
    return OSAtomicAnd32( mask, &bitValue);
}

// don't want use a macro here because bitValue is modified.
NS_INLINE BOOL GtBitTestAnyAtomic(GtBit mask, GtBit bitValue) {
    return OSAtomicAnd32( mask, &bitValue) > 0;
}

// don't want to use a macro here because of the repeated bitValue
NS_INLINE BOOL GtBitTestAtomic(GtBit mask, GtBit bitValue) {
    GtBit val = bitValue;
    OSAtomicAnd32( mask, &val);
    return val == bitValue; 
}

#if INLINE_BIT_VERSIONS

    NS_INLINE GtBit GtBitAnd(GtBit mask, GtBit bitValue) {
        return mask & bitValue;
    }
    NS_INLINE BOOL GtBitTestAny(GtBit mask, GtBit bitValue) {
        return (mask & bitValue) > 0;
    }
    NS_INLINE void GtBitClear(GtBit* mask, GtBit bitValue) {
        *mask &= ~bitValue;
    }
    NS_INLINE void GtBitSet(GtBit* mask, GtBit bitValue) {
        *mask |= bitValue;
    }
    NS_INLINE void GtBitChange(GtBit* mask, GtBit bitValue, BOOL enableBits) {
        if(enableBits) {
            *mask |= bitValue;
        }
        else {
            *mask &= ~bitValue;
        }
    }
    NS_INLINE BOOL GtBitTest(GtBit mask, GtBit bitValue) {
        return (mask & bitValue) == bitValue;
    }

    // atomic

    NS_INLINE void _FLBitClearAtomic(GtBit* mask, GtBit bitValue) {
        OSAtomicTestAndClear(bitValue, mask);
    }

    NS_INLINE void _FLBitSetAtomic(GtBit* mask, GtBit bitValue) {
        OSAtomicTestAndSet(bitValue, mask);
    }

    NS_INLINE void _FLBitChangeAtomic(GtBit* mask, GtBit bitValue, BOOL enableBits) {
        if(enableBits) {
            OSAtomicTestAndSet(bitValue, mask); 
        } 
        else {
            OSAtomicTestAndClear(bitValue, mask);
        }
    }

#else 

    #define GtBitTestAny(__MASK__, __BIT_VALUE__) (((__MASK__) & (__BIT_VALUE__)) > 0)

// Note modifiers expect pointer to the mask value, eg. GtBitAnd(&myMask, value)

    #define GtBitAnd(__MASK__, __BIT_VALUE__) ((__MASK__) & (__BIT_VALUE__))

    #define GtBitClear(__MASK__, __BIT_VALUE__) ((__MASK__) &= ~(__BIT_VALUE__))

    #define GtBitSet(__MASK__, __BIT_VALUE__) ((__MASK__) |= (__BIT_VALUE__))

    #define GtBitChange(__MASK__, __BIT_VALUE__, __SET_OR_CLEAR__) \
        if(__SET_OR_CLEAR__) GtBitSet(__MASK__, __BIT_VALUE__); else GtBitClear(__MASK__, __BIT_VALUE__)

    // atomic

    #define GtBitClearAtomic(__MASK__, __BIT_VALUE__) OSAtomicTestAndClear(__BIT_VALUE__, &(__MASK__))

    #define GtBitSetAtomic(__MASK__, __BIT_VALUE__) OSAtomicTestAndSet(__BIT_VALUE__, &(__MASK__))

    #define GtBitChangeAtomic(__MASK__, __BIT_VALUE__, __SET_OR_CLEAR__) \
        if(__SET_OR_CLEAR__) OSAtomicTestAndSet(__BIT_VALUE__, &(__MASK__)); else OSAtomicTestAndClear(__BIT_VALUE__, &(__MASK__));



#endif

#define GtBitMaskTest GtBitTestAny

NS_INLINE
void GtAtomicSet64(int64_t *target, int64_t new_value) {
    while (true) {
        int64_t old_value = *target;
        if (OSAtomicCompareAndSwap64Barrier(old_value, new_value, target)) {
            return;
        }
    }
}

NS_INLINE
uint64_t GtAtomicGet64(int64_t *target) {
    while (true) {
        int64_t value = *target;
        if (OSAtomicCompareAndSwap64Barrier(value, value, target)) {
            return value;
        }
    }
    
    return 0;
}

NS_INLINE
void GtAtomicSet32(int32_t *target, int32_t new_value) {
    while (true) {
        int32_t old_value = *target;
        if (OSAtomicCompareAndSwap32Barrier(old_value, new_value, target)) {
            return;
        }
    }
}

NS_INLINE
uint32_t GtAtomicGet32(int32_t *target) {
    while (true) {
        int32_t value = *target;
        if (OSAtomicCompareAndSwap32Barrier(value, value, target)) {
            return value;
        }
    }
    
    return 0;
}





