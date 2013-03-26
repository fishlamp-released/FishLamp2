//
//  FLTrace.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTraceOff.h"

#if DEBUG

//#undef TRACE
//#undef FLTrace
//#undef FLTraceIf
//
//#define TRACE 1

#define FLTrace(__FORMAT__, ...) \
        FLLogWithType(FLLogTypeTrace, __FORMAT__, ##__VA_ARGS__)

#define FLTraceIf(__CONDITION__, __FORMAT__, ...) \
        if(__CONDITION__) FLLogWithType(FLLogTypeTrace, __FORMAT__, ##__VA_ARGS__)

#endif


