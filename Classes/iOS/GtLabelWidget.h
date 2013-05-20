//
//	GtLabelWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidget.h"
#import "GtTextDescriptor.h"

@interface GtLabelWidget : GtWidget {
@private
	NSString* m_text;
	GtTextDescriptor* m_textDescriptor;
	UITextAlignment m_textAlignment;
	UILineBreakMode m_lineBreakMode;
}

@property (nonatomic)		 UITextAlignment textAlignment;	  // default is UITextAlignmentLeft
@property (nonatomic)		 UILineBreakMode lineBreakMode;
@property (nonatomic,copy)	 NSString		*text;		   
@property (readwrite, copy, nonatomic) GtTextDescriptor* textDescriptor;

- (CGSize) sizeThatFitsText:(CGSize) size;
- (CGSize) sizeThatFitsText;
- (CGSize) sizeToFitText;
- (CGSize) sizeToFitText:(CGSize) size;
- (CGFloat) heightOfTextForWidth:(CGFloat) width;
- (CGFloat) heightOfTextForWidth:(CGFloat) width andString:(NSString*) string;

- (void) setHeightToFitText;
@end
