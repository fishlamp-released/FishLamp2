//
//	FLXmlStringBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLXmlStringBuilder.h"
#import "FLStringUtils.h"
#import "FLDataEncoder.h"
#import "FLXmlElement.h"

#define EOL @"\r\n"

@interface FLXmlStringBuilder ()
 
@end

@implementation FLXmlStringBuilder

@synthesize dataEncoder = _dataEncoder;

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

+ (FLXmlStringBuilder*) xmlStringBuilder {
	return FLAutorelease([[[self class] alloc] init]);
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
    [self.stack push:element];
}

- (void) addElement:(FLXmlElement*) element {
    [self.stack.top addStringBuilder:element];
}

- (void) closeElement {
    [self.stack pop];
}


@end



