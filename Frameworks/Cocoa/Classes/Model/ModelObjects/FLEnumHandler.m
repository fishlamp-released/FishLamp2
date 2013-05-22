//
//  FLEnumHandler.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/7/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLEnumHandler.h"

@implementation FLEnumHandler 

@synthesize enumDictionary = _enums;
@synthesize delimiter = _delimiter;

- (id) init 
{
    self = [super init];
    if(self) {
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

- (NSInteger) enumFromString:(NSString*) inString {
    NSNumber* num = [_enums objectForKey:inString];
    if(!num) { 
        FLThrowErrorCodeWithComment(FLErrorDomain, FLErrorUnknownEnumValue, 
            [NSString stringWithFormat:(NSLocalizedString(@"Unknown enum value (case sensitive): %@", nil)), inString]); 
    } 
    return [num intValue];
}

- (NSString*) stringFromEnumValue:(NSInteger) enumValue
{
    NSString* str = [_enums objectForKey:[NSNumber numberWithInteger:enumValue]];
    if(!str) {
        FLThrowErrorCodeWithComment(FLErrorDomain, FLErrorUnknownEnumValue, 
            [NSString stringWithFormat:(NSLocalizedString(@"Unknown enum value: %d", nil)), enumValue]); 
    }
    
    return str;
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
                    NSNumber* num = [_enums objectForKey:key];
                    if(!num) {
                        FLThrowErrorCodeWithComment(FLErrorDomain, FLErrorUnknownEnumValue, 
                            [NSString stringWithFormat:(NSLocalizedString(@"Unknown enum value (case sensitive): %@", nil)), key]); 
                    }
                    [set addObject:num];
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