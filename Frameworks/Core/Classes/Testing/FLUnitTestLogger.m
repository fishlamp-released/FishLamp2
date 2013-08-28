//
//  FLUnitTestLogger.m
//  FishLampCore
//
//  Created by Mike Fullerton on 8/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLUnitTestLogger.h"

@implementation FLUnitTestLogger

FLSynthesizeSingleton(FLUnitTestLogger)

- (NSArray*) array {
    return _loggers;
}

- (id) init {	
	self = [super init];
	if(self) {
        _loggers = [[NSMutableArray alloc] init];
	}
	return self;
}

#if FL_MRC
- (void)dealloc {
	[_loggers release];
	[super dealloc];
}
#endif

//- (void) stringFormatterAppendBlankLine:(FLStringFormatter*) stringFormatter {
//    for(id<FLStringFormatter> logger in _loggers) {
//        [logger stringFormatterAppendBlankLine:logger];
//    }
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
//}
//- (void) stringFormatter:(FLStringFormatter*) stringFormatter
//    appendSelfToStringFormatter:(id<FLStringFormatter>) anotherStringFormatter {
//}


@end
