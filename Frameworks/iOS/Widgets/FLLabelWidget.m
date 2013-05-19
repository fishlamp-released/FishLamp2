//
//	FLLabelWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLLabelWidget.h"

 
@implementation FLLabelWidget

@synthesize textAlignment = _textAlignment;
@synthesize lineBreakMode = _lineBreakMode;
@synthesize text = _text;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		_textAlignment = UITextAlignmentLeft;
		_lineBreakMode = UILineBreakModeTailTruncation;
	}
	
	return self;
}


- (void) dealloc
{
	FLRelease(_text);
	FLRelease(_textDescriptor);
	FLSuperDealloc();
}

- (void) setText:(NSString*) text
{
	FLSetObjectWithRetain(_text, text);
	[self setNeedsDisplay];
}

- (void) drawRect:(CGRect) rect
{
	if(!_textDescriptor)
	{
		return;
	}

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);

	if(self.isDisabled)
	{
		[[_textDescriptor disabledColor] set];
		if(_textDescriptor.disabledShadowColor)
		{
			CGContextSetShadowWithColor(context, 
						_textDescriptor.shadowOffset, 
						2,	
						_textDescriptor.disabledShadowColor.CGColor);
		}
	}
	else if(self.isHighlighted)
	{
		[[_textDescriptor highlightedColor] set];
		if(_textDescriptor.highlightedShadowColor)
		{
			CGContextSetShadowWithColor(context, 
						_textDescriptor.shadowOffset, 
						2,	
						_textDescriptor.highlightedShadowColor.CGColor);
		}
	}
	else if(self.isSelected)
    {
		[[_textDescriptor selectedColor] set];
		
		if(_textDescriptor.selectedShadowColor)
		{
			CGContextSetShadowWithColor(context, 
							_textDescriptor.shadowOffset, 
							2,	
							_textDescriptor.selectedShadowColor.CGColor);
		}
    }
    else
	{
		[[_textDescriptor enabledColor] set];
		
		if(_textDescriptor.enabledShadowColor)
		{
			CGContextSetShadowWithColor(context, 
							_textDescriptor.shadowOffset, 
							2,	
							_textDescriptor.enabledShadowColor.CGColor);
		}
	}
	
	if(FLStringIsNotEmpty(_text))
	{
		FLAssertIsNotNil(_textDescriptor.font);
		[_text drawInRect:self.frame withFont:_textDescriptor.font lineBreakMode:_lineBreakMode alignment:_textAlignment];
	}
	 
	CGContextRestoreGState(context);
	
	[super drawRect:rect];
}

- (FLTextDescriptor*) textDescriptor
{
	if(!_textDescriptor)
	{
		_textDescriptor = [[FLTextDescriptor alloc] init];
	}

	return _textDescriptor;
}

- (void) setTextDescriptor:(FLTextDescriptor*) textDescriptor
{
	FLCopyObject_(_textDescriptor, textDescriptor);
    [self setNeedsDisplay];
}

- (CGSize) sizeThatFitsText:(CGSize) size
{
	FLAssertIsNotNil(self.textDescriptor.font);
	return FLSizeOptimizeForView(	[self.text sizeWithFont:self.textDescriptor.font
									constrainedToSize:size
									lineBreakMode:self.lineBreakMode] );
}
- (CGSize) sizeThatFitsText
{
	return [self sizeThatFitsText:CGSizeMake(2048.0, 2048.0)];
}
- (CGSize) sizeToFitText
{
	return [self sizeToFitText:CGSizeMake(2048.0, 2048.0)];

//	  return [self sizeToFitText:CGSizeMake(self.superview ? self.superview.bounds.size.width : 2048.0, 2048.0)];
}

- (CGSize) sizeToFitText:(CGSize) size
{
	CGSize outSize = FLSizeOptimizeForView([self sizeThatFitsText:size]);
	self.frame = FLRectSetSizeWithSize(self.frame, outSize);
	return outSize;
}

- (CGFloat) heightOfTextForWidth:(CGFloat) width
{
	return [self heightOfTextForWidth:width andString:self.text];
}

- (CGFloat) heightOfTextForWidth:(CGFloat) width andString:(NSString*) string
{
	FLAssertIsNotNil(self.textDescriptor.font);

	return [string sizeWithFont:self.textDescriptor.font
									constrainedToSize:CGSizeMake(width, 2048.0)
									lineBreakMode:self.lineBreakMode].height;
}

- (void) setHeightToFitText
{
	self.frame = FLRectSetHeight(self.frame, [self heightOfTextForWidth:self.frame.size.width]);
}

- (void) calculateArrangementSize:(CGSize*) outSize
                           inSize:(CGSize) inSize
                         fillMode:(FLArrangeableGrowMode) fillMode {
    
    switch(fillMode) {
        case FLArrangeableGrowModeGrowWidth:
            FLAssertIsImplemented();
        break;

        case FLArrangeableGrowModeGrowHeight:
            outSize->height = [self heightOfTextForWidth:inSize.width];
        break;
        
        case FLArrangeableGrowModeNone:
        case FLArrangeableGrowModeFlexibleWidth:
        break;
    
    }
}



@end
