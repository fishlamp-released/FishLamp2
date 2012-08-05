//
//  NSString+XML.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"


@interface NSString (XML)
- (NSString*) xmlEncode;
- (NSString*) xmlDecode;
@end
