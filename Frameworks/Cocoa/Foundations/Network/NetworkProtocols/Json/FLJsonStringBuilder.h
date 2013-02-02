//
//  FLJsonBuilder.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

#import "FLDataEncoder.h"
#import "FLDocumentBuilder.h"

@interface FLJsonStringBuilder : FLDocumentBuilder {
@private
	id<FLDataEncoder> _dataEncoder;
}

@property (readwrite, retain, nonatomic) id<FLDataEncoder> dataEncoder;

- (void) streamObject:(id) object;

//- (void) addObjectAsFunction:(NSString*) functionName object:(id) object;

@end

