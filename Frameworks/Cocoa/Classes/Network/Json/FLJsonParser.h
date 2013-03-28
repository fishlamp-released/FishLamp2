//
//  FLJson.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/12/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"

@interface FLJsonParser : NSObject {
@private
}
+ (FLJsonParser*) jsonParser;

- (id) parseData:(NSData*) data;
- (id) parseFileAtPath:(NSString*) path;
- (id) parseFileAtURL:(NSURL*) url;

@end
