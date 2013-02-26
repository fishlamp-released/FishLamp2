//
//  FLDataDecoding.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLTypeDesc.h"

@protocol FLDataDecoding <NSObject, FLTypeDescCoreTypesEncoding>
- (id) decodeDataFromString:(NSString*) inEncodedString 
                    forType:(FLTypeDesc*) type;

@end


