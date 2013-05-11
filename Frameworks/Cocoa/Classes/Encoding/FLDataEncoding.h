//
//	FLDataEncoder.h
//	PackMule
//
//	Created by Mike Fullerton on 4/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"

@protocol FLDataEncoding <NSObject>

- (NSString*) stringFromObject:(id) object 
                   encodingKey:(NSString*) encodingKey;

@end



