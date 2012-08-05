//
//	FLKeyValuePair.h
//	FishLamp
//
//	Created By Mike Fullerton on 4/23/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FishLampCore.h"

@interface FLKeyValuePair : NSObject {
@private
	id _key;
	id _value;
}

- (id) initWithKey:(id) key value:(id) value;

+ (FLKeyValuePair*) keyValuePair:(id) key value:(id) value;

@property (readwrite, retain, nonatomic) id key;
@property (readwrite, retain, nonatomic) id value;

@end



