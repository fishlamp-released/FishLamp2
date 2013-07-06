//
//	FLXmlObjectBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/8/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FLDataEncoder.h"
#import "FLParsedXmlElement.h"
#import "FLObjectDescriber.h"
#import "FLModelObject.h"
#import "NSObject+FLXmlObjectBuilder.h"

@interface FLXmlObjectBuilder : NSObject {
@private
    id<FLDataDecoding> _decoder;

    BOOL _strict;
}
@property (readwrite, assign, nonatomic) BOOL strict;
@property (readonly, strong,nonatomic) id<FLDataDecoding> decoder;

- (id) initWithDataDecoder:(id<FLDataDecoding>) decoder;
+ (id) xmlObjectBuilder:(id<FLDataDecoding>) decoder;
+ (id) xmlObjectBuilder;

- (id) buildObjectOfClass:(Class) aClass withXML:(FLParsedXmlElement*) element;
- (id) buildObjectOfType:(NSString*) type withXML:(FLParsedXmlElement*) element;

@end


