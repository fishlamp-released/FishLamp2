//
//  FLEnumHandler.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"

@interface FLEnumHandler : NSObject {
@private
    NSDictionary* _enums;
    NSString* _delimiter;
}
@property (readwrite, strong, nonatomic) NSString* delimiter;
@property (readwrite, strong, nonatomic) NSDictionary* enumDictionary;

- (NSInteger) enumFromString:(NSString*) inString;

- (NSSet*) enumsFromString:(NSString*) string; 

- (void) enumsFromString:(NSString*) string 
                   enums:(NSInteger*) enums 
                maxCount:(NSUInteger*) maxCount;

- (NSString*) stringFromEnumValue:(NSInteger) enumValue;

- (NSString*) stringFromEnumArray:(NSInteger*) enums;

- (NSString*) stringFromEnumSet:(NSSet*) enums;


@end
