//
//	GtLabelWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtLabelWidget.h"

 
@implementation GtLabelWidget

@synthesize textAlignment = m_textAlignment;
@synthesize lineBreakMode = m_lineBreakMode;
@synthesize text = m_text;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		m_textAlignment = UITextAlignmentLeft;
		m_lineBreakMode = UILineBreakModeTailTruncation;
	}
	
	return self;
}


- (void) dealloc
{
	GtRelease(m_text);
	GtRelease(m_textDescriptor);
	GtSuperDealloc();
}

- (void) setText:(NSString*) text
{
	GtAssignObject(m_text, text);
	[self setNeedsDisplay];
}

- (void) drawRect:(CGRect) rect
{
	if(!m_textDescriptor)
	{
		return;
	}

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);

	if(self.disabled)
	{
		[[m_textDescriptor disabledColor] set];
		if(m_textDescriptor.disabledShadowColor)
		{
			CGContextSetShadowWithColor(context, 
						m_textDescriptor.shadowOffset, 
						2,	
						m_textDescriptor.disabledShadowColor.CGColor);
		}
	}
	else if(self.highlighted)
	{
		[[m_textDescriptor highlightedColor] set];
		if(m_textDescriptor.highlightedShadowColor)
		{
			CGContextSetShadowWithColor(context, 
						m_textDescriptor.shadowOffset, 
						2,	
						m_textDescriptor.highlightedShadowColor.CGColor);
		}
	}
	else
	{
		[[m_textDescriptor enabledColor] set];
		
		if(m_textDescriptor.enabledShadowColor)
		{
			CGContextSetShadowWithColor(context, 
							m_textDescriptor.shadowOffset, 
							2,	
							m_textDescriptor.enabledShadowColor.CGColor);
		}
	}
	
	if(GtStringIsNotEmpty(m_text))
	{
		GtAssertNotNil(m_textDescriptor.font);
		[m_text drawInRect:self.frame withFont:m_textDescriptor.font lineBreakMode:m_lineBreakMode alignment:m_textAlignment];
	}
	 
	CGContextRestoreGState(context);
	
	[super drawRect:rect];
}

- (GtTextDescriptor*) textDescriptor
{
	if(!m_textDescriptor)
	{
		m_textDescriptor = [[GtTextDescriptor alloc] init];
	}

	return m_textDescriptor;
}

- (void) setTextDescriptor:(GtTextDescriptor*) textDescriptor
{
	if(GtCopyObject(m_textDescriptor, textDescriptor))
	{
		[self setNeedsDisplay];
	}
}

- (CGSize) sizeThatFitsText:(CGSize) size
{
	GtAssertNotNil(self.textDescriptor.font);
	return GtSizeOptimizeForView(	[self.text sizeWithFont:self.textDescriptor.font
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
	CGSize outSize = GtSizeOptimizeForView([self sizeThatFitsText:size]);
	self.frame = GtRectSetSizeWithSize(self.frame, outSize);
	return outSize;
}

- (CGFloat) heightOfTextForWidth:(CGFloat) width
{
	return [self heightOfTextForWidth:width andString:self.text];
}

- (CGFloat) heightOfTextForWidth:(CGFloat) width andString:(NSString*) string
{
	GtAssertNotNil(self.textDescriptor.font);

	return [string sizeWithFont:self.textDescriptor.font
									constrainedToSize:CGSizeMake(width, 2048.0)
									lineBreakMode:self.lineBreakMode].height;
}

- (void) setHeightToFitText
{
	self.frame = GtRectSetHeight(self.frame, [self heightOfTextForWidth:self.frame.size.width]);
}

- (CGSize) calculateSizeForLayout:(GtArrangeableViewHint) hint
{
    CGSize size = hint.size;
    
    if(hint.flexibleHeight)
    {
        size.height = [self heightOfTextForWidth:size.width];
    }

    return size;
}



@end
