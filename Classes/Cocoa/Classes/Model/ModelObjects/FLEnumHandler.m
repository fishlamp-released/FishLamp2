//
//  FLEnumHandler.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/7/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLEnumHandler.h"

@implementation FLEnumPair 
@synthesize name = _name;
@synthesize value = _value;

- (id) initWithName:(NSString*) name value:(NSInteger) value {	
	self = [super init];
	if(self) {
		_name = [name copy];
        _value = value;
	}
	return self;
}

+ (id) enumPair:(NSString*) name value:(NSInteger) value {
    return FLAutorelease([[[self class] alloc] initWithName:name value:value]);
}

#if FL_MRC
- (void) dealloc {
	[_name release];
	[super dealloc];
}
#endif

@end

@implementation FLEnumHandler 

@synthesize enumDictionary = _enums;
@synthesize delimiter = _delimiter;

- (id) init 
{
    self = [super init];
    if(self) {
        _enums = [[NSMutableDictionary alloc] init];
        self.delimiter = @",";
    }
    return self;
}

#if FL_MRC
- (void) dealloc 
{
    FLRelease(_delimiter);
    FLRelease(_enums);
    FLSuperDealloc();
}
#endif

- (void) addEnum:(NSInteger) value withName:(NSString*) name  {
    FLEnumPair* pair = [FLEnumPair enumPair:name value:value];
    [_enums setObject:pair forKey:[name lowercaseString]];
    
    [_enums setObject:pair forKey:[NSNumber numberWithInteger:value]];
}

- (NSInteger) enumFromString:(NSString*) inString {
    if(FLStringIsEmpty(inString)) {
        return 0;
    }

    FLEnumPair* pair = [_enums objectForKey:[inString lowercaseString]];
    if(!pair) { 
        FLThrowErrorCodeWithComment(FLErrorDomain, FLErrorUnknownEnumValue, 
            [NSString stringWithFormat:(NSLocalizedString(@"Unknown enum value: %@", nil)), inString]); 
    } 
    return pair.value;
}

- (NSString*) stringFromEnumValue:(NSInteger) enumValue {
    FLEnumPair* pair = [_enums objectForKey:[NSNumber numberWithInteger:enumValue]];
    if(!pair) { 
        FLThrowErrorCodeWithComment(FLErrorDomain, FLErrorUnknownEnumValue, 
            [NSString stringWithFormat:(NSLocalizedString(@"Unknown enum value: %d", nil)), enumValue]); 
    } 
    return pair.name;
}

- (NSSet*) enumsFromString:(NSString*) stringList  
{
    FLAssertIsNotNil(stringList);
    FLAssertIsNotNil(self.delimiter);

    NSMutableSet* set = nil;
    
    if(FLStringIsNotEmpty(stringList)) {
        NSArray* split = [stringList componentsSeparatedByString:self.delimiter]; 

        if(split.count > 0) {
            set = [NSMutableSet setWithCapacity:split.count]; 
            for(NSString* key in split) {
                if(FLStringIsNotEmpty(key)) {
                    [set addObject:[NSNumber numberWithInteger:[self enumFromString:key]]];
                }
            }
        }
    }
    
    return set;
}

- (NSString*) stringFromEnumSet:(NSSet*) enums
{
    FLAssertIsNotNil(enums);
    
    NSMutableString* string = [NSMutableString string];
    for(NSNumber* number in enums) {
        if(string.length == 0) {
            [string appendFormat:@"%d", [number intValue]];
        }
        else {
            [string appendFormat:@"%@%d",self.delimiter, [number intValue]];
        }
    
    }
    
    return string;
}                  

- (NSString*) stringFromEnumArray:(NSInteger*) enums {
    FLAssertIsNotNil(enums);
    
    NSMutableString* string = [NSMutableString string];
    if(enums) {
        NSUInteger count = sizeof(enums) / sizeof(NSInteger);
    
        for(int i = 0; i < count; i++) {
            NSInteger value = enums[i];
            if(i == 0) {
                [string appendFormat:@"%ld", (long) value];
            }
            else {
                [string appendFormat:@"%@%ld",self.delimiter, (long) value];
            }
        }
    }
    
    return string;
}                              

- (void) enumsFromString:(NSString*) string 
                   enums:(NSInteger*) enums 
                maxCount:(NSUInteger*) maxCount 
{
    FLAssertIsNotNil(string);
   
    NSInteger count = 0;

    if(FLStringIsNotEmpty(string)) {
        NSArray* split = [string componentsSeparatedByString:self.delimiter]; 

        if(split.count > 0) {
            for(NSString* key in split) {
                if(FLStringIsNotEmpty(key)) {
                    NSNumber* num = [_enums objectForKey:key];
                    if(!num) {
                        FLThrowErrorCodeWithComment(FLErrorDomain, FLErrorUnknownEnumValue, (NSLocalizedString(@"Unknown enum value (case sensitive): %@", nil)), key); 
                    }
                    
                    if(count + 1 >= *maxCount) {
                        FLThrowErrorCodeWithComment(FLErrorDomain, FLErrorTooManyEnumsErrorCode, (NSLocalizedString(@"TooMany enums for buffer", nil)));
                    }
                    
                    enums[count++] = [num intValue];
                }
            }
        }
    }    

    *maxCount = count;

}  



@end
