//
//  FLActivityLog.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/2/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampCore.h"
#import "FLStringFormatter.h"
#import "FLCompatibility.h"

extern NSString* const FLActivityLogUpdated;
extern NSString* const FLActivityLogStringKey;

@protocol FLActivityLog <FLStringFormatter>

@property (readonly, strong, nonatomic) NSString* string;
@property (readonly, strong, nonatomic) NSAttributedString* attributedString;

- (void) appendURL:(NSURL*) url string:(NSString*) text;
- (void) appendLineWithURL:(NSURL*) url string:(NSString*) text;
- (void) appendErrorLine:(NSString*) errorLine;
- (void) appendBoldTitle:(NSString*) title;
- (void) appendBoldTitleLine:(NSString*) title;

- (NSError*) exportToPath:(NSURL*) url;

- (void) clear;

@property (readonly, strong, nonatomic) SDKFont* activityLogTextFont;
@property (readonly, strong, nonatomic) NSColor* activityLogTextColor;

@end

@interface FLActivityLog : FLStringFormatter<FLActivityLog, FLPrettyStringDelegate, FLStringFormatterOutput> {
@private 
    FLPrettyAttributedString* _log;
    SDKFont* _textFont;
    NSColor* _textColor;
}

+ (id) activityLog;

@property (readwrite, strong, nonatomic) SDKFont* activityLogTextFont;
@property (readwrite, strong, nonatomic) NSColor* activityLogTextColor;

- (void) appendErrorLine:(NSString*) errorLine;

//FLSingletonProperty(FLActivityLog);

@end



