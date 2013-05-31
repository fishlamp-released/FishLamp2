//
//  WhittleJsonReader.h
//  WhittleJsonReader
//
//  Created by Mike Fullerton on 6/24/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLCodeProjectReader.h"

@interface FLJsonCodeProjectReader : NSObject<FLCodeProjectReader>

+ (FLJsonCodeProjectReader*) jsonCodeProjectReader;

@end