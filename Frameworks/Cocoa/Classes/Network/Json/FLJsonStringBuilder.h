//
//  FLJsonBuilder.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

#import "FLDataEncoder.h"
#import "FLDocumentBuilder.h"

@interface FLJsonStringBuilder : FLDocumentBuilder {
@private
	id<FLDataEncoding> _dataEncoder;
}

@property (readwrite, retain, nonatomic) id<FLDataEncoding> dataEncoder;

- (void) streamObject:(id) object;

//- (void) addObjectAsFunction:(NSString*) functionName object:(id) object;

@end

