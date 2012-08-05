//
//	FLStringBuilder.h
//	PackMule
//
//	Created by Mike Fullerton on 8/25/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLStringBuilder.h"
#import "FLCodeScope.h"
#import "FLCodeScopeFormatter.h"

/// FLCodeBuilder is for building complex code documents - XML, Json, Objective-C, etc.. 

@interface FLCodeBuilder : FLStringBuilder {
@private
    NSDictionary* _scopeFormatters;
    NSMutableArray* _scopeStack;
}

/// Init an empty string builder.

- (id) init;

/// Create an empty string builder.

+ (FLCodeBuilder*) codeBuilder;

// scope

/// Returns the scope stack (filled FLCodeScope objects)

@property (readonly, strong, nonatomic) NSArray* scopeStack;

/// Open a scope with optional open and close tags

/// Not all protocols will have optional tags, for example a tag would be an element name in XML.
- (void) openScope:(FLCodeScopeId) scopeId
           openTag: (NSString*) openTagOrNil
          closeTag:(NSString*) closeTagOrNil;

/// Open a scope where the open and close tag are the same

- (void) openScope:(FLCodeScopeId) scopeId
          bothTags:(NSString*) bothTagsOrNil;
//
///// Open a scope with no tags
//
- (void) openScope:(FLCodeScopeId) scopeId;

/// Close the most recently opened scope (reopens previous scope).

- (void) closeScope;

- (void) skipScope; // skips closing the last scope.

// formatters

/// Get/Set the scope formatters. 

/// This is designed to accept prebuilt "static" collections of scope formatters appropriate for the domain of the string you're building, like XML or Json or objective-c. See FLCodeScopeFormatter.h for more info
@property (readwrite, strong, nonatomic) NSDictionary* scopeFormatters;

/// Get the scope formatter for the type.

/// The scope type is a four char literal like 'fFmt'. This is for performance.
/// @param scopeId a four char literal
- (FLCodeScopeFormatter*) scopeFormatterForscopeId:(FLCodeScopeId) scopeId;

/// override this in your protocol specific subclass

+ (NSDictionary*) defaultScopeFormatters;

@end


@interface NSMutableDictionary (FLCodeBuilder) 
- (void) addCodeScopeFormatter:(FLCodeScopeFormatter*) formatter;
@end




