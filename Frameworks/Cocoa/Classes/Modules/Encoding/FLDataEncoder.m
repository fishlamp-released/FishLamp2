//
//  FLDataEncoder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLDataEncoder.h"
#import "FLDateMgr.h"
#import "FLStringUtils.h"
#import "FLBase64Encoding.h"
#import "FLColorUtilities.h"
#import "FLDateMgr.h"
#import "FLBase64Data.h"

@implementation FLDataEncoder

- (id) init {
	if((self = [super init])) {
        _stringEncoders = [[NSMutableDictionary alloc] init];
        [self addStringEncoder:[FLStringEncoder stringEncoder]];
        [self addStringEncoder:[FLURLStringEncoder urlStringEncoder]];
        [self addStringEncoder:[FLISO8601DateStringEncoder dateStringEncoder]];
        [self addStringEncoder:[FLNumberStringEncoder numberStringEncoder]];
        [self addStringEncoder:[FLBoolStringEncoder boolStringEncoder]];
        [self addStringEncoder:[FLUTF8DataStringEncoder utf8DataStringEncoder]];
        [self addStringEncoder:[FLBase64DataStringEncoder base64DataStringEncoder:[FLUTF8DataStringEncoder utf8DataStringEncoder]]];
    }

	return self;
}

+ (id) dataEncoder {
    return FLAutorelease([[[self class] alloc] init]);
}

#define Key(k) [k lowercaseString]

- (void) addStringEncoder:(id<FLStringEncoding>) encoder {

    NSArray* keys = [encoder encodingKeys];
    if(keys) {
        for(NSString* key in keys) {
            [_stringEncoders setObject:encoder forKey:Key(key)];
        }
    }
}

#if FL_MRC
- (void) dealloc {
    [_stringEncoders release];
    [super dealloc];
}
#endif

- (NSString*) stringFromObject:(id) object 
                   encodingKey:(NSString*) stringEncodingKey {
      
    
    id<FLStringEncoding> encoder = [_stringEncoders objectForKey:Key(stringEncodingKey)];
    FLAssertNotNilWithComment(encoder, @"encoder for %@ not found", stringEncodingKey);

    if(encoder) {
        return [encoder stringFromObject:object];
    }
    
    return object;
} 

- (id) objectFromString:(NSString*) string
            encodingKey:(NSString*) stringEncodingKey {

    id<FLStringEncoding> encoder = [_stringEncoders objectForKey:Key(stringEncodingKey)];
    FLAssertNotNilWithComment(encoder, @"decoder for %@ not found", stringEncodingKey);

    if(encoder) {
        return [encoder objectFromString:string];
    }
    
    return string;
                
}                

- (id<FLStringEncoding>) stringEncoderForKey:(NSString*) key {
    return [_stringEncoders objectForKey:Key(key)];
}

@end
