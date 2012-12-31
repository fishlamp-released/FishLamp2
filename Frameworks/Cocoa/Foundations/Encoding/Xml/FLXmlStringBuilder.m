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
        [self openScope:[FLStringBuilder stringBuilder]];
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

-(void) appendXmlVersionDeclaration:(NSString*) version 
               andEncodingHeader:(NSString*) encoding
               standalone:(BOOL) standalone {
    
    [self.stringBuilder appendLineWithFormat:@"<?xml version=\"%@\" encoding=\"%@\" standalone=\"%@\"?>", version, encoding, standalone ? @"yes" : @"no"];
}

- (void) appendDefaultXmlDeclaration {
    [self appendXmlVersionDeclaration:FLXmlVersion1_0 andEncodingHeader:FLXmlEncodingUtf8 standalone:YES];
}

- (void) openElement:(FLXmlElement*) element {
    [self openScope:element];
}

- (void) addElement:(FLXmlElement*) element {
    [self.stringBuilder addStringBuilder:element];
}

- (void) closeElement {
    [self closeScope];
}

@end



