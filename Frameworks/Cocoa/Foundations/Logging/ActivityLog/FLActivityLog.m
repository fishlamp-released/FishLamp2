//
//  FLActivityLog.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLActivityLog.h"
#import "FLAttributedString.H"

@implementation FLActivityLog

FLSynthesizeSingleton(FLActivityLog);

- (id) init {
    self = [super init];
    if(self) {
        _log = [[FLPrettyAttributedString alloc] init];
        self.delegate = self;
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_log release];
    [super dealloc];
}
#endif

- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
            appendString:(NSString*) string
  appendAttributedString:(NSAttributedString*) attributedString
              lineUpdate:(FLStringFormatterLineUpdate) lineUpdate {
                
    if(lineUpdate.openLine && _log.indentLevel == 0) {
        NSString* timeStamp = [NSString stringWithFormat:@"[%@]: ", [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:kCFDateFormatterLongStyle]];

        if(string) {
            string = [NSString stringWithFormat:@"%@%@", timeStamp, string];
        }
        else if(attributedString) {
            NSMutableAttributedString* newAttrString = [NSMutableAttributedString mutableAttributedString:timeStamp];
            [newAttrString appendAttributedString:attributedString];
            attributedString = newAttrString;
        }
    }

    [_log stringFormatter:stringFormatter appendString:string appendAttributedString:attributedString lineUpdate:lineUpdate];
}   

- (void) stringFormatterIndent:(FLStringFormatter*) stringFormatter {
    [_log stringFormatterIndent:stringFormatter];
}

- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter {
    [_log stringFormatterOutdent:stringFormatter];
}

- (NSString*) string {
    return [_log string];
}

- (NSAttributedString*) attributedString {
    return [_log attributedString];
}

- (NSString*) description {
    return [_log description];
}


@end
