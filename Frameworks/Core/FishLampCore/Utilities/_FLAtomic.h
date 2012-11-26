//
//  _FLAtomicBitFlags.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

// in private file for readability

NS_INLINE
void FLAtomicSet64_(int64_t *target, int64_t new_value) {
    while (true) {
        int64_t old_value = *target;
        if (OSAtomicCompareAndSwap64Barrier(old_value, new_value, target)) {
            return;
        }
    }
}


NS_INLINE
int64_t FLAtomicGet64_(int64_t *target) {
    while (true) {
        int64_t value = *target;
        if (OSAtomicCompareAndSwap64Barrier(value, value, target)) {
            return value;
        }
    }
    
    return 0;
}


NS_INLINE
void FLAtomicSet32_(int32_t *target, int32_t new_value) {
    while (true) {
        int32_t old_value = *target;
        if (OSAtomicCompareAndSwap32Barrier(old_value, new_value, target)) {
            return;
        }
    }
}


NS_INLINE
int32_t FLAtomicGet32_(int32_t *target) {
    while (true) {
        int32_t value = *target;
        if (OSAtomicCompareAndSwap32Barrier(value, value, target)) {
            return value;
        }
    }
    
    return 0;
}

