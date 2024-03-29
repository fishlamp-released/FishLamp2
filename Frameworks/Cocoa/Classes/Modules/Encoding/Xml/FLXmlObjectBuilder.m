//
//	FLXmlObjectBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/8/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLXmlObjectBuilder.h"
#import "FLBase64Encoding.h"
#import "FLDataEncoder.h"
#import "FLObjectDescriber.h"
#import "FLObjectDescriber+FLXmlObjectBuilder.h"

@implementation FLXmlObjectBuilder
@synthesize decoder = _decoder;
@synthesize strict = _strict;

- (id) init {
    return [self initWithDataDecoder:[FLDataEncoder dataEncoder]];
}

- (id) initWithDataDecoder:(id<FLDataDecoding>) decoder {
    self = [super init];
    if(self) {
        _decoder = FLRetain(decoder);
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_decoder release];
    [super dealloc];
}
#endif

+ (id) xmlObjectBuilder:(id<FLDataDecoding>) decoder {
    return FLAutorelease([[[self class] alloc] initWithDataDecoder:decoder]);
}

+ (id) xmlObjectBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) buildObjectOfClass:(Class) aClass withXML:(FLParsedXmlElement*) element {
    return [[aClass objectDescriber] buildObjectWithObjectBuilder:self withXML:element];
}

- (id) buildObjectOfType:(NSString*) type withXML:(FLParsedXmlElement*) element {

    id outObject = nil;

    Class aClass = NSClassFromString(type);
    if(aClass) {
        outObject = [self buildObjectOfClass:aClass withXML:element];
    }
    else {
        outObject = [self.decoder objectFromString:element.elementValue
                                       encodingKey:type];
    }

    FLAssertNotNil(outObject);

    return outObject;
}

@end



