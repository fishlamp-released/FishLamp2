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
#import "FLType.h"
#import "FLCoreTypes.h"

@protocol FLDataDecoding <NSObject, FLTypeCoreTypesEncoding>
- (id) decodeDataFromString:(NSString*) inEncodedString 
                    forType:(FLType*) type;

@end


