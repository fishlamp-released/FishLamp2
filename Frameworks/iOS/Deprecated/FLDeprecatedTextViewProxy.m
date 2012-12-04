//
//	UIView+FLTextView.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLDeprecatedTextViewProxy.h"

@implementation FLDeprecatedTextViewProxy

@synthesize view = _proxiedView;

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
	[_proxiedView removeFromSuperview];
	release_(_proxiedView);
	super_dealloc_();
}

- (NSString*) text
{
	return [_proxiedView text];
}

- (void) setText:(NSString*) text
{
	[_proxiedView setText:text];
}

- (UIFont*) font
{
	return (UIFont*) [_proxiedView font];
}

- (void) setFont:(UIFont*) font
{
   [_proxiedView setFont:font];
}

- (UIColor*) textColor
{
   return [_proxiedView textColor];
}

- (void) setTextColor:(UIColor*) color
{
	[_proxiedView setTextColor:color];
}

- (UITextAlignment) textAlignment
{
	return [_proxiedView textAlignment];
}

- (void) setTextAlignment:(UITextAlignment) alignment
{
	[_proxiedView setTextAlignment:alignment];
}

- (BOOL) viewIsLabelView
{
	return [_proxiedView isKindOfClass:[UILabel class]];
}

- (BOOL) viewIsTextField
{
	return [_proxiedView isKindOfClass:[UITextField class]];
}

- (BOOL) viewIsTextView
{
	return [_proxiedView isKindOfClass:[UITextView class]];
}

- (UILabel*) labelView
{
	FLAssert_v([_proxiedView isKindOfClass:[UILabel class]], @"not a UILabel");
	return (UILabel*) _proxiedView;
}
- (UITextField*) textField
{
	FLAssert_v([_proxiedView isKindOfClass:[UITextField class]], @"not a UITextField");
	return (UITextField*) _proxiedView;
}
- (UITextView*) textView
{
	FLAssert_v([_proxiedView isKindOfClass:[UITextView class]], @"not a UITextView");
	return (UITextView*) _proxiedView;
}

- (UIColor*) shadowColor
{
	if([_proxiedView respondsToSelector:@selector(shadowColor)])
	{
		return [_proxiedView performSelector:@selector(shadowColor)];
	}
	
	return nil;
}

- (void) setShadowColor:(UIColor*) color
{
	if([_proxiedView respondsToSelector:@selector(setShadowColor:)])
	{
		[_proxiedView performSelector:@selector(setShadowColor:) withObject:color];
	}
}

- (void) setShadowOffset:(FLSize) size
{
	if([_proxiedView respondsToSelector:@selector(setShadowOffset:)])
	{
		[_proxiedView setShadowOffset:size];
	}
}

- (FLSize) shadowOffset
{
	if([_proxiedView respondsToSelector:@selector(shadowOffset)])
	{
		return [_proxiedView shadowOffset];
	}
	
	return CGSizeZero;
}

- (FLTextDescriptor*) textDescriptor
{
	if([_proxiedView respondsToSelector:@selector(textDescriptor)])
	{
		return [_proxiedView textDescriptor];
	}
	
	return nil;
}

- (void) setTextDescriptor:(FLTextDescriptor*) textDescriptor
{
	if([_proxiedView respondsToSelector:@selector(setTextDescriptor:)])
	{
		[_proxiedView setTextDescriptor:textDescriptor];
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
//	  return [_proxiedView hidden];
//}
//
//- (void) setHidden:(BOOL) hidden
//{
//	  [_proxiedView setHidden:hidden];
//}

//- (FLRect) frame
//{
//	  return [_proxiedView frame];
//}
//
//- (void) setFrame:(FLRect) frame
//{
//	  [_proxiedView setFrame:frame];
//}
//
//- (FLRect) newFrame
//{
//	  return [_proxiedView frame];
//}
//
//- (void) setNewFrame:(FLRect) frame
//{
//	  [_proxiedView setNewFrame:frame];
//}
//
//-(NSMethodSignature*)methodSignatureForSelector:(SEL)selector
//{
//	NSMethodSignature *sig;
//	sig=[[_proxiedView class] instanceMethodSignatureForSelector:selector];
//	if(sig==nil)
//	{
//		sig=[NSMethodSignature signatureWithObjCTypes:"@^v^c"];		
//	}
//	return sig;
//}
//
//-(void)forwardInvocation:(NSInvocation*)invocation
//{
//	if(_proxiedView==nil)
//	{
//		return;
//	}
//	if([_proxiedView respondsToSelector:[invocation selector]])
//	{
//		[invocation invokeWithTarget:_proxiedView];
//	}
//}
//

@end