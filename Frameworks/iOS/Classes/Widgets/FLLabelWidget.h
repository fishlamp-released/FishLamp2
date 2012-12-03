//
//	FLLabelWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"
#import "FLTextDescriptor.h"

@interface FLLabelWidget : FLWidget {
@private
	NSString* _text;
	FLTextDescriptor* _textDescriptor;
	UITextAlignment _textAlignment;
	UILineBreakMode _lineBreakMode;
}

@property (nonatomic)		 UITextAlignment textAlignment;	  // default is UITextAlignmentLeft
@property (nonatomic)		 UILineBreakMode lineBreakMode;
@property (nonatomic, strong)	 NSString		*text;		   
@property (readwrite, copy, nonatomic) FLTextDescriptor* textDescriptor;

- (FLSize) sizeThatFitsText:(FLSize) size;
- (FLSize) sizeThatFitsText;
- (FLSize) sizeToFitText;
- (FLSize) sizeToFitText:(FLSize) size;
- (CGFloat) heightOfTextForWidth:(CGFloat) width;
- (CGFloat) heightOfTextForWidth:(CGFloat) width andString:(NSString*) string;

- (void) setHeightToFitText;
@end
