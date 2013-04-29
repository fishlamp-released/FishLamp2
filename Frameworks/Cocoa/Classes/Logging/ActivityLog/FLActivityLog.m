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

@synthesize activityLogTextFont = _textFont;
@synthesize activityLogTextColor = _textColor;

- (id) init {
    self = [super init];
    if(self) {
        self.stringFormatterOutput = self;
    
        _log = [[FLPrettyAttributedString alloc] init];
        _log.delegate = self;
    }
    return self;
}

- (void) dealloc {
    _log.delegate = nil;
#if FL_MRC
    [_textFont release];
    [_textColor release];
    [_log release];
    [super dealloc];
#endif
}

+ (id) activityLog {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) stringFormatterAppendBlankLine:(FLStringFormatter*) stringFormatter {
    [_log stringFormatterAppendBlankLine:stringFormatter];
}

- (void) stringFormatterOpenLine:(FLStringFormatter*) stringFormatter {

    [_log stringFormatterOpenLine:stringFormatter];
    if(_log.indentLevel == 0) {

        NSString* timeStamp = [NSString stringWithFormat:@"[%@]: ", 
            [NSDateFormatter localizedStringFromDate:[NSDate date] 
                                           dateStyle:NSDateFormatterShortStyle 
                                           timeStyle:kCFDateFormatterLongStyle]];


        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
            [NSColor gray15Color], NSForegroundColorAttributeName, 
            [NSFont boldSystemFontOfSize:[NSFont smallSystemFontSize]], NSFontAttributeName, nil];

        NSMutableAttributedString* string = 
            FLAutorelease([[NSMutableAttributedString alloc] initWithString:timeStamp attributes:attributes]);


        [_log stringFormatter:stringFormatter appendAttributedString:string];

    }
}

- (void) stringFormatterCloseLine:(FLStringFormatter*) stringFormatter {
    [_log stringFormatterCloseLine:stringFormatter];
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendString:(NSString*) string {
    [_log stringFormatter:stringFormatter appendString:string];
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendAttributedString:(NSAttributedString*) attributedString {
    [_log stringFormatter:stringFormatter appendAttributedString:attributedString];
}

- (void) stringFormatterIndent:(FLStringFormatter*) stringFormatter {
    [_log stringFormatterIndent:stringFormatter];
}

- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter {
    [_log stringFormatterOutdent:stringFormatter];
}


//- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
//            appendString:(NSString*) string
//  appendAttributedString:(NSAttributedString*) attributedString
//              lineUpdate:(FLStringFormatterLineUpdate) lineUpdate {
//                
//    if(lineUpdate.openLine && _log.indentLevel == 0) {
//        NSString* timeStamp = [NSString stringWithFormat:@"[%@]: ", [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:kCFDateFormatterLongStyle]];
//
//        if(string) {
//            string = [NSString stringWithFormat:@"%@%@", timeStamp, string];
//        }
//        else if(attributedString) {
//            NSMutableAttributedString* newAttrString = [NSMutableAttributedString mutableAttributedString:timeStamp];
//            [newAttrString appendAttributedString:attributedString];
//            attributedString = newAttrString;
//        }
//    }
//
//    [_log stringFormatter:stringFormatter appendString:string appendAttributedString:attributedString lineUpdate:lineUpdate];
//}   

//- (void) indent {
//    [_log indent];
//}
//
//- (void) outdent {
//    [_log outdent];
//}

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

#define kActivityLog @"ActivityLog"

- (NSAttributedString*) prettyString:(FLPrettyString*) prettyString willAppendAttributedString:(NSAttributedString*) string {
    if(_textFont || _textColor) {
    
        NSRange range = string.entireRange;
        NSDictionary* attributes = [string attributesAtIndex:0 effectiveRange:&range];

        NSMutableDictionary* attr = FLMutableCopyWithAutorelease(attributes);
        if(_textFont && [attr objectForKey:NSFontAttributeName] == nil) {
            [attr setObject:[NSFont boldSystemFontOfSize:[NSFont smallSystemFontSize]] forKey:NSFontAttributeName];
        }
        if(_textColor && [attr objectForKey:NSForegroundColorAttributeName] == nil) {
            [attr setObject:[NSColor gray15Color] forKey:NSForegroundColorAttributeName];
        }

        return FLAutorelease([[NSAttributedString alloc] initWithString:string.string attributes:attr]);
    }
    
    return string;
}

- (void) prettyString:(FLPrettyString*) prettyString didAppendAttributedString:(NSAttributedString*) string {
    [[NSNotificationCenter defaultCenter] postNotificationName:FLActivityLogUpdated object:self userInfo:[NSDictionary dictionaryWithObject:string forKey:FLActivityLogStringKey]];
}

- (void) appendURL:(NSURL*) url string:(NSString*) string {
    NSMutableDictionary* attr = [NSMutableDictionary dictionary];
    [attr setObject:url forKey:NSLinkAttributeName];
//    [attr setObject:[NSFont boldSystemFontOfSize:[NSFont smallSystemFontSize]] forKey:NSFontAttributeName];
//    [attr setObject:[NSNumber numberWithBool:NO] forKey:NSUnderlineStyleAttributeName];
//    [attr setAttributedStringColor:[NSColor gray20Color]];
    [self appendAttributedString:FLAutorelease([[NSAttributedString alloc] initWithString:string attributes:attr])];
}

- (void) appendLineWithURL:(NSURL*) url string:(NSString*) string {


//        NSMutableAttributedString* urlString = [NSMutableAttributedString mutableAttributedString:[self.rootGroup relativePathForElement:photoSet]
//                                                                                              url:[NSURL URLWithString:[photoSet PageUrl]] 
//                                                                                            color:[NSColor blackColor] 
//                                                                                        underline:YES];
        




//
//    NSMutableAttributedString* urlString = [NSMutableAttributedString mutableAttributedString:string 
//                                                                                          url:url 
//                                                                                        color:[NSColor blackColor] 
//                                                                                    underline:YES];
    [self appendURL:url string:string];
    [self closeLine];
}

- (void) clear {
    [_log deleteAllCharacters];
}

- (void) appendErrorLine:(NSString*) errorLine {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
        [NSColor redColor], NSForegroundColorAttributeName, 
        [NSFont boldSystemFontOfSize:[NSFont smallSystemFontSize]], NSFontAttributeName, nil];

    NSMutableAttributedString* string = 
        FLAutorelease([[NSMutableAttributedString alloc] initWithString:errorLine attributes:attributes]);

    [self appendLineWithAttributedString:string];

}

- (void) appendBoldTitle:(NSString*) title {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
        [NSColor gray15Color], NSForegroundColorAttributeName, 
        [NSFont boldSystemFontOfSize:[NSFont smallSystemFontSize]], NSFontAttributeName, nil];

    NSMutableAttributedString* string = 
        FLAutorelease([[NSMutableAttributedString alloc] initWithString:title attributes:attributes]);

    [self appendAttributedString:string];
}

- (void) appendBoldTitleLine:(NSString*) title {
    [self appendBoldTitle:title];
    [self closeLine];
}

@end
