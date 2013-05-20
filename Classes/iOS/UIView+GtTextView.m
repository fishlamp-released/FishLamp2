//
//	UIView+GtTextView.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UIView+GtTextView.h"

@implementation GtTextViewProxy

@synthesize view = m_proxiedView;

- (id) initWithView:(UIView*) view
{
	if((self = [super init]))
	{
		self.view = view;
	}
	return self;
}

- (void) dealloc
{
	[m_proxiedView removeFromSuperview];
	GtRelease(m_proxiedView);
	GtSuperDealloc();
}

- (NSString*) text
{
	return [m_proxiedView text];
}

- (void) setText:(NSString*) text
{
	[m_proxiedView setText:text];
}

- (UIFont*) font
{
	return (UIFont*) [m_proxiedView font];
}

- (void) setFont:(UIFont*) font
{
   [m_proxiedView setFont:font];
}

- (UIColor*) textColor
{
   return [m_proxiedView textColor];
}

- (void) setTextColor:(UIColor*) color
{
	[m_proxiedView setTextColor:color];
}

- (UITextAlignment) textAlignment
{
	return [m_proxiedView textAlignment];
}

- (void) setTextAlignment:(UITextAlignment) alignment
{
	[m_proxiedView setTextAlignment:alignment];
}

- (BOOL) viewIsLabelView
{
	return [m_proxiedView isKindOfClass:[UILabel class]];
}

- (BOOL) viewIsTextField
{
	return [m_proxiedView isKindOfClass:[UITextField class]];
}

- (BOOL) viewIsTextView
{
	return [m_proxiedView isKindOfClass:[UITextView class]];
}

- (UILabel*) labelView
{
	GtAssert([m_proxiedView isKindOfClass:[UILabel class]], @"not a UILabel");
	return (UILabel*) m_proxiedView;
}
- (UITextField*) textField
{
	GtAssert([m_proxiedView isKindOfClass:[UITextField class]], @"not a UITextField");
	return (UITextField*) m_proxiedView;
}
- (UITextView*) textView
{
	GtAssert([m_proxiedView isKindOfClass:[UITextView class]], @"not a UITextView");
	return (UITextView*) m_proxiedView;
}

- (UIColor*) shadowColor
{
	if([m_proxiedView respondsToSelector:@selector(shadowColor)])
	{
		return [m_proxiedView performSelector:@selector(shadowColor)];
	}
	
	return nil;
}

- (void) setShadowColor:(UIColor*) color
{
	if([m_proxiedView respondsToSelector:@selector(setShadowColor:)])
	{
		[m_proxiedView performSelector:@selector(setShadowColor:) withObject:color];
	}
}

- (void) setShadowOffset:(CGSize) size
{
	if([m_proxiedView respondsToSelector:@selector(setShadowOffset:)])
	{
		[m_proxiedView setShadowOffset:size];
	}
}

- (CGSize) shadowOffset
{
	if([m_proxiedView respondsToSelector:@selector(shadowOffset)])
	{
		return [m_proxiedView shadowOffset];
	}
	
	return CGSizeZero;
}

- (GtTextDescriptor*) textDescriptor
{
	if([m_proxiedView respondsToSelector:@selector(textDescriptor)])
	{
		return [m_proxiedView textDescriptor];
	}
	
	return nil;
}

- (void) setTextDescriptor:(GtTextDescriptor*) textDescriptor
{
	if([m_proxiedView respondsToSelector:@selector(setTextDescriptor:)])
	{
		[m_proxiedView setTextDescriptor:textDescriptor];
	}
}

- (UILineBreakMode) lineBreakMode
{
	if(self.viewIsLabelView)
	{
		return self.labelView.lineBreakMode;
	}
	
	return UILineBreakModeWordWrap;
}





//- (BOOL) hidden
//{
//	  return [m_proxiedView hidden];
//}
//
//- (void) setHidden:(BOOL) hidden
//{
//	  [m_proxiedView setHidden:hidden];
//}

//- (CGRect) frame
//{
//	  return [m_proxiedView frame];
//}
//
//- (void) setFrame:(CGRect) frame
//{
//	  [m_proxiedView setFrame:frame];
//}
//
//- (CGRect) newFrame
//{
//	  return [m_proxiedView frame];
//}
//
//- (void) setNewFrame:(CGRect) frame
//{
//	  [m_proxiedView setNewFrame:frame];
//}
//
//-(NSMethodSignature*)methodSignatureForSelector:(SEL)selector
//{
//	NSMethodSignature *sig;
//	sig=[[m_proxiedView class] instanceMethodSignatureForSelector:selector];
//	if(sig==nil)
//	{
//		sig=[NSMethodSignature signatureWithObjCTypes:"@^v^c"];		
//	}
//	return sig;
//}
//
//-(void)forwardInvocation:(NSInvocation*)invocation
//{
//	if(m_proxiedView==nil)
//	{
//		return;
//	}
//	if([m_proxiedView respondsToSelector:[invocation selector]])
//	{
//		[invocation invokeWithTarget:m_proxiedView];
//	}
//}
//

@end