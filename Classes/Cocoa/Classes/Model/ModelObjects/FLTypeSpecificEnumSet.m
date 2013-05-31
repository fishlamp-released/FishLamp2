//
//  FLTypeSpecificEnumSet.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/30/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTypeSpecificEnumSet.h"

@implementation FLTypeSpecificEnumSet 

- (id) initWithValueLookup:(FLEnumSetEnumValueLookup*) valueLookup 
              stringLookup:(FLEnumSetEnumStringLookup*) stringLookup {	
	self = [super init];
	if(self) {
		_valueLookup = valueLookup;
        _stringLookup = stringLookup;
	}
	return self;
}

+ (id) typeSpecificEnumSet:(FLEnumSetEnumValueLookup*) valueLookup stringLookup:(FLEnumSetEnumStringLookup*) stringLookup {
    return FLAutorelease([[[self class] alloc] initWithValueLookup:valueLookup stringLookup:stringLookup]);
}

- (void) setWithConcatenatedString:(NSString*) jumboString {

    FLAssertNotNil(_valueLookup);
    FLAssertNotNil(_stringLookup);
    
    NSArray* strings = [jumboString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" ,"] allowEmptyStrings:NO];
    
    for(NSString* string in strings) {
        NSInteger value = _valueLookup(string);

        if(value != NSNotFound) {
            NSString* prettyString = _stringLookup(value);
            
            FLAssertNotNilWithComment(prettyString, @"value is valid but not string??");
            
            [self addEnum:value withName:prettyString];
        }
    }
}

- (NSString*) concatenatedString {
    return [self concatenatedStringWithDelimiter:@", "];
}

- (NSString*) concatenatedStringWithDelimiter:(NSString*) delimeter {
    FLAssertStringIsNotEmpty(delimeter);

    NSMutableString* str = nil;
    for(FLEnumPair* pair in self) {
        if(str) {
            [str appendFormat:@"%@%@", delimeter, pair.enumName];
        }
        else {
            str = [NSMutableString stringWithString:pair.enumName];
        }
    }
    
    return str;
}



@end
