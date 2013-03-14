//
//	FLObjectParser.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

#import "FLObjectDescriber.h"
#import "FLDataDecoding.h"

@interface FLPropertyInflator : NSObject {
@private
	NSString* _propertyName;
	FLType* _propertyType;
	id _containingObject;
	
    NSMutableString* _encodedString;
    int _state;
    id _inflatedPropertyObject;
}

@property (readwrite, strong, nonatomic) id containingObject; // this is the current object to which the data is being added
@property (readonly, strong, nonatomic) NSString* propertyName; // propertyName for data, like an xml element name
@property (readonly, strong, nonatomic) id inflatedPropertyObject;

@property (readonly, strong, nonatomic) NSString* encodedString;
- (void) appendEncodedString:(NSString*) string; 

@property (readwrite, strong, nonatomic) FLType* propertyType;
@property (readwrite, assign, nonatomic) int state;

- (id) initWithContainingObject:(id) containingObject propertyName:(id) propertyName state:(int) state;

+ (FLPropertyInflator*) propertyInflator:(id) containingObject propertyName:(id) propertyName state:(int) state;

- (void) inflatePropertyWithDataDecoder:(id<FLDataDecoding>) decoder;
@end