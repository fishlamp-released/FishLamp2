//
//  NSString+XML.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"


@interface NSString (XML)
- (NSString*) xmlEncode;
- (NSString*) xmlDecode;
@end
