//
//  FLActivityLog.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLStringFormatter.h"

extern NSString* const FLActivityLogUpdated;
extern NSString* const FLActivityLogStringKey;

@protocol FLActivityLog <FLStringFormatter>

@property (readonly, strong, nonatomic) NSString* string;
@property (readonly, strong, nonatomic) NSAttributedString* attributedString;

- (void) appendURL:(NSURL*) url string:(NSString*) text;
- (void) appendLineWithURL:(NSURL*) url string:(NSString*) text;

- (NSError*) exportToPath:(NSURL*) url;

- (void) clear;

@property (readonly, strong, nonatomic) SDKFont* textFont;
@property (readonly, strong, nonatomic) NSColor* textColor;

@end

@interface FLActivityLog : FLStringFormatter<FLActivityLog, FLPrettyStringDelegate, FLStringFormatterOutput> {
@private 
    FLPrettyAttributedString* _log;
    SDKFont* _textFont;
    NSColor* _textColor;
}

+ (id) activityLog;

@property (readwrite, strong, nonatomic) SDKFont* textFont;
@property (readwrite, strong, nonatomic) NSColor* textColor;

//FLSingletonProperty(FLActivityLog);

@end



