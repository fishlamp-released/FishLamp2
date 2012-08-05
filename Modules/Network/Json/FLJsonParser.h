//
//  FLJson.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/12/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#define FLJsonParserErrorDomain @"FLJsonParserErrorDomain"
#define FLJsonParserParseFailedErrorCode 1 

@interface FLJsonParser : NSObject {
@private
    NSError* _error;
}
@property (readwrite, retain, nonatomic) NSError* error;

+ (FLJsonParser*) jsonParser;

- (id) parseJsonData:(NSData *)data rootObject:(id) objectOrNil;

@end
