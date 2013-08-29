//
//  FLUnitTestLoggingManager.m
//  FishLampCore
//
//  Created by Mike Fullerton on 8/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLUnitTestLoggingManager.h"
#import "FLUnitTestLogOutput.h"

@implementation FLUnitTestLoggingManager

FLSynthesizeSingleton(FLUnitTestLoggingManager)

- (NSArray*) array {
    return _loggers;
}

- (id) init {	
	self = [super init];
	if(self) {
        _loggers = [[NSMutableArray alloc] init];
        _stateStack = [[NSMutableArray alloc] init];
	}
	return self;
}

#if FL_MRC
- (void)dealloc {
	[_loggers release];
    [_stateStack release];
	[super dealloc];
}
#endif

- (void) addLogger:(id<FLStringFormatter>) formatter  forLogLevel:(FLUnitTestLogLevel) logLevel {
    [_loggers addObject:[FLUnitTestLogOutput unitTestLogOutput:formatter logLevel:logLevel]];
}

- (void) pushLogger:(id<FLStringFormatter>) formatter forLogLevel:(FLUnitTestLogLevel) logLevel {
    [_loggers insertObject:[FLUnitTestLogOutput unitTestLogOutput:formatter logLevel:logLevel] atIndex:0];
}

- (void) popLogger {

}


- (void) pushLogLevel:(FLUnitTestLogLevel) level {
    [_stateStack addObject:[NSNumber numberWithUnsignedInteger:level]];
}

- (void) popLogLevel {
    [_stateStack removeLastObject];
}

- (void) logInLevelBlock:(FLUnitTestLogLevel) level block:(void (^)()) block {
    [self pushLogLevel:level];
    block();
    [self popLogLevel];
}

- (id<FLStringFormatter>) logger {

//    FLLoggerProxy* arrayProxy = [FLLoggerProxy arrayProxy:_loggers];

    return (id<FLStringFormatter>) self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {

}


//- (void) visitEach:(void (^)(FLUnitTestLogOutput* output)) visitor {
//    FLUnitTestLogLevel level = [[_stateStack lastObject] unsignedIntegerValue];
//    for(FLUnitTestLogOutput* logger in _loggers) {
//        if([logger willLogWithLevel:level]) {
//            visitor(logger);
//        }
//    }
//}
//
//
//- (void) stringFormatterAppendBlankLine:(id<FLStringFormatter>) stringFormatter {
//}
//- (void) stringFormatterOpenLine:(FLStringFormatter*) stringFormatter {
//}
//- (void) stringFormatterCloseLine:(FLStringFormatter*) stringFormatter {
//}
//- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendString:(NSString*) string {
//}
//- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendAttributedString:(NSAttributedString*) attributedString {
//}
//- (void) stringFormatterIndent:(FLStringFormatter*) stringFormatter {
//}
//- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter {
//}
//- (NSUInteger) stringFormatterGetLength:(FLStringFormatter*) stringFormatter {
//    return 0;
//}
//- (void) stringFormatter:(FLStringFormatter*) stringFormatter
//    appendSelfToStringFormatter:(id<FLStringFormatter>) anotherStringFormatter {
//}
////

@end
