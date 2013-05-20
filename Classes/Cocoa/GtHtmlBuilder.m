//
//	GtHtmlBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtHtmlBuilder.h"

@implementation GtHtmlBuilder

GtSynthesizeStructProperty(isOpen, setIsOpen, BOOL, m_flags);

- (void) addStyleWidth:(NSUInteger) width
{
	[self addDataWithFormatToAttribute:@"width:%dpx; ", width];
}

- (void) addStyleHorizontallyCenter
{
	[self addDataToAttribute:@"margin-left:auto; margin-right:auto; "];
}

- (void) appendLinkElement:(NSString*) href
			text:(NSString*) text
{
	[self pushAttributeString:href attributeName:@"href"];
	[self openElement:@"a"];
	[self appendString:text];
	[self closeElement];
}

- (void) addStyleClearBackgroundColor
{
	[self addDataToAttribute:@"background-color:transparent; "];
}

- (void) appendBreakElement
{
	[self addElementWithStringValue:@"" elementName:@"br"];
}

- (void) openStyleAttribute
{
	[self openAttribute];
}

- (void) closeStyleAttribute
{
	[self closeAttribute:@"style"];
}

- (void) openDivElement
{
	[self openElement:@"div"];
}

- (void) openBodyElement
{
	[self openElement:@"body"];
}

- (void) openHeadElement
{
	[self openElement:@"head"];
}

- (void) openDocument
{
	GtAssert(!self.isOpen, @"already open");

	self.isOpen = YES;
	[self appendString:@"<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">"];

	[self pushAttributeString:@"http://www.w3.org/1999/xhtml" attributeName:@"xmlns"];
	[self openElement:@"html"];
	
}

- (void) closeDocument
{
	if(self.isOpen)
	{
		self.isOpen = NO;
		[self closeElement]; // html
	}
}

+ (NSString*) convertToSimpleHtml:(NSString*) input
{
	NSString* string = [input stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
	return [string stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
}

+ (NSString*) convertFromSimpleHtml:(NSString*) input
{
	return [input stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
}

+ (BOOL) isSimpleHtml:(NSString*) input
{
	return [input rangeOfString:@"<br/>"].length > 0;
}

@end
