//
//	FLXmlObjectBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/8/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLDataEncoder.h"
#import "FLParsedItem.h"
#import "FLObjectDescriber.h"
#import "FLObjectDescriber.h"

@interface FLXmlObjectBuilder : NSObject {
@private
    id<FLDataDecoding> _decoder;
}
@property (readonly, strong,nonatomic) id<FLDataDecoding> decoder;

- (id) initWithDataDecoder:(id<FLDataDecoding>) decoder;
+ (id) xmlObjectBuilder:(id<FLDataDecoding>) decoder;
+ (id) xmlObjectBuilder;

- (NSArray*) objectsFromXML:(FLParsedItem*) xmlElement withObjectTypes:(NSArray*) arrayOfobjectDescribers;

- (NSArray*) objectsFromXML:(FLParsedItem*) xmlElement withObjectType:(FLObjectDescriber*) type; // for homogeneous arrays

// this will fail if number of return objects != 1
- (id) objectFromXML:(FLParsedItem*) element withObjectType:(FLObjectDescriber*) type;

// optional overrides
- (FLParsedItem*) willBuildObjectsWithXML:(FLParsedItem*) element;

@end