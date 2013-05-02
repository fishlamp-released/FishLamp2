//
//	FLXmlDocumentBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLXmlDocumentBuilder.h"
#import "FLStringUtils.h"
#import "FLDataEncoder.h"
#import "FLXmlElement.h"

#define EOL @"\r\n"

@interface FLXmlDocumentBuilder ()
 
@end

@implementation FLXmlDocumentBuilder

@synthesize dataEncoder = _dataEncoder;

- (id) init {
    self = [super init];
    if(self) {
        [self openDocument];
    }
    return self;
}

+ (FLXmlDocumentBuilder*) xmlStringBuilder {
	return FLAutorelease([[[self class] alloc] init]);
}

- (void) openDocument {
    _dataEncoder = [[FLDataEncoder alloc] init];
    [self appendDefaultXmlHeader];
}

#if FL_MRC
- (void) dealloc {
    [_dataEncoder release];
    [super dealloc];
}
#endif

-(void) appendXmlVersionHeader:(NSString*) version 
               andEncodingHeader:(NSString*) encoding
               standalone:(BOOL) standalone {
    
    [self appendLineWithFormat:@"<?xml version=\"%@\" encoding=\"%@\" standalone=\"%@\"?>", version, encoding, standalone ? @"yes" : @"no"];
}

- (void) appendDefaultXmlHeader {
    [self appendXmlVersionHeader:FLXmlVersion1_0 andEncodingHeader:FLXmlEncodingUtf8 standalone:YES];
}

- (void) openElement:(FLXmlElement*) element {
    [self openSection:element];
}

- (void) addElement:(FLXmlElement*) element {
    [self addSection:element];
}

- (void) closeElement {
    [self closeSection];
}

- (id) openedElement {
    return [self openedSection];
}


@end



