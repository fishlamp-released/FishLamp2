//
//	GtHtmlBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtXmlBuilder.h"

@interface GtHtmlBuilder : GtXmlBuilder {
@private
	struct {
		unsigned int isOpen: 1;
	} m_flags;
}

- (void) openStyleAttribute;

- (void) addStyleWidth:(NSUInteger) width;
- (void) addStyleHorizontallyCenter;
- (void) addStyleClearBackgroundColor;

- (void) closeStyleAttribute;

- (void) openDivElement;
- (void) openBodyElement;
- (void) openHeadElement;

- (void) appendLinkElement:(NSString*) href
			text:(NSString*) text;
			
- (void) appendBreakElement;

@property (readonly, assign, nonatomic) BOOL isOpen;
- (void) openDocument;
- (void) closeDocument;

+ (NSString*) convertToSimpleHtml:(NSString*) input;
+ (NSString*) convertFromSimpleHtml:(NSString*) input;
+ (BOOL) isSimpleHtml:(NSString*) input;

@end
