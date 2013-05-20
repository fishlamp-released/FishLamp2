//
//  GtStringBuilder.m
//  FishLampCore
//
//  Created by Mike Fullerton on 5/26/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtStringBuilder.h"
#import "NSString+GtExtras.h"

@interface GtStringBuilder ()
@property (readonly, strong, nonatomic) NSString* string;
@end

@implementation GtStringBuilder

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

- (id) initWithPrettyPrint:(BOOL) prettyPrint {
    self = [self initWithCapacity:0];
    if(self) {
        if(!prettyPrint) {
            self.whitespace = [GtWhitespace compressedFormat];
        }
    }

    return self;
}

- (id) initWithCapacity:(NSUInteger) capacity {
    self = [super init]; 
    if(self) {
        self.whitespace = [GtWhitespace tabbedFormat];
        _string = capacity > 0 ? [[NSMutableString alloc] initWithCapacity:capacity] : [[NSMutableString alloc] init];
    	_needsTabs = YES;
	}
    return self; 
}

- (id) init {
    return [self initWithCapacity:0];
}

+ (GtStringBuilder*) stringBuilder {
    return GtReturnAutoreleased([[[self class] alloc] init]);
}

+ (GtStringBuilder*) stringBuilderWithCapacity:(NSUInteger) capacity {
    return GtReturnAutoreleased([[[self class] alloc] initWithCapacity:capacity]);
}

#if GT_DEALLOC
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
    GtRelease(string);
}

- (void) appendLineWithFormat:(NSString*) format, ... {
	va_list va;
	va_start(va, format);
	NSString *string = [[NSString alloc] initWithFormat:format arguments:va];
	va_end(va);
	[self appendLine:string];
    GtRelease(string);
}

- (BOOL) appendLineIfNotEmpty:(NSString*) line {
	if(GtStringIsNotEmpty(line)) {
        [self appendLine:line];
		return YES;
	}
	
	return NO;
}

- (BOOL) appendStringIfNotEmpty:(NSString*) string {
	if(GtStringIsNotEmpty(string)) {
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
	if(GtStringIsNotEmpty(string)) {
		NSArray* lines = [string componentsSeparatedByString:@"\n"];
		for(NSString* line in lines) {
			NSString* newline = trimWhitespace ? [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : line;
		
			if(GtStringIsNotEmpty(newline)) {
				[self appendLine:newline];
			}
		}
	}
}

- (void) appendBuilder:(GtStringBuilder*) builder {
	NSString* string = [self _preprocessLines:[builder buildString]];
	if(GtStringIsNotEmpty(string)) {
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
//	GtStringBuilder.m
//	PackMule
//
//	Created by Mike Fullerton on 8/25/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtStringBuilder.h"

@implementation GtStringBuilder

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
		GtAssignObject(_tabString, TAB);
		_needsNewLine = YES;
	}

	return self;
}

+ (GtStringBuilder*) stringBuilder
{
	return GtReturnAutoreleased([[GtStringBuilder alloc] init]);
}

- (void) dealloc
{
	GtReleaseWithNil(_tabString);
	GtReleaseWithNil(_string);
	GtReleaseWithNil(_scopeStack);
	GtSuperDealloc();
}

- (NSString*) eol
{
	return EOL;
}

- (void) clear
{
	GtRelease(_string);
	_string = [[NSMutableString alloc] init];
	_tabCount = 0;
	GtRelease(_scopeStack); 
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
	GtReleaseWithNil(string);
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
	GtReleaseWithNil(string);
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
	if(GtStringIsNotEmpty(string))
	{
		NSArray* lines = [string componentsSeparatedByString:@"\n"];
		for(NSString* line in lines)
		{
			NSString* newline = trimWhitespace ? [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : line;

			if(GtStringIsNotEmpty(newline))
			{
				[self appendLine:newline];
			}
		}
	}
}

- (void) appendBuilder:(GtStringBuilder*) builder
{
	NSString* string = [self preprocessLines:[builder buildString]];
	if(GtStringIsNotEmpty(string))
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
	return GtReturnAutoreleased([_string copy]);
}

- (NSString*) buildString
{
	GtAssert(!_scopeStack || _scopeStack.count == 0, @"_scopeStack not closed");

	return GtReturnAutoreleased(GtReturnRetained(_string));
}

- (NSUInteger) length
{
	return [_string length];
}


@end
*/
