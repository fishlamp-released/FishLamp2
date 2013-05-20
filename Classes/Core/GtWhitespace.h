//
//  GtWhitespace.h
//  FishLampCore
//
//  Created by Mike Fullerton on 5/25/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "FishLampMinimum.h"

/// GtWhitespaceDefaultEOL is the default EOL (\\n)

#define GtWhitespaceDefaultEOL         @"\n"

/// GtWhitespaceTabTab is defines a "tab style" behavior - e.g. it uses \\t not "    " for a tab.

#define GtWhitespaceTabTab             @"\t"

/// GtWhitespaceFourSpacesTab defines a four character tab. This is the default tab.

#define GtWhitespaceFourSpacesTab      @"    " // 4 spaces

#ifndef GtWhitespaceDefaultTabString

/// GtWhitespaceDefaultTabString defines the default tab string. You can override this in your prefix file.

#define GtWhitespaceDefaultTabString GtWhitespaceFourSpacesTab
#endif

/// GtWhitespace defines how a builder handles whitespace during a build. With this you can control tabs and LF.

@interface GtWhitespace : NSObject {
@private
    NSString* _eolString;
    NSString* _tabString;
    NSString* _cachedTabs[100];
}

/// Create a whitespace

+ (GtWhitespace*) whitespace;

/// Set the eolString here, e.g. \\n or \\r\\n. See GtWhitespaceDefaultEOL

@property (readwrite, strong, nonatomic) NSString* eolString;

/// Set teh tabString. See GtWhitespaceFourSpacesTab or GtWhitespaceTabTab

@property (readwrite, strong, nonatomic) NSString* tabString; 

/// returns tabString for indent level. This is cached and built once for the life of the formatter.

- (NSString*) tabStringForScope:(NSInteger) indent;

/// returns a formatter built with default EOL and default tab string.

+ (GtWhitespace*) tabbedFormat;

/// returns a formatter that doesn't insert EOL or tabs (e.g. you're sending XML in a HTTP request)

+ (GtWhitespace*) compressedFormat;

@end

