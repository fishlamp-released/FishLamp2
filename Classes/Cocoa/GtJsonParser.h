//
//  GtJson.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/12/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#define GtJsonParserErrorDomain @"GtJsonParserErrorDomain"
#define GtJsonParserParseFailedErrorCode 1 

@interface GtJsonParser : NSObject {
@private
    NSError* m_error;
}
@property (readwrite, retain, nonatomic) NSError* error;

+ (GtJsonParser*) jsonParser;

- (id) parseJsonData:(NSData *)data rootObject:(id) objectOrNil;

@end
