//
//  FLActivityLog.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLActivityLog.h"
#import "FLAttributedString.H"

NSString* const FLActivityLogUpdated = @"FLActivityLogUpdated";
NSString* const FLActivityLogStringKey = @"FLActivityLogStringKey";

@implementation FLActivityLog

FLSynthesizeSingleton(FLActivityLog);

- (id) init {
    self = [super init];
    if(self) {
        _log = [[FLPrettyAttributedString alloc] init];
        _log.delegate = self;
    }
    return self;
}

- (void) dealloc {
    _log.delegate = nil;
#if FL_MRC
    [_log release];
    [super dealloc];
#endif
}

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

- (void) indent {
    [_log indent];
}

- (void) outdent {
    [_log outdent];
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

- (NSError*) exportToPath:(NSURL*) url {
    NSString* log = [self string];
    NSError* err = nil;
    [log writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:&err];
    return FLAutorelease(err);
}

- (void) prettyString:(FLPrettyString*) prettyString didAppendAttributedString:(NSAttributedString*) string {
    [[NSNotificationCenter defaultCenter] postNotificationName:FLActivityLogUpdated object:self userInfo:[NSDictionary dictionaryWithObject:string forKey:FLActivityLogStringKey]];
}

- (void) appendURL:(NSURL*) url string:(NSString*) string {
    NSMutableAttributedString* urlString = [NSMutableAttributedString mutableAttributedString:string 
                                                                                          url:url 
                                                                                        color:[NSColor blackColor] 
                                                                                    underline:YES];
    [self appendAttributedString:urlString];
}

- (void) appendLineWithURL:(NSURL*) url string:(NSString*) string {
    NSMutableAttributedString* urlString = [NSMutableAttributedString mutableAttributedString:string 
                                                                                          url:url 
                                                                                        color:[NSColor blackColor] 
                                                                                    underline:YES];
    [self appendLineWithAttributedString:urlString];
}

- (void) clear {
    [_log deleteAllCharacters];
}


@end
