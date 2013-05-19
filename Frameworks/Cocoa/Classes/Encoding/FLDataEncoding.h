//
//	FLDataEncoder.h
//	PackMule
//
//	Created by Mike Fullerton on 4/20/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

@protocol FLDataEncoding <NSObject>

- (NSString*) stringFromObject:(id) object 
                   encodingKey:(NSString*) encodingKey;

@end



