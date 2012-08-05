//
//  FLCodeScope.h
//  FishLampCore
//
//  Created by Mike Fullerton on 5/26/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

@class FLCodeScopeFormatter;

@interface FLCodeScope : NSObject {
@private
    NSString* _openTag;
    NSString* _closeTag;
    FLCodeScopeFormatter* _formatter;
}

@property (readwrite, strong, nonatomic) FLCodeScopeFormatter* formatter;

/// Open tag (may be nil)

@property (readwrite, strong, nonatomic) NSString* openTag;

/// Close tag (may be nil)

@property (readwrite, strong, nonatomic) NSString* closeTag;

/// Init with open and close tag (or nil for either)

- (id) initWithOpenTag:(NSString*) tag closeTag:(NSString*) closeTag;

/// Create a new open scope with open and close tag (or nil for either)

+ (id) codeScope:(NSString*) openTag closeTag:(NSString*) closeTag;

@end