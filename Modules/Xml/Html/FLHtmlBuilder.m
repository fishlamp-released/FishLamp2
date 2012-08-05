//
//	FLHtmlBuilder.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/26/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLHtmlBuilder.h"

@implementation FLHtmlBuilder

FLSynthesizeStructProperty(isOpen, setIsOpen, BOOL, _flags);

+ (FLHtmlBuilder*) htmlBuilder {
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (void) addStyleWidth:(NSUInteger) width {
	[self appendAttributeWithFormat:@"width:%dpx; ", width];
}

- (void) addStyleHorizontallyCenter {
	[self appendAttributeWithString:@"margin-left:auto; margin-right:auto; "];
}

-(void) addDocTypeDeclaration:(NSString*) declaration {
    FLAssert(self.length == 0, @"expecting zero length builder when append version header");
	[self appendFormat:@"<!DOCTYPE %@>"];
}

- (void) appendLinkElement:(NSString*) href
                      text:(NSString*) text {
	[self pushAttribute:@"href" value:href];
	[self openElement:@"a"];
	[self appendString:text];
	[self closeElement];
}

- (void) addStyleClearBackgroundColor {
	[self appendAttributeWithString:@"background-color:transparent; "];
}

- (void) appendBreakElement {
	[self appendClosedElement:@"br"];
}

- (void) openStyleAttribute {
	[self openAttribute:@"style"];
}

- (void) closeStyleAttribute {
	[self closeAttribute];
}

- (void) openDivElement {
	[self openElement:@"div"];
}

- (void) openBodyElement {
	[self openElement:@"body"];
}

- (void) openHeadElement {
	[self openElement:@"head"];
}

- (void) openHtmlElement {
	[self openElement:@"html"];
}

+ (NSString*) convertToSimpleHtml:(NSString*) input {
	NSString* string = [input stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"];
	return [string stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>"];
}

+ (NSString*) convertFromSimpleHtml:(NSString*) input {
	return [input stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
}

+ (BOOL) isSimpleHtml:(NSString*) input {
	return [input rangeOfString:@"<br/>"].length > 0;
}

@end
