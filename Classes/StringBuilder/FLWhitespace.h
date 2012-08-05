//
//  FLWhitespace.h
//  FishLampCore
//
//  Created by Mike Fullerton on 5/25/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

/// FLWhitespaceDefaultEOL is the default EOL (\\n)

#define FLWhitespaceDefaultEOL         @"\n"

/// FLWhitespaceTabTab is defines a "tab style" behavior - e.g. it uses \\t not "    " for a tab.

#define FLWhitespaceTabTab             @"\t"

/// FLWhitespaceFourSpacesTab defines a four character tab. This is the default tab.

#define FLWhitespaceFourSpacesTab      @"    " // 4 spaces

#ifndef FLWhitespaceDefaultTabString

/// FLWhitespaceDefaultTabString defines the default tab string. You can override this in your prefix file.

#define FLWhitespaceDefaultTabString FLWhitespaceFourSpacesTab
#endif

/// FLWhitespace defines how a builder handles whitespace during a build. With this you can control tabs and LF.

@interface FLWhitespace : NSObject {
@private
    NSString* _eolString;
    NSString* _tabString;
    NSString* _cachedTabs[100];
}

/// Create a whitespace

+ (FLWhitespace*) whitespace;

/// Set the eolString here, e.g. \\n or \\r\\n. See FLWhitespaceDefaultEOL

@property (readwrite, strong, nonatomic) NSString* eolString;

/// Set teh tabString. See FLWhitespaceFourSpacesTab or FLWhitespaceTabTab

@property (readwrite, strong, nonatomic) NSString* tabString; 

/// returns tabString for indent level. This is cached and built once for the life of the formatter.

- (NSString*) tabStringForScope:(NSInteger) indent;

/// returns a formatter built with default EOL and default tab string.

+ (FLWhitespace*) tabbedFormat;

/// returns a formatter that doesn't insert EOL or tabs (e.g. you're sending XML in a HTTP request)

+ (FLWhitespace*) compressedFormat;

@end

