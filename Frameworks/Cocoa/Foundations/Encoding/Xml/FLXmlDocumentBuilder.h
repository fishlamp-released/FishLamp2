//
//	FLXmlDocumentBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLPropertyType.h"
#import "FLXmlElement.h"
#import "FLDataEncoding.h"
#import "FLObjectDescriber.h"
#import "FLXmlComment.h"
#import "FLDocumentBuilder.h"

// xml
#define FLXmlVersion1_0                         @"1.0"
#define FLXmlEncodingUtf8                       @"utf-8"
#define FMXmlEncodingUtf16                      @"UTF-16"

@class FLXmlElement;

@interface FLXmlDocumentBuilder : FLDocumentBuilder {
@private
    id<FLDataEncoding> _dataEncoder;
}
@property (readwrite, strong, nonatomic) id<FLDataEncoding> dataEncoder;

@property (readonly, strong, nonatomic) id openedElement;

+ (FLXmlDocumentBuilder*) xmlStringBuilder;

- (void) openElement:(FLXmlElement*) element;

- (void) addElement:(FLXmlElement*) element;

- (void) closeElement;

- (void) appendXmlVersionHeader:(NSString*) version 
                   andEncodingHeader:(NSString*) encoding
                          standalone:(BOOL) standalone;

- (void) appendDefaultXmlHeader; 

@end

