//
//  GtJsonDataEncoder.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtDataEncoder.h"

@interface GtJsonDataEncoder : NSObject<GtDataEncoder> {
@private
	NSNumberFormatter* m_numberFormatter;
}

GtSingletonProperty(GtJsonDataEncoder);

@end

@interface NSString (GtJsonDataEncoder)
- (NSString*) jsonEncode;
@end