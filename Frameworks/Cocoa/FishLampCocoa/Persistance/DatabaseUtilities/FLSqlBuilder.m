//
//  FLSqlBuilder.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/16/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSqlBuilder.h"
#import "NSString+Lists.h"
#import "FLSqlStatement.h"

#define SQL_PLACEHOLDER @"?"

@implementation NSString (Util)

- (NSUInteger) subStringCount:(NSString*) substring {
    NSUInteger count = 0;
    NSUInteger subLen = substring.length;
    NSUInteger len = self.length - substring.length;
    
    for(int i = 0; i < len; i++) {
        for(int j = 0; (j < subLen && i < len); j++) {
            if([self characterAtIndex:i] != [substring characterAtIndex:j]) {
                goto skip;
                
                ++i;
            }
        }
        
        ++count;
        
        skip: ;
    }
    
    return count;
}

@end

@implementation FLSqlBuilder

@synthesize sqlString = _sql;
@synthesize objects = _dataToBind;

- (NSInteger) length {
    return _sql.length;
}

- (void) setSqlString:(NSString*) string {
    release_(_sql);
    _sql = [string mutableCopy];
    
    if(FLStringIsEmpty(_sql) || [_sql characterAtIndex:_sql.length - 1] == ' ' ) {
        _spaceDisableCount = 1;
    }
    else {
        _spaceDisableCount = 0;
    }
}

- (id) init {
    self = [super init];
    if(self) {
        _sql = [[NSMutableString alloc] init];
        _spaceDisableCount = 1;
    }
    return self;
}

+ (FLSqlBuilder*) sqlBuilder {
    return autorelease_([[FLSqlBuilder alloc] init]);
}

- (void) bindToSqlStatement:(FLSqlStatement*) statement {

    FLAssert_v([_sql subStringCount:@"@?"] == self.objects.count,   
        @"binding failure. placeholder count:%d, object count: %d", 
        [_sql subStringCount:@"@?"], 
        self.objects.count);

    if(self.objects) {
        int parmIdx = 0;
        for(id object in self.objects) {
            [object bindToStatement:statement parameterIndex:++parmIdx];
        }
    }

    FLReleaseWithNil_(_delimiter);
    FLReleaseWithNil_(_dataToBind);
    self.sqlString = @"";
}
#if FL_MRC 
- (void) dealloc {
    release_(_delimiter);
    release_(_dataToBind);
    release_(_sql);
    super_dealloc_();
}
#endif

- (void) appendString:(NSString*) string {
    
    if(_inList) {
        [self appendDelimiter:_delimiter insertSpace:_insertPrefixDelimiterSpace];
    }
    
    FLAssert_v(_spaceDisableCount >= 0, @"space disable less than zero");
    
    if(_spaceDisableCount == 0) {
        [_sql appendFormat:@" %@", string];
    }
    else {
        [_sql appendString:string];
        --_spaceDisableCount;
    }
}

- (void) appendDelimiter:(NSString*) delimiter
             insertSpace:(BOOL) insertSpace {

    if(_inList && _listCount++) {
        if(insertSpace) {
            [self appendString:delimiter];
        }
        else {
            [_sql appendString:delimiter];
        }
    }
}

- (void) openParen {
    _spaceDisableCount = 2;
    [self appendString:@"("];
}

- (void) closeParen {
    _spaceDisableCount = 1;
    [self appendString:@")"];
}

- (void) appendFormat:(NSString*) format, ... {

	va_list va;
	va_start(va, format);
	NSString *string = [[NSString alloc] initWithFormat:format arguments:va];
	va_end(va);
	[self appendString:string];
    release_(string);
}

- (void) appendString:(NSString*) string andString:(NSString*) andString {
    [self appendString:string];
    
    if(FLStringIsNotEmpty(andString)) {
        [self appendString:andString];
    }
}

- (void) openListWithDelimiter:(NSString*) delimiter
                  withinParens:(BOOL) withinParens
      prefixDelimiterWithSpace:(BOOL) prefixDelimiterWithSpace {

    FLRetainObject_(_delimiter, delimiter);
    _insertPrefixDelimiterSpace = prefixDelimiterWithSpace;
    if(withinParens) {
        [self openParen];
    }
    _closeParens = withinParens;
    _inList = YES;
    _listCount = 0;
}


- (void) closeList {
    FLReleaseWithNil_(_delimiter);
    _inList = NO;
    _listCount = 0;
    if(_closeParens) {
        [self closeParen];
    }
}

- (void) appendObject:(id) object
     comparedToString:(NSString*) string
         withComparer:(NSString*) compareString {

    if(!_dataToBind) {
        _dataToBind = [[NSMutableArray alloc] init];
    }

    [self appendFormat:@"%@%@?", string, compareString];

    [_dataToBind addObject:object];
}

- (void) appendObject:(id) data {
    if(!_dataToBind) {
        _dataToBind = [[NSMutableArray alloc] init];
    }

    [self appendString:@"?"];

    [_dataToBind addObject:data];
}

+ (NSString*)   sqlListFromArray:(NSArray*) list
                       delimiter:(NSString*) delimiter
                    withinParens:(BOOL) withinParens
        prefixDelimiterWithSpace:(BOOL) prefixDelimiterWithSpace
                     emptyString:(NSString*) emptyStringOrNil {

    if(list && list.count) {
    
		NSMutableString* sqlList = [NSMutableString stringWithString:[list objectAtIndex:0]];
		
        NSString* prefix = prefixDelimiterWithSpace ? @" " : @"";
            
		for(int i = 1; i < list.count; i++) {
			[sqlList appendFormat:@"%@%@ %@", prefix, delimiter, [list objectAtIndex:i]];
		}
        if(withinParens) {
            sqlList = [NSString stringWithFormat:@"(%@)", sqlList];
        }
        return sqlList;
    }
    return emptyStringOrNil != nil ? emptyStringOrNil : @"";
}

+ (NSString*)   sqlListFromArray:(NSArray*) list
                       delimiter:(NSString*) delimiter
                    withinParens:(BOOL) withinParens
        prefixDelimiterWithSpace:(BOOL) prefixDelimiterWithSpace {
    return [self sqlListFromArray:list delimiter:delimiter withinParens:NO prefixDelimiterWithSpace:prefixDelimiterWithSpace emptyString:nil];
}

- (void) appendInsertClauseForRow:(NSDictionary*) row {

    [self openListWithDelimiter:@"," withinParens:YES prefixDelimiterWithSpace:NO];

    for(NSString* column in row) {
        [self appendString:column];
    }

    [self closeList];
    
    [self appendString:SQL_VALUES];

    [self openListWithDelimiter:@"," withinParens:YES prefixDelimiterWithSpace:NO];
    for(NSString* column in row) {
        [self appendObject: [row objectForKey:column]];
    }

    [self closeList];
}



@end