//
//  FLDataObject.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/8/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

@protocol FLDataRef <NSObject>
@property (readonly, strong, nonatomic) id dataRefKey;
@property (readonly, strong, nonatomic) id dataRefValue;
@end

@protocol FLMutableDataRef <FLDataRef>
@property (readwrite, strong, nonatomic) id dataRefKey;
@property (readwrite, strong, nonatomic) id dataRefValue;
@end

@interface NSObject (FLDataRef)
@property (readonly, strong, nonatomic) id dataRefKey;
@property (readonly, strong, nonatomic) id dataRefValue;
@end

@interface FLDictionaryDataRef : NSObject<FLDataRef> {
@private
    id _key;
    NSDictionary* _dictionary;
}
@property (readonly, nonatomic, strong) NSDictionary* dictionary;

- (id) initWithDataRefKey:(id) key
               dictionary:(NSDictionary*) dictionary;

+ (FLDictionaryDataRef*) dictionaryDataRef:(id) key
                                dictionary:(NSDictionary*) dictionary;
@end

@interface FLMutableDictionaryDataRef : NSObject<FLMutableDataRef> {
@private
    id _key;
    NSMutableDictionary* _dictionary;
}
@property (readwrite, strong, nonatomic) NSMutableDictionary* dictionary;

- (id) initWithDataRefKey:(id) key
               dictionary:(NSMutableDictionary*) dictionary;

+ (FLDictionaryDataRef*) dictionaryDataRef:(id) key
                                dictionary:(NSMutableDictionary*) dictionary;
@end



