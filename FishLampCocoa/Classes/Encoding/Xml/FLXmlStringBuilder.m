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

@implementation FLXmlStringBuilder

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

+ (FLXmlStringBuilder*) xmlStringBuilder {
	return autorelease_([[[self class] alloc] init]);
}

-(void) appendXmlVersionDeclaration:(NSString*) version 
               andEncodingHeader:(NSString*) encoding
               standalone:(BOOL) standalone {
    
    [self appendFormat:@"<?xml version=\"%@\" encoding=\"%@\" standalone=\"%@\"?>", version, encoding, standalone ? @"yes" : @"no"];
}

- (void) appendDefaultXmlDeclaration {
    [self appendXmlVersionDeclaration:FLXmlVersion1_0 andEncodingHeader:FLXmlEncodingUtf8 standalone:YES];
}

- (void) addElement:(FLXmlElement*) element {
    [super addToken:element];
}
@end

@implementation FLXmlComment

- (void) willBuildString {
    if(!self.isEmpty) {
        self.header = [FLSingleLineToken singleLineToken:@"<--"];
        self.footer = [FLSingleLineToken singleLineToken:@"-->"];
    }
    else {
        self.header = nil;
        self.footer = nil;
    }
}
@end



