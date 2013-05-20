//
//	GtPopoverView.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/14/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtHoverView.h"
#import "GtPathUtilities.h"
#import "UIColor+More.h"
#import "GtHoverViewController.h"
#import "GtKeyboardManager.h"

#define kBorderSize 8.0f

#define kArrowSize 14.0f

#define kBorderWidthSize 1.0f

NSString *const GtPopoverViewWasResized = @"GtPopoverViewWasResized";

@interface GtHoverView ()
- (void) resizeToContentSize:(CGSize)size animated:(BOOL)animated;
@end


@implementation GtHoverView

@synthesize containedView = m_containedView;
@synthesize arrowDirection = m_arrowDirection;
@synthesize positionProvider = m_positionProvider;
@synthesize hoverViewContentSize = m_popoverContentSize;

- (void) keyboardDidShow:(id) sender
{
	m_state.adjustingForKeyboard = YES;
	[self resizeToContentSize:m_popoverContentSize animated:YES];
}

- (void) keyboardDidHide:(id) sender
{
	m_state.adjustingForKeyboard = NO;
	[self resizeToContentSize:m_popoverContentSize animated:YES];
}

- (void) _willRotate:(id) sender
{
	self.hidden = YES;
}

- (void) _reshow
{
	self.hidden = NO;
	[self resizeToContentSize:self.hoverViewContentSize animated:NO];
//	  [self setNeedsLayout];
//	  [self layoutIfNeeded];
}

- (void) _didRotate:(id) sender
{
	[self performSelector:@selector(_reshow) withObject:nil afterDelay:0.25];
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.backgroundColor = [UIColor clearColor];
		self.userInteractionEnabled = YES;
		m_containerView = [[GtRoundRectView alloc] initWithFrame:CGRectMake(kBorderSize,kBorderSize,100,100)];
		m_containerView.autoresizesSubviews = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
		m_containerView.autoresizesSubviews = YES;
		m_containerView.userInteractionEnabled = YES;
		m_containerView.borderColor = [UIColor gray10Color];
		m_containerView.backgroundColor = [UIColor clearColor];
        m_containerView.borderAlpha = 1.0;
        m_containerView.fillAlpha = 0.0;
        
		m_gradient = [[GtGradientWidget alloc] initWithFrame:CGRectZero];
		m_gradient.themeAction = nil;
        [self addWidget:m_gradient];
        
		[m_gradient setGradientColors:[UIColor grayColor] endColor:[UIColor blackColor]];
		m_gradient.alpha = 0.65;
		
		m_lineGradient = [[GtGradientWidget alloc] initWithFrame:CGRectZero];
		m_lineGradient.themeAction = nil;
		
        [self addWidget:m_lineGradient];
		[m_lineGradient setGradientColors:[UIColor gray33Color] endColor:[UIColor darkGrayColor]];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) 
				name: GtKeyboardDidShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) 
				name: GtKeyboardDidHideNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_willRotate:) name:UIApplicationWillChangeStatusBarOrientationNotification object:[UIApplication sharedApplication]];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_didRotate:) name:UIApplicationDidChangeStatusBarOrientationNotification object:[UIApplication sharedApplication]];
			   
        [self addSubview:m_containerView];
	}
	
	return self;
}	

- (void) addShadow:(UIColor*) color
{
	self.layer.shadowColor = color.CGColor;
	self.layer.shadowOpacity = .8;
	self.layer.shadowRadius = 20.0;
	self.layer.shadowOffset = CGSizeMake(0,3);
}

- (void) setContainedView:(UIView *) view
{
	if(m_containedView != view)
	{
		GtAssignObject(m_containedView, view);
		[m_containerView addSubview:m_containedView];
	}
}

- (CGRect) maxVisibleRect:(BOOL) adjustingForKeyboard
{
	if(self.superview)
	{
        GtAssertFailedNotImplemented();
		CGRect maxVisibleRect = self.superview.bounds;

 // TODO: fix this
#if VIEW_AUTOLAYOUT
		CGRect keyboardRect = CGRectZero;
		if(adjustingForKeyboard)
		{
			keyboardRect = GtRectJustifyRectInRectBottom(maxVisibleRect, [[GtKeyboardManager instance] keyboardRectForView:self.superview]);
		}

		maxVisibleRect.origin.y = GtViewContentsDescriptorCalculateTop([self.viewDelegate viewGetSuperviewContentsDescriptor:self]);
		maxVisibleRect.size.height -= (maxVisibleRect.origin.y);
		
        if(adjustingForKeyboard)
        {
            maxVisibleRect.size.height -= keyboardRect.size.height;
        }
        else
        {
            maxVisibleRect.size.height -= GtViewContentsDescriptorCalculateBottom([self.viewDelegate viewGetSuperviewContentsDescriptor:self]);
        }
#endif            
        
        // no adjustments needed for width or origin.x

		return maxVisibleRect;
	}
	
	return CGRectZero;
}
#define kLayoutPadding 5.0f

- (CGRect) _checkFrame:(CGRect) frame inFrame:(CGRect) superFrame
{
    if(frame.origin.x < kLayoutPadding)
    {
        frame.origin.x = kLayoutPadding;
    }
    else if(GtRectGetRight(frame) > (GtRectGetRight(superFrame) - kLayoutPadding))
    {
        frame.origin.x = GtRectGetRight(superFrame) - kLayoutPadding - frame.size.width;
    }
    
    if(frame.origin.y < superFrame.origin.y)
    {
        frame.origin.y = superFrame.origin.y + 4;
    }

    return frame;
}

- (void) _setFramePosition:(CGRect) frame animated:(BOOL) animated
{
	if(self.superview)
	{
		CGRect prevFrame = self.frame;
	
		CGRect maxVisibleRect = [self maxVisibleRect:m_state.adjustingForKeyboard];
		
		if(frame.size.height > maxVisibleRect.size.height)
		{
			CGFloat delta = frame.size.height - maxVisibleRect.size.height;
			delta += 5.0f;
			frame.size.height -= delta;
			m_containerView.newFrame = GtRectAddHeight(m_containerView.frame, -delta);
		}
		if(frame.size.width > maxVisibleRect.size.width)
		{
			CGFloat delta = frame.size.width - maxVisibleRect.size.width;
			delta += 5.0f;
			frame.size.width -= delta;
			m_containerView.newFrame = GtRectAddWidth(m_containerView.frame, -delta);
		}
	
		CGRect keyboardRect = CGRectZero; 
		if(m_state.adjustingForKeyboard)
		{
			keyboardRect = GtRectJustifyRectInRectBottom(self.superview.bounds, [[GtKeyboardManager instance] keyboardRectForView:self.superview]);
		}
        
        CGRect superFrame = [self maxVisibleRect:NO];
        
        if(!m_positionProvider || m_arrowDirection == GtHoverViewArrowDirectionNone)
		{
            frame = GtRectCenterRectInRectHorizontally(superFrame, GtRectPositionRectInRectVerticallyTopThird(superFrame, frame));
            
            if(frame.origin.y < superFrame.origin.y)
            {
                frame = GtRectCenterRectInRectVertically(superFrame, frame);
            }


            if(m_state.adjustingForKeyboard && CGRectIntersectsRect(frame, keyboardRect))
			{
				frame.origin.y = keyboardRect.origin.y - frame.size.height - 5.0f;
			}
            
            self.frameOptimizedForSize = [self _checkFrame:frame inFrame:superFrame];
        }
		else
		{
			GtAssert([m_positionProvider respondsToSelector:@selector(frame)], @"must implement frame");
			GtAssert([m_positionProvider respondsToSelector:@selector(superview)], @"must implement frame");
			
			id<GtHoverViewTargetProvider> provider = (id<GtHoverViewTargetProvider>) m_positionProvider;
			
			CGRect fromFrame = [self.superview convertRect:provider.hoverViewTargetFrame fromView:provider.hoverViewTargetView];
		
			switch(m_arrowDirection)
			{
				case GtHoverViewArrowDirectionUp:
					frame.origin.y = GtRectGetBottom(fromFrame);
					frame.origin.x = GtRectGetCenter(fromFrame).x - (frame.size.width/2.0);
				break;
				
                case GtHoverViewArrowDirectionDown:
					if(m_state.adjustingForKeyboard)
					{
						frame.origin.y = keyboardRect.origin.y - frame.size.height - 5.0f;
					}
					else
					{
						frame.origin.y = fromFrame.origin.y - frame.size.height;
					}
					
					frame.origin.x = GtRectGetCenter(fromFrame).x - (frame.size.width/2.0);
				break;
                
				case GtHoverViewArrowDirectionLeft:
                    frame.origin.x = GtRectGetRight(fromFrame);
                    frame.origin.y = GtRectGetCenter(fromFrame).y - (frame.size.height/2.0);
                break;
                
				case GtHoverViewArrowDirectionRight:
                    frame.origin.x = fromFrame.origin.x - frame.size.width;
                    frame.origin.y = GtRectGetCenter(fromFrame).y - (frame.size.height/2.0);
                break;
                
				case GtHoverViewArrowDirectionNone:
				// no-op this will get hit in the if statement above.
                break;
			}
			
            self.frameOptimizedForSize = [self _checkFrame:frame inFrame:superFrame];
            [self setNeedsLayout];
            [self layoutIfNeeded];
            
            m_targetRect = [self.superview convertRect:fromFrame toView:self];
		} 

		
		if(!CGRectEqualToRect(prevFrame, self.frame))
		{
			[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:GtPopoverViewWasResized object:nil
				userInfo:[NSDictionary dictionaryWithObject:self forKey:GtPopoverViewWasResized]]];
		}
	}
	
}

- (void) resizeToContentSize:(CGSize)size animated:(BOOL)animated
{
	CGRect myFrame = GtRectSetSize(self.frame, 
		size.width + (kBorderSize*2), 
		size.height + (kBorderSize*2));

	CGRect containerViewFrame = CGRectMake(kBorderSize, kBorderSize, size.width, size.height);
    

//	containerViewFrame.origin.y = kBorderSize;
//	containerViewFrame.origin.x = kBorderSize;	  
//	containerViewFrame.size = size;
	
	switch(m_arrowDirection)
	{
		case GtHoverViewArrowDirectionUp:
			myFrame.size.height += kArrowSize + 2;
			containerViewFrame.origin.y += kArrowSize;
		break;
		case GtHoverViewArrowDirectionDown:
			myFrame.size.height += kArrowSize + 2;
		break;
		case GtHoverViewArrowDirectionLeft:
            myFrame.size.width += kArrowSize + 2;
            containerViewFrame.origin.x += kArrowSize;
		break;
		case GtHoverViewArrowDirectionRight:
            myFrame.size.width += kArrowSize + 2;
		break;

		case GtHoverViewArrowDirectionNone:
		break;
	}
	
	m_containerView.frame = containerViewFrame;
	
	[self _setFramePosition:myFrame animated:animated];
	
	[self setNeedsLayout];
}

- (void)setHoverViewContentSize:(CGSize)size animated:(BOOL)animated
{
    self.containedView.frame = GtRectSetSizeWithSize(self.containedView.frame, size);
	m_popoverContentSize = size;
	[self resizeToContentSize:m_popoverContentSize animated:animated];
}

- (void) setHoverViewContentSize:(CGSize) size
{
	[self setHoverViewContentSize:size animated:YES];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	m_containedView.newFrame = m_containerView.bounds;
	m_gradient.frame = CGRectMake(0,0, self.bounds.size.width, 60);
	[self setNeedsDisplay];
}

#define kCornerRadius 8.0f

- (void) getPathForTop:(CGMutablePathRef) path rect:(CGRect) rect
{
	CGPoint point = GtRectGetCenter(m_targetRect);
	point.y = rect.origin.y; 
	GtCreateRectPathWithTopArrow(path, rect, point, kArrowSize, kCornerRadius);
}

- (void) getPathForBottom:(CGMutablePathRef) path rect:(CGRect) rect
{
	CGPoint point = GtRectGetCenter(m_targetRect);
	point.y = GtRectGetBottom(rect);
	GtCreateRectPathWithBottomArrow(path, rect, point, kArrowSize, kCornerRadius);
}

- (void) getPathForRight:(CGMutablePathRef) path rect:(CGRect) rect
{
	CGPoint point = GtRectGetCenter(m_targetRect);
	point.x = GtRectGetRight(rect);
	GtCreateRectPathWithRightArrow(path, rect, point, kArrowSize, kCornerRadius);
}

- (void) getPathForLeft:(CGMutablePathRef) path rect:(CGRect) rect
{
	CGPoint point = GtRectGetCenter(m_targetRect);
	point.x = rect.origin.x;
	GtCreateRectPathWithLeftArrow(path, rect, point, kArrowSize, kCornerRadius);
}

- (void) pathForRect:(CGMutablePathRef) path rect:(CGRect) rect
{
    switch(m_arrowDirection)
	{
		case GtHoverViewArrowDirectionUp:
			[self getPathForTop:path rect:rect];
		break;
		case GtHoverViewArrowDirectionDown:
			[self getPathForBottom:path rect:rect];
		break;
		case GtHoverViewArrowDirectionLeft:
			[self getPathForLeft:path rect:rect];
		break;
		case GtHoverViewArrowDirectionRight:
			[self getPathForRight:path rect:rect];
		break;

		case GtHoverViewArrowDirectionNone:
			GtCreateRectPath(path, rect, kCornerRadius);
		break;
	}
}

- (void) drawOuterPath:(CGContextRef) context
{
	m_lineGradient.frame = self.bounds;
	CGRect outerRect = CGRectInset(self.bounds, 1, 1);
	CGMutablePathRef path =	 CGPathCreateMutable();
	[self pathForRect:path rect:outerRect];
	CGContextAddPath(context, path);
	CGContextClip(context);
	[m_lineGradient drawRect:outerRect];
	CGPathRelease(path);
}

#if DEBUG
- (void) setFrame:(CGRect) frame
{
    [super setFrame:frame];
}
#endif

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
//	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	[self drawOuterPath:context];
	CGContextRestoreGState(context);
	CGContextSaveGState(context);
	  
	CGRect innerRect = CGRectInset(self.bounds, kBorderWidthSize + 1.0f, kBorderWidthSize + 1.0f);
	CGMutablePathRef path =	 CGPathCreateMutable();
	[self pathForRect:path rect:innerRect];
	 
	CGContextAddPath(context, path);
	CGContextClip(context);
	CGContextClearRect(context, innerRect);
	
	CGContextAddPath(context, path);
    [[UIColor clearColor] setFill];
    
	GtColorStruct fillRgb = self.backgroundColor.colorStruct;
	CGContextSetRGBFillColor(context, fillRgb.red, fillRgb.green, fillRgb.blue, 0.8);
	CGContextFillPath(context);

	CGContextAddPath(context, path);
	CGContextClip(context);
	[m_gradient drawInRect:innerRect];

	CGContextRestoreGState(context);
	CGPathRelease(path);
}

- (void) dealloc
{	
//	  if(m_containedView)
//	  {
//		  [m_containedView removeObserver:self forKeyPath:@"frame"];
//	  }
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	GtRelease(m_lineGradient);
	GtRelease(m_gradient);
	GtRelease(m_containerView);
	GtRelease(m_containedView);
	GtSuperDealloc();
}

@end
