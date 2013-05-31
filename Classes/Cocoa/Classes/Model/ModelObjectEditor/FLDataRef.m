//
//  FLDataObject.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/8/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLDataRef.h"


@implementation NSObject (FLDataRef)

- (id) dataRefKey {
    return [NSValue valueWithPointer:bridge_(void*, self)];
}

- (id) dataRefValue {
    return self;
}

@end

@interface FLDictionaryDataRef ()
@property (readwrite, strong, nonatomic) id dataRefKey;
@property (readwrite, strong, nonatomic) NSDictionary* dictionary;
@end

@implementation FLDictionaryDataRef

@synthesize dictionary = _dictionary;
@synthesize dataRefKey = _key;

- (id) dataRefValue {
    return [_dictionary objectForKey:_key];
}

- (id) initWithDataRefKey:(id) key
               dictionary:(NSDictionary*) dictionary {
    self = [super init];
    if(self) {
        self.dataRefKey = key;
        self.dictionary = dictionary;
    }
    return self;
               
}

+ (FLDictionaryDataRef*) dictionaryDataRef:(id) key
                                dictionary:(NSDictionary*) dictionary {
    return FLAutorelease([[[self class] alloc] initWithDataRefKey:key dictionary:dictionary]);
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_key);
    FLRelease(_dictionary);
    FLSuperDealloc();
}
#endif

@end

@implementation FLMutableDictionaryDataRef

@synthesize dictionary = _dictionary;
@synthesize dataRefKey = _key;

- (id) dataRefValue {
    return [_dictionary objectForKey:_key];
}

- (void) setDataRefValue:(id) value {
    [_dictionary setObject:value forKey:_key];
}

- (id) initWithDataRefKey:(id) key
               dictionary:(NSMutableDictionary*) dictionary {
    self = [super init];
    if(self) {
        self.dataRefKey = key;
        self.dictionary = dictionary;
    }
    return self;
               
}

+ (FLMutableDictionaryDataRef*) dictionaryDataRef:(id) key
                                dictionary:(NSMutableDictionary*) dictionary {
    return FLAutorelease([[[self class] alloc] initWithDataRefKey:key dictionary:dictionary]);
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_key);
    FLRelease(_dictionary);
    FLSuperDealloc();
}
#endif

@end
