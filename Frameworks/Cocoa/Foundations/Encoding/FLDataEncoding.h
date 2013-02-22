//
//	FLDataEncoder.h
//	PackMule
//
//	Created by Mike Fullerton on 4/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

#import "FLTypeDesc.h"

@protocol FLDataEncoding <NSObject, FLTypeDescCoreTypesEncoding>

- (NSString*) encodeDataToString:(id) data 
                         forType:(FLTypeDesc*) type;

@end



