//
//  FLEnumHandler.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/7/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

@interface FLEnumPair : NSObject {
@private
    NSString* _name;
    NSInteger _value;
}
@property (readonly, strong, nonatomic) NSString* name;
@property (readonly, assign, nonatomic) NSInteger value;

+ (id) enumPair:(NSString*) name value:(NSInteger) value;

@end


@interface FLEnumHandler : NSObject {
@private
    NSMutableDictionary* _enums;
    NSString* _delimiter;
}
@property (readwrite, strong, nonatomic) NSString* delimiter;

@property (readonly, strong, nonatomic) NSDictionary* enumDictionary;

- (void) addEnum:(NSInteger) value withName:(NSString*) name;

- (NSInteger) enumFromString:(NSString*) inString;

- (NSSet*) enumsFromString:(NSString*) string; 

//- (void) enumsFromString:(NSString*) string 
//                   enums:(NSInteger*) enums 
//                maxCount:(NSUInteger*) maxCount;

- (NSString*) stringFromEnumValue:(NSInteger) enumValue;

- (NSString*) stringFromEnumArray:(NSInteger*) enums;

- (NSString*) stringFromEnumSet:(NSSet*) enums;

@end
