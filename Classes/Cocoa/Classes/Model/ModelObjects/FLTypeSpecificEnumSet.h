//
//  FLTypeSpecificEnumSet.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/30/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLEnumSet.h"

typedef NSInteger FLEnumSetEnumValueLookup(NSString* string);
typedef NSString* FLEnumSetEnumStringLookup(NSInteger theEnum);

@interface FLTypeSpecificEnumSet : FLEnumSet {
@private
    FLEnumSetEnumValueLookup* _valueLookup;
    FLEnumSetEnumStringLookup* _stringLookup;
}

+ (id) typeSpecificEnumSet:(FLEnumSetEnumValueLookup*) valueLookup 
              stringLookup:(FLEnumSetEnumStringLookup*) stringLookup;

- (id) initWithValueLookup:(FLEnumSetEnumValueLookup*) valueLookup 
              stringLookup:(FLEnumSetEnumStringLookup*) stringLookup;

- (void) setWithConcatenatedString:(NSString*) string;

- (NSString*) concatenatedString;
- (NSString*) concatenatedStringWithDelimiter:(NSString*) delimeter;

@end