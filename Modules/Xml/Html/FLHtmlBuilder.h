//
//	FLHtmlBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/26/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLXmlBuilder.h"

// html

#define FLXmlDocTypeHtml5                       @"html"
#define FLXmlDocTypeHtml4_01Strict              @"HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\""
#define FLXmlDocTypeHtml4_01Transitional        @"HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\""
#define FLXmlDocTypeHtml4_01Frameset            @"HTML PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\" \"http://www.w3.org/TR/html4/frameset.dtd\""
#define FLXmlDocTypeXHtml1_0Strict              @"html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\""
#define FLXmlDocTypeXHtml1_0Transitional        @"html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\""
#define FLXmlDocTypeXHtml1_0Frameset            @"html PUBLIC \"-//W3C//DTD XHTML 1.0 Frameset//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd\""
#define FLXMLDocTypeXHtml1_1                    @"html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\""


@interface FLHtmlBuilder : FLXmlBuilder {
@private
	struct {
		unsigned int isOpen: 1;
	} _flags;
}

+ (FLHtmlBuilder*) htmlBuilder;

- (void) addDocTypeDeclaration:(NSString*) declaration;

- (void) openStyleAttribute;

- (void) addStyleWidth:(NSUInteger) width;
- (void) addStyleHorizontallyCenter;
- (void) addStyleClearBackgroundColor;

- (void) closeStyleAttribute;

- (void) openDivElement;
- (void) openBodyElement;
- (void) openHeadElement;
- (void) openHtmlElement;

- (void) appendLinkElement:(NSString*) href
                      text:(NSString*) text;
			
- (void) appendBreakElement;

// just converts LF -> BR and back. Kinda lame.
+ (NSString*) convertToSimpleHtml:(NSString*) input;
+ (NSString*) convertFromSimpleHtml:(NSString*) input;
+ (BOOL) isSimpleHtml:(NSString*) input;

@end
