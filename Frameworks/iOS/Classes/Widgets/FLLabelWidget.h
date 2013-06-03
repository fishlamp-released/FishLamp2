//
//	FLLabelWidget.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

- (CGSize) sizeThatFitsText:(CGSize) size;
- (CGSize) sizeThatFitsText;
- (CGSize) sizeToFitText;
- (CGSize) sizeToFitText:(CGSize) size;
- (CGFloat) heightOfTextForWidth:(CGFloat) width;
- (CGFloat) heightOfTextForWidth:(CGFloat) width andString:(NSString*) string;

- (void) setHeightToFitText;
@end
