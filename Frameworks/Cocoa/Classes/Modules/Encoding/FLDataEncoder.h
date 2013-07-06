//
//  FLDataEncoder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLDataEncoding.h"
#import "FLDataDecoding.h"
#import "FLStringEncoder.h"

@interface FLDataEncoder : NSObject<FLDataEncoding, FLDataDecoding> {
@private
    NSMutableDictionary* _stringEncoders;
}

+ (id) dataEncoder;

- (void) addStringEncoder:(id<FLStringEncoding>) encoder;

- (id<FLStringEncoding>) stringEncoderForKey:(NSString*) key;

@end
