//
//  FLCodeScopeFormatter.h
//  FishLampCore
//
//  Created by Mike Fullerton on 5/25/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLCodeScope.h"

@class FLCodeBuilder;

/// FLCodeScopeId is a four character literal.

/// This is for speed of comparison. We chose a four character literal because it's more human readable and easier 
/// to easily crate new ones. For example, you could have a bunch of "c" type scope types that start with c, like 'cCod' (c code), 'cCom' (c comment), etc..
typedef NSUInteger FLCodeScopeId;

/// FLCodeScopeFormatter receives events to format (append) strings to the current build string.

@interface FLCodeScopeFormatter : NSObject {
}

/// Get scopeId, this is a four char literatal like 'fFmt'. Note: We use this instead of an object for speed during the build.
@property (readonly, assign, nonatomic) FLCodeScopeId scopeId;

/// create a new scope formatter.

+ (FLCodeScopeFormatter*) scopeFormatter;

/// override this in your subclasses

+ (FLCodeScopeId) scopeId;

/// Does nothing by default.

- (void) openScope:(FLCodeBuilder*) codeBuilder
             scope:(FLCodeScope*) scope;

/// Does nothing by default

- (void) closeScope:(FLCodeBuilder*) codeBuilder
              scope:(FLCodeScope*) scope;

/// 

- (void) appendLine:(FLCodeBuilder*) codeBuilder
              scope:(FLCodeScope*) scope 
               line:(NSString*) line;

- (void) appendScopedLine:(FLCodeBuilder*) codeBuilder
                  scope:(FLCodeScope*) scope 
                   line:(NSString*) line;

@end

