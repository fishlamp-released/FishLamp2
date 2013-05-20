//
//  GtJsonBuilder.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtStringBuilder.h"
#import "GtDataEncoder.h"

@interface GtJsonBuilder : GtStringBuilder {
@private
	id<GtDataEncoder> m_dataEncoder;
}

@property (readwrite, retain, nonatomic) id<GtDataEncoder> dataEncoder;

- (void) streamObject:(id) object;

//- (void) addObjectAsFunction:(NSString*) functionName object:(id) object;

@end
