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

@synthesize dataEncoder = _dataEncoder;

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

+ (FLXmlStringBuilder*) xmlStringBuilder {
	return autorelease_([[[self class] alloc] init]);
}

#if FL_MRC 
- (void) dealloc {
    mrc_release_(_dataEncoder);
    mrc_super_dealloc_();
}
#endif

-(void) appendXmlVersionDeclaration:(NSString*) version 
               andEncodingHeader:(NSString*) encoding
               standalone:(BOOL) standalone {
    
    [self appendFormat:@"<?xml version=\"%@\" encoding=\"%@\" standalone=\"%@\"?>", version, encoding, standalone ? @"yes" : @"no"];
}

- (void) appendDefaultXmlDeclaration {
    [self appendXmlVersionDeclaration:FLXmlVersion1_0 andEncodingHeader:FLXmlEncodingUtf8 standalone:YES];
}

- (FLXmlElement*) addElement:(NSString*) openTag closeTag:(NSString*) closeTag {
    FLXmlElement* element = [FLXmlElement xmlElement:openTag closeTag:closeTag];
    [self append:element];
    return element;
}

- (FLXmlElement*) addElement:(NSString*) openTag closeTag:(NSString*) closeTag value:(NSString*) value {
    FLXmlElement* element = [FLXmlElement xmlElement:openTag closeTag:closeTag];
    [element appendLine:value];
    [self append:element];
    return element;
}

- (FLXmlElement*) addElement:(NSString*) name {
    FLXmlElement* element = [FLXmlElement xmlElement:name];
    [self append:element];
    return element;
}

- (FLXmlElement*) addElement:(NSString*) name value:(NSString*) value {
    FLXmlElement* element = [FLXmlElement xmlElement:name];
    [element appendLine:value];
    [self append:element];
    return element;
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



