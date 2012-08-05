//
//  FLLoggerInlines.m
//  FishLampCore
//
//  Created by Mike Fullerton on 5/18/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

FL_SHIP_ONLY_INLINE
void FLLoggerLog(FLLogger_t* logger, FLLoggerLevel level, const char* file, int lineNum, NSString* line) {

#if DEBUG
    NSCAssert(![line isEqualToString:@"(null)"], @"got null string in logger");
    NSCAssert(line != nil, @"logger line is nil");
// can't use our own assert becuase it calls the logger!
    NSCAssert(logger->logLevel >= FLLoggerLevelHigh && logger->logLevel <= FLLoggerLevelLow, @"logger level at invalid level");
    NSCAssert(level >= FLLoggerLevelHigh && level <= FLLoggerLevelLow, @"sending in invalid logger level");
#endif

    if( level >= FLLoggerLevelHigh && 
        level < FLLoggerLevelOff && 
        level <= logger->logLevel && 
        logger->outputDescriptors[level].enabled) {
#if DEBUG
    // can't use our own assert becuase it calls the logger!
        NSCAssert(logger->outputDescriptors[level].loggerOutput != nil, @"logger output is nil");
        NSCAssert(logger->outputDescriptors[level].lineFormatter != nil,  @"logger output is nil");
#endif        
            
        logger->outputDescriptors[level].loggerOutput(
            logger->outputDescriptors[level].lineFormatter(level, file, lineNum, line));
    }
}

FL_SHIP_ONLY_INLINE
void FLLoggerSetLevel(FLLogger_t* logger, FLLoggerLevel level) {
    logger->logLevel = level;
}

FL_SHIP_ONLY_INLINE
FLLoggerLevel FLLoggerGetLevel(FLLogger_t* logger) {
    return logger->logLevel;
}

FL_SHIP_ONLY_INLINE
void FLLoggerSetOutputDescriptor(FLLogger_t* logger, FLLoggerLevel level, FLLoggerOutputDescriptor_t descriptor) {
    logger->outputDescriptors[level] = descriptor;
}

FL_SHIP_ONLY_INLINE
FLLoggerOutputDescriptor_t* FLLoggerGetOutputDescriptor(FLLogger_t* logger, FLLoggerLevel level) {
    return &(logger->outputDescriptors[level]);
}

FL_SHIP_ONLY_INLINE
void FLLoggerSetLoggerOutput(FLLogger_t* logger, FLLoggerLevel level, FLLoggerOutput output) {
    logger->outputDescriptors[level].loggerOutput = output;
}

FL_SHIP_ONLY_INLINE
void FLLoggerSetLineFormatter(FLLogger_t* logger, FLLoggerLevel level, FLLoggerLineFormatter formatter) {
    logger->outputDescriptors[level].lineFormatter = formatter;
}

FL_SHIP_ONLY_INLINE
NSString* FLLoggerDefaultLineFormatter(FLLoggerLevel level, const char* file, int line, NSString* logString) {
    return logString ? logString : @"";
}

