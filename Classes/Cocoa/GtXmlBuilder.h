//
//	GtXmlBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/11/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtStringBuilder.h"
#import "GtDataEncoder.h"

#define NEW_BUILDER 1

#ifndef NEW_BUILDER
#import "GtOutputStream.h"
#endif



#ifndef NEW_BUILDER
@interface GtXmlBuilder : GtStringBuilder<GtOutputStream> {
#else
@interface GtXmlBuilder : GtStringBuilder {
#endif
@private
	NSMutableArray* m_attributes;
	NSMutableString* m_attribute;
	id<GtDataEncoder> m_dataEncoder;
	NSMutableArray* m_comments;
}

@property (readwrite, retain, nonatomic) id<GtDataEncoder> dataEncoder;

+ (GtXmlBuilder*) xmlBuilder;
+ (GtXmlBuilder*) xmlBuilderWithPrettyPrint:(BOOL) prettyPrint;

- (void) addVersionAndEncodingHeader;

- (void) openAttribute;
- (void) addDataToAttribute:(NSString*) data;
- (void) addDataWithFormatToAttribute:(NSString*) data, ...;
- (void) closeAttribute:(NSString*) attrName; 

- (void) pushAttributeString:(NSString*) string attributeName:(NSString*)name;

- (void) openElement:(NSString*) elementName;

- (void) addElementValueWithString:(NSString*) data;

- (void) addElementWithStringValue:(NSString*) stringValue elementName:(NSString*) name;

- (void) addComment:(NSString*) comment;
- (void) pushComment:(NSString*) comment;

- (void) closeElement;


#ifndef NEW_BUILDER
// deprecated
- (void) streamObject:(id) object;
- (void) pushAttributeObject:(id) object attributeName:(NSString*)name forType:(GtDataTypeStruct*) type;
- (void) addElementValueWithObject:(id) object	forType:(GtDataTypeStruct*) type;
- (void) addElementWithObjectValue:(id) object elementName:(NSString*) name forType:(GtDataTypeStruct*) type;
#endif

@end
