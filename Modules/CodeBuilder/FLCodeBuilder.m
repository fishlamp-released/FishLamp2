//
//	FLStringBuilder.m
//	PackMule
//
//	Created by Mike Fullerton on 8/25/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLCodeBuilder.h"
#import "NSArray+FLExtras.h"

@implementation FLCodeBuilder

@synthesize scopeFormatters = _scopeFormatters;
@synthesize scopeStack = _scopeStack;

- (id) init {
    self = [super init];
    if(self) {
        _scopeStack = [[NSMutableArray alloc] init];
        
        self.scopeFormatters = [[self class] defaultScopeFormatters];
    }
    
    return self;
}

+ (FLCodeBuilder*) codeBuilder {
	return FLReturnAutoreleased([[[self class] alloc] init]);
}

+ (NSDictionary*) defaultScopeFormatters {
    return nil;
}

#if FL_DEALLOC
- (void) dealloc {
    [_scopeFormatters release];
    [_scopeStack release];
	FLSuperDealloc();
}
#endif

//- (NSString*) buildString {
//
//    FLStringBuilder* stringBuilder = [FLStringBuilder stringBuilder];
//    stringBuilder.whitespace = self.whitespace;
//
//    NSMutableArray* scopeStack = [NSMutableArray array];
//
//    for(id line in _lines) {
//        [line handleBuildLine:state];
//    }
//    return state.theString;
//}

- (void) openScope:(FLCodeScopeId) scopeId
           openTag:(NSString*) openTagOrNil 
          closeTag:(NSString*) closeTagOrNil {
            
    FLCodeScope* scope = [FLCodeScope codeScope:openTagOrNil closeTag:closeTagOrNil];
    
    if(_scopeStack.count) {
        FLCodeScopeFormatter* formatter = [_scopeStack.lastObject formatter];
        if(scopeId == formatter.scopeId) {
            scope.formatter = formatter;
        }
    }
    
    if(!scope.formatter) {
        scope.formatter = [self scopeFormatterForscopeId:scopeId];
    }
    
    [scope.formatter openScope:self scope:scope];
    
    [_scopeStack addObject:scope];
}

- (NSInteger) indentDepth {
    return _scopeStack.count; 
}

- (void) indent {
    FLDebugLog(@"indent is no-op with codebuilder");
}

- (void) undent {
    FLDebugLog(@"undent is no-op with codebuilder");
}

- (void) openScope:(FLCodeScopeId) scopeId
          bothTags:(NSString*) bothTags {
    [self openScope:scopeId openTag:bothTags closeTag:bothTags];
}

- (void) openScope:(FLCodeScopeId) scopeId {
    [self openScope:scopeId openTag:nil closeTag:nil];
}

- (void) closeScope {
    FLCodeScope* scope = [_scopeStack dequeueLastObject];
    [scope.formatter closeScope:self scope:scope];
}

- (void) skipScope {
    [_scopeStack removeLastObject];
}
 
- (NSString*) description {
    return [self buildString];
}

- (FLCodeScopeFormatter*) scopeFormatterForscopeId:(NSUInteger) key {
    return [_scopeFormatters objectForKey:[NSNumber numberWithInteger:key]];
}

@end

@implementation NSMutableDictionary (FLCodeBuilder) 
- (void) addCodeScopeFormatter:(FLCodeScopeFormatter*) formatter {
    [self setObject:formatter forKey:[NSNumber numberWithUnsignedInteger:formatter.scopeId]];
}
@end




