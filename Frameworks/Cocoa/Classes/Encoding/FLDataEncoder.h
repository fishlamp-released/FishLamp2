//
//  FLDataEncoder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDataEncoding.h"
#import "FLDataDecoding.h"
#import "FLStringEncoder.h"

//@protocol FLProtocolStringEncoding <NSObject>
//- (NSString*) stringDecodedFromString:(NSString*) string;
//- (NSString*) stringEncodedFromString:(NSString*) string;
//@end

@interface FLDataEncoder : NSObject<FLDataEncoding, FLDataDecoding> {
@private
    NSMutableDictionary* _stringEncoders;
}

+ (id) dataEncoder;

- (void) setStringEncoder:(id<FLStringEncoding>) encoder forKey:(NSString*) encodingKey;
- (id<FLStringEncoding>) stringEncoderForKey:(NSString*) key;

@end
