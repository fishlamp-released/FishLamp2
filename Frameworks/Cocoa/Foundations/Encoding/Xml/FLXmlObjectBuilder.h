//
//	FLXmlObjectBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/8/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLDataEncoder.h"
#import "FLParsedXmlElement.h"

@interface FLXmlObjectBuilder : NSObject {
@private
    id<FLDataDecoding> _decoder;
}
@property (readonly, strong,nonatomic) id<FLDataDecoding> decoder;

- (id) initWithDataDecoder:(id<FLDataDecoding>) decoder;
+ (id) xmlObjectBuilder:(id<FLDataDecoding>) decoder;

- (id) buildObjectWithClass:(Class) aClass withXml:(FLParsedXmlElement*) element;

@end