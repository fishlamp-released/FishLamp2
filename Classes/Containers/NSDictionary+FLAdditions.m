//
//  NSDictionary+NSDictionary_FLAdditions.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSDictionary+FLAdditions.h"

NS_INLINE
NSUInteger FLDictionaryEntryArrayLength(const FLDictionaryEntry* objects) {
    
    NSUInteger len = 0;
    while(objects[len++].key != nil) {
    }
    
    return len;
}

const FLDictionaryEntry FLDictionaryEntryNil = { nil, nil };

@implementation NSDictionary (FLAdditions)

- (id)initWithObjects:(const FLDictionaryEntry[]) objects {

    NSUInteger count = FLDictionaryEntryArrayLength(objects);
    if(count) {
        NSUInteger newSize = 0;
        id newKeys[count];
        id newObjs[count];
    
        for(NSUInteger i = 0; i < count; i++) {
            if(objects[i].object != nil) {
                newObjs[newSize] = objects[i].object;
                newKeys[newSize] = objects[i].key;
                ++newSize;
            }
        }

        return [self initWithObjects:newObjs forKeys:newKeys count:newSize];
    }

    return [super init];
}

+ (id)dictionaryWithObjects:(const FLDictionaryEntry[]) objects {
    return autorelease_([[NSDictionary alloc] initWithObjects:objects]);
}

+ (id) combineDictionary:(NSDictionary *)otherDictionary
             withObjects:(const FLDictionaryEntry[]) objects {
                                                                    
    NSDictionary* theDictionary = otherDictionary;
    if(!theDictionary) {
        return [NSDictionary dictionaryWithObjects:objects];
    }
 
    if(objects) {
        NSMutableDictionary* mutable = [NSMutableDictionary dictionaryWithDictionary:otherDictionary];
        [mutable setObjects:objects];
        theDictionary = mutable;
    }
    
    return theDictionary;
}



@end

@implementation NSMutableDictionary (FLAdditions)
- (void) setObjects:(const FLDictionaryEntry[]) objects {
        
    NSUInteger count = FLDictionaryEntryArrayLength(objects);
    if(count) {
        for(NSUInteger i = 0; i < count; i++) {
            if(objects[i].object) {
                [self setObject:objects[i].object forKey:objects[i].key];
            }
            else {
                [self removeObjectForKey:objects[i].key];
            }
        }
    }
              
}

@end