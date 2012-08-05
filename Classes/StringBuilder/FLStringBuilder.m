//
//  FLStringBuilder.m
//  FishLampCore
//
//  Created by Mike Fullerton on 5/26/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLStringBuilder.h"
#import "NSString+FLCore.h"

@interface FLStringBuilder ()
@property (readonly, strong, nonatomic) NSString* string;
@end

@implementation FLStringBuilder

@synthesize whitespace = _whitespace;
@synthesize indentDepth = _indentDepth;
@synthesize string = _string;

- (void) indent {
    ++_indentDepth;
}

- (void) undent {
    --_indentDepth;
}

- (NSUInteger) length {
    return self.string.length;
}

- (id) initWithCapacity:(NSUInteger) capacity {
    self = [super init]; 
    if(self) {
        self.whitespace = [FLWhitespace tabbedFormat];
        _string = capacity > 0 ? [[NSMutableString alloc] initWithCapacity:capacity] : [[NSMutableString alloc] init];
    	_needsTabs = YES;
	}
    return self; 
}

- (id) init {
    return [self initWithCapacity:0];
}

+ (FLStringBuilder*) stringBuilder {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

+ (FLStringBuilder*) stringBuilderWithCapacity:(NSUInteger) capacity {
    return FLReturnAutoreleased([[[self class] alloc] initWithCapacity:capacity]);
}

#if FL_DEALLOC
- (void) dealloc {
    [_string release];
    [_whitespace release];
    [super dealloc];
}
#endif

//- (void) removeAllLines {
//    self.mutableString = [NSMutableString string];
//}

- (NSString*) eol {
    return self.whitespace ? self.whitespace.eolString : @"";
}

- (NSString*) tab {
    return self.whitespace ? self.whitespace.tabString : @"";
}

- (NSString*) tabsForIndentDepth {
    return self.whitespace ? [self.whitespace tabStringForScope:self.indentDepth] : @"";
}

- (void) appendLine {
    if(self.whitespace) {
        [_string appendString:self.whitespace.eolString];
    }
	_needsTabs = YES;
}

- (NSString*) buildString {
    return self.string;
}

- (void) willAppendToString:(NSMutableString*) destString 
                       tabs:(NSString*) tabs 
                     string:(NSString*) string  
                        eol:(NSString*) eol {
    [destString appendFormat:@"%@%@%@", tabs, string, eol];
}

- (void) appendLine:(NSString*) line {
    if(self.whitespace) {
        [self willAppendToString:_string tabs:_needsTabs ? [self.whitespace tabStringForScope:self.indentDepth] : @"" string:line  eol:self.whitespace.eolString ];
       } 
    else {
        [self willAppendToString:_string tabs:@"" string:line  eol:@"" ];
    }
    
    _needsTabs = YES;
}

- (void) appendString:(NSString*) string {
    [self willAppendToString:_string tabs:_needsTabs ? [self.whitespace tabStringForScope:self.indentDepth] : @"" string:string  eol:@"" ];
    _needsTabs = NO;
}

- (void) appendFormat:(NSString*) format, ... {
	va_list va;
	va_start(va, format);
	NSString *string = [[NSString alloc] initWithFormat:format arguments:va];
	va_end(va);
	[self appendString:string];
    FLRelease(string);
}

- (void) appendLineWithFormat:(NSString*) format, ... {
	va_list va;
	va_start(va, format);
	NSString *string = [[NSString alloc] initWithFormat:format arguments:va];
	va_end(va);
	[self appendLine:string];
    FLRelease(string);
}

- (BOOL) appendLineIfNotEmpty:(NSString*) line {
	if(FLStringIsNotEmpty(line)) {
        [self appendLine:line];
		return YES;
	}
	
	return NO;
}

- (BOOL) appendStringIfNotEmpty:(NSString*) string {
	if(FLStringIsNotEmpty(string)) {
		[self appendString:string];
		return YES;
	}
	
	return NO;
}

- (NSString*) _preprocessLines:(NSString*) lines {
	NSString* string = [lines stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
	string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return string;
}

- (void) appendLines:(NSString*) inLines trimWhitespace:(BOOL) trimWhitespace {
	NSString* string = trimWhitespace ? [self _preprocessLines:inLines] : inLines;
	if(FLStringIsNotEmpty(string)) {
		NSArray* lines = [string componentsSeparatedByString:@"\n"];
		for(NSString* line in lines) {
			NSString* newline = trimWhitespace ? [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : line;
		
			if(FLStringIsNotEmpty(newline)) {
				[self appendLine:newline];
			}
		}
	}
}

- (void) appendBuilder:(FLStringBuilder*) builder {
	NSString* string = [self _preprocessLines:[builder buildString]];
	if(FLStringIsNotEmpty(string)) {
		NSArray* lines = [string componentsSeparatedByString:@"\n"];
		for(NSString* line in lines) {
			[self appendLine:line];
		}
	}
}

- (NSString*) description {
    return [self buildString];
}

@end

/*
//
//	FLStringBuilder.m
//	PackMule
//
//	Created by Mike Fullerton on 8/25/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLStringBuilder.h"

@implementation FLStringBuilder

#define EOL @"\n"
#define TAB @"\t"
#define TAB_WITH_SPACES @"    "

@synthesize tabCount = _tabCount;
@synthesize prettyPrint = _prettyPrint;
@synthesize tabString = _tabString;

- (id) init
{
	return [self initWithPrettyPrint:YES];
}

- (id) initWithPrettyPrint:(BOOL) prettyPrint
{
	if((self = [super init]))
	{
		_string = [[NSMutableString alloc] init];
		_tabCount = 0;
		_scopeStack = nil;
		_prettyPrint = prettyPrint;
		FLAssignObject(_tabString, TAB);
		_needsNewLine = YES;
	}

	return self;
}

+ (FLStringBuilder*) stringBuilder
{
	return FLReturnAutoreleased([[FLStringBuilder alloc] init]);
}

- (void) dealloc
{
	FLReleaseWithNil(_tabString);
	FLReleaseWithNil(_string);
	FLReleaseWithNil(_scopeStack);
	FLSuperDealloc();
}

- (NSString*) eol
{
	return EOL;
}

- (void) clear
{
	FLRelease(_string);
	_string = [[NSMutableString alloc] init];
	_tabCount = 0;
	FLRelease(_scopeStack); 
	_scopeStack = nil; 
}

//- (void) startLine
//{
//	if(_prettyPrint)
//	{
//		
//	}
//}

- (void) appendLine
{
	if(_prettyPrint)
	{
		[_string appendString:self.eol];
		_needsNewLine = YES;
	}
}

- (void) appendString:(NSString*) string
{
	if(_needsNewLine)
	{	
		_needsNewLine = NO;
		for(int i = 0; i < _tabCount; i++)
		{
			[_string appendString:_tabString];
		}
	}

	[_string appendString:string];
}

- (void) appendFormat:(NSString*) format, ...
{
	va_list va;
	va_start(va, format);
	NSString *string = [[NSString alloc] initWithFormat:format arguments:va];
	va_end(va);
	[self appendString:string];
	FLReleaseWithNil(string);
}

- (void) appendLine:(NSString*) line
{
	[self appendString:line];
	if(_prettyPrint)
	{
		[self appendLine];
	}
}

- (void) appendLineWithFormat:(NSString*) format, ...
{
	va_list va;
	va_start(va, format);
	NSString *string = [[NSString alloc] initWithFormat:format arguments:va];
	va_end(va);
	[self appendLine:string];
	FLReleaseWithNil(string);
}

- (BOOL) appendLineIfNotEmpty:(NSString*) line
{
	if(line && line.length)
	{
		[self appendLine:line];
		return YES;
	}

	return NO;
}

- (BOOL) appendStringIfNotEmpty:(NSString*) string
{
	if(string && string.length)
	{
		[self appendString:string];

		return YES;
	}

	return NO;
}

- (NSString*) preprocessLines:(NSString*) lines
{
	NSString* string = [lines stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
	string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return string;
}

- (void) appendLines:(NSString*) inLines trimWhitespace:(BOOL) trimWhitespace
{
	NSString* string = trimWhitespace ? [self preprocessLines:inLines] : inLines;
	if(FLStringIsNotEmpty(string))
	{
		NSArray* lines = [string componentsSeparatedByString:@"\n"];
		for(NSString* line in lines)
		{
			NSString* newline = trimWhitespace ? [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : line;

			if(FLStringIsNotEmpty(newline))
			{
				[self appendLine:newline];
			}
		}
	}
}

- (void) appendBuilder:(FLStringBuilder*) builder
{
	NSString* string = [self preprocessLines:[builder toString]];
	if(FLStringIsNotEmpty(string))
	{
		NSArray* lines = [string componentsSeparatedByString:@"\n"];
		for(NSString* line in lines)
		{
			[self appendLine:line];
		}
	}
}

- (void) tabIn
{
	++_tabCount;
}

- (void) tabOut
{
	--_tabCount;
}

- (void) pushScopeString:(NSString*) item
{
	if(!_scopeStack)
	{
		_scopeStack = [[NSMutableArray alloc] init];
	}
	[_scopeStack addObject:item];
}

- (NSString*) lastScopeString
{
	return _scopeStack ? [_scopeStack lastObject] : nil;
}

- (void) popScopeStack
{
	[_scopeStack removeLastObject];
}

- (void) openScope:(NSString*) opener closer:(NSString*) closer
{
	if(opener)
	{
		[self appendLine:opener];
	}

	if(closer)
	{
		[self pushScopeString:closer];
	}

	[self tabIn];
}

- (void) closeScope
{
	[self tabOut];
	NSString* closer = [self lastScopeString];
	if(closer && closer.length > 0)
	{
		[self appendLine:closer];
	}
	[self popScopeStack];
}

- (NSString*) description
{
	return FLReturnAutoreleased([_string copy]);
}

- (NSString*) toString
{
	FLAssert(!_scopeStack || _scopeStack.count == 0, @"_scopeStack not closed");

	return FLReturnAutoreleased(FLReturnRetained(_string));
}

- (NSUInteger) length
{
	return [_string length];
}


@end
*/
