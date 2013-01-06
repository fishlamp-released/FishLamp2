//
//	FLXmlStringBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLStringBuilderStack.h"
#import "FLPropertyDescription.h"
#import "FLXmlElement.h"
#import "FLDataEncoder.h"
#import "FLObjectDescriber.h"
#import "FLXmlComment.h"

// xml
#define FLXmlVersion1_0                         @"1.0"
#define FLXmlEncodingUtf8                       @"utf-8"
#define FMXmlEncodingUtf16                      @"UTF-16"

@class FLXmlElement;

@interface FLXmlStringBuilder : FLScopedStringBuilder {
@private
    id<FLDataEncoder> _dataEncoder;
}
@property (readwrite, strong, nonatomic) id<FLDataEncoder> dataEncoder;

+ (FLXmlStringBuilder*) xmlStringBuilder;

- (void) openElement:(FLXmlElement*) element;

- (void) addElement:(FLXmlElement*) element;

- (void) closeElement;

- (void) appendXmlVersionDeclaration:(NSString*) version 
                   andEncodingHeader:(NSString*) encoding
                          standalone:(BOOL) standalone;

- (void) appendDefaultXmlDeclaration; 

@end

