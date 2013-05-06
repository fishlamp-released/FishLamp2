//
//	FLDataEncoder.h
//	PackMule
//
//	Created by Mike Fullerton on 4/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

#import "FLObjectEncoder.h"
#import "FLCoreTypes.h"

@protocol FLDataEncoding <NSObject, FLTypeCoreTypesEncoding>

- (NSString*) encodeDataToString:(id) data 
                         forType:(id<FLStringEncoder>) type;

@end



