//
//	GtOldProgressView.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <QuartzCore/QuartzCore.h>

#import "GtOldProgressView.h"
#import "GtGeometry.h"
#import "GtErrorDisplayManager.h"

#define FADE_DURATION 0.1
#define POPINOUT_DURATION 0.05

@interface GtOldProgressView (Private)
- (void) _createViews;
@end

const struct GtProgressStyleStruct GtProgressStyleStructEmpty = { 0,0,0,0,0,0};
 
@implementation GtOldProgressView

@synthesize progressBar = m_progressBar;
@synthesize textLabel = m_textLabel;
@synthesize progressBarTextLabel = m_progressBarTextLabel;
@synthesize startDelay = m_startDelay;
@synthesize roundRectView = m_roundRectView;


GtSynthesizeStructProperty(hasSecondaryText, setHasSecondaryText, BOOL, m_style);
GtSynthesizeStructProperty(hasProgressBar, setHasProgressBar, BOOL, m_style);
GtSynthesizeStructProperty(canDrag, setCanDrag, BOOL, m_style);
GtSynthesizeStructProperty(isModal, setIsModal, BOOL, m_style);
GtSynthesizeStructProperty(maximizeWidth, setMaximizeWidth, BOOL, m_style);

#define DEFAULT_LABEL_WIDTH 100.0
#define DEFAULT_LABEL_HEIGHT 30.0
#define SPINNER_RIGHT_MARGIN 6.0
#define HEIGHT_BUFFER 16.0
#define WIDTH_BUFFER 40.0
#define SPINNER_TOP 8.0
#define TEXT_TOP 11.0
#define SPINNER_LEFT 10.0

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.userInteractionEnabled = YES;
		self.multipleTouchEnabled = YES;
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.backgroundColor = [UIColor clearColor];
		self.exclusiveTouch = YES;
		
		m_roundRectView = [[GtRoundRectView alloc] initWithFrame:CGRectZero];
		[self addSubview:m_roundRectView];
 
	}

	return self;
}

- (id) init
{
	return [self initWithFrame:CGRectZero];
}

- (void) removeViews
{
	[m_progressBar removeFromSuperview];
	[m_spinner removeFromSuperview];
	[m_textLabel removeFromSuperview];
	[m_dragBar removeFromSuperview];
	[m_progressBarTextLabel removeFromSuperview];
	[m_progressBarSpinner removeFromSuperview];
}

- (void) releaseViews
{
	GtReleaseWithNil(m_progressBar);
	GtReleaseWithNil(m_spinner);
	GtReleaseWithNil(m_textLabel);
	GtReleaseWithNil(m_dragBar);
	GtReleaseWithNil(m_progressBarTextLabel);
	GtReleaseWithNil(m_progressBarSpinner);
}

- (void)dealloc 
{	
	GtRelease(m_roundRectView);
	
	[self releaseViews];
	GtSuperDealloc();
}

#define DragBarWidth 20
#define DragBarSubViewHeights 4

#define Padding 6
#define Margin 10
#define BetweenSpinnerAndText 4
#define MinWidthWithProgress 120
#define TextMargin 20

- (CGSize) setViewPositions:(UIView*) containerView
{
	CGRect progressFrame = CGRectMake(0,0,0,0);

	GtAssertNotNil(m_textLabel);
	
	if(m_dragBar)
	{
		m_dragBar.frame = CGRectMake(0,0,DragBarWidth, DragBarSubViewHeights*2);
		m_dragBar.frame = GtRectSetTop(m_dragBar.frame, Padding);
	
		progressFrame = GtRectSetHeight(progressFrame, GtRectGetBottom(m_dragBar.frame));
		progressFrame = GtRectSetWidth(progressFrame, m_dragBar.frame.size.width);
	}
	
	if(m_textLabel)
	{
//		  m_textLabel.text = m_style.title;
		m_textLabel.frameOptimizedForSize = GtRectSetSize(m_textLabel.frame, 0,0);
		
		CGSize size = [m_textLabel sizeThatFitsText:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
		size.height = 20;
//		  size.height += 2; // for some reason it's cutting off decenders
		
		if(m_style.maximizeWidth)
		{
			progressFrame = GtRectSetWidth(progressFrame, containerView.bounds.size.width - (Margin*2));
		}
		else
		{
			progressFrame = GtRectSetWidth(progressFrame, 
				MIN(size.width + (TextMargin*2), containerView.bounds.size.width - (Margin*2)));
		}
		
		progressFrame.size.width = MIN(400.0f, progressFrame.size.width);
		
		m_textLabel.frameOptimizedForSize = GtRectSetSize(m_textLabel.frame, progressFrame.size.width - (TextMargin*2), size.height); 
		m_textLabel.frameOptimizedForSize = GtRectCenterRectInRectHorizontally(progressFrame, m_textLabel.frame);
		
		if(m_dragBar)
		{
			m_textLabel.frameOptimizedForSize = GtRectSetTop(m_textLabel.frame, GtRectGetBottom(m_dragBar.frame) + Padding);
		}
		else
		{
			m_textLabel.frameOptimizedForSize = GtRectSetTop(m_textLabel.frame, Padding);
		}
		
		progressFrame = GtRectSetHeight(progressFrame, GtRectGetBottom(m_textLabel.frame) + Padding);
	}
	
	if(m_spinner && m_textLabel)
	{
		m_spinner.frameOptimizedForSize = GtRectSetOrigin(m_spinner.frame, Padding, Padding);

		m_textLabel.frameOptimizedForSize = GtRectSetLeft(m_textLabel.frame, GtRectGetRight(m_spinner.frame) + BetweenSpinnerAndText);

		progressFrame = GtRectSetWidth(progressFrame, 
			Padding + m_spinner.frame.size.width + BetweenSpinnerAndText + m_textLabel.frame.size.width + Margin + Padding);
	
		progressFrame = GtRectSetHeight(progressFrame, GtRectGetBottom(m_spinner.frame) + Padding);
		
		m_textLabel.frameOptimizedForSize = GtRectCenterRectInRectVertically(progressFrame, m_textLabel.frame);
	}
	
	if(m_progressBar && m_textLabel)
	{
		if(!m_dragBar)
		{
			m_textLabel.frameOptimizedForSize = GtRectSetTop(m_textLabel.frame, Margin);
		}
		
		if(progressFrame.size.width < MinWidthWithProgress)
		{
			progressFrame = GtRectSetWidth(progressFrame, MinWidthWithProgress);
		}
	
		m_progressBar.frame = GtRectSetHeight(m_progressBar.frame, Margin);
	
		m_progressBar.frame = GtRectSetTop(m_progressBar.frame, GtRectGetBottom(m_textLabel.frame) + Padding);
	
		m_progressBar.frame = GtRectSetWidth(m_progressBar.frame, m_textLabel.frame.size.width);
		
		m_progressBar.frame = GtRectCenterRectInRectHorizontally(progressFrame, m_progressBar.frame);

		progressFrame = GtRectSetHeight(progressFrame, GtRectGetBottom(m_progressBar.frame) + Padding);
	}
	
	if(m_progressBarTextLabel && m_textLabel)
	{
		m_progressBarTextLabel.frameOptimizedForSize = GtRectSetSizeWithSize(m_progressBarTextLabel.frame, m_textLabel.frame.size);
		
		m_progressBarTextLabel.frameOptimizedForSize = GtRectCenterRectInRectHorizontally(progressFrame, m_progressBarTextLabel.frame);
		if(m_progressBar)
		{
			m_progressBarTextLabel.frameOptimizedForSize = GtRectSetTop(m_progressBarTextLabel.frame, GtRectGetBottom(m_progressBar.frame)); 
		}
		else
		{
			m_progressBarTextLabel.frameOptimizedForSize = GtRectSetTop(m_progressBarTextLabel.frame, GtRectGetBottom(m_textLabel.frame)); 
		}
	
		progressFrame = GtRectSetHeight(progressFrame, GtRectGetBottom(m_progressBarTextLabel.frame) + Padding);
	}
	
	if(m_progressBarSpinner && m_textLabel)
	{
		if(m_progressBarTextLabel && m_progressBar)
		{
			if(GtStringIsEmpty(m_progressBarTextLabel.text))
			{
				[m_progressBarSpinner startAnimating];
			}
			m_progressBarSpinner.frameOptimizedForSize = GtRectCenterRectInRect( m_progressBarTextLabel.frame, m_progressBarSpinner.frame); // inside of label while we wait for text
		}
		else if(m_progressBarTextLabel)
		{
			m_progressBarSpinner.frameOptimizedForSize = GtRectSetTop( m_progressBarSpinner.frame,	GtRectGetBottom(m_progressBarTextLabel.frame) + Padding);
			progressFrame = GtRectSetHeight(progressFrame, GtRectGetBottom(m_progressBarSpinner.frame) + Padding);
		}
		else
		{
			m_progressBarSpinner.frameOptimizedForSize = GtRectSetTop( m_progressBarSpinner.frame,	GtRectGetBottom(m_textLabel.frame) + Padding);
			progressFrame = GtRectSetHeight(progressFrame, GtRectGetBottom(m_progressBarSpinner.frame) + Padding);
		}
		
		m_progressBarSpinner.frameOptimizedForSize = GtRectCenterRectInRectHorizontally(progressFrame, m_progressBarSpinner.frame);
	}
		
	if(m_dragBar)
	{
		m_dragBar.frame = GtRectCenterRectInRectHorizontally(progressFrame, m_dragBar.frame);
	}

	m_roundRectView.newFrame = self.bounds;

	return progressFrame.size;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
#if VIEW_AUTOLAYOUT
	if([self setFrameIfChanged:GtRectGrowRectToOptimizedSizeIfNeeded( GtRectSetSizeWithSize(self.frame, [self setViewPositions:self.superview]))])
	{
		GtViewSetPositionInSuperview(self);
	}
#endif
	m_roundRectView.newFrame = self.bounds;
}

- (void) _createViews
{
	if(m_style.canDrag)
	{
		m_dragBar = [[UIView alloc] initWithFrame:GtRectMakeIntegral(0,0, DragBarWidth, (DragBarSubViewHeights*2) + 2)];
		m_dragBar.autoresizesSubviews = NO;
		
		UIView* view1 = [[UIView alloc] initWithFrame:GtRectMakeIntegral(0,0,DragBarWidth,DragBarSubViewHeights)];
		view1.backgroundColor = [UIColor darkGrayColor];

		UIView* view2 = [[UIView alloc] initWithFrame:GtRectMakeIntegral(0,DragBarSubViewHeights+2,DragBarWidth,DragBarSubViewHeights)];
		view2.backgroundColor = [UIColor darkGrayColor];

		[m_dragBar addSubview:view1];
		[m_dragBar addSubview:view2];
		
		GtReleaseWithNil(view1);
		GtReleaseWithNil(view2);

		[self addSubview:m_dragBar];
	}

	m_textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	m_textLabel.textColor = [UIColor whiteColor];
	m_textLabel.shadowColor = [UIColor blackColor];
	m_textLabel.shadowOffset	= CGSizeMake (0.0, 1.0);
	m_textLabel.backgroundColor = [UIColor clearColor];
	m_textLabel.textAlignment = UITextAlignmentCenter;
	m_textLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]]; 
	m_textLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth;
	m_textLabel.lineBreakMode = UILineBreakModeMiddleTruncation;
	[self addSubview:m_textLabel];	  
	
	BOOL addSpinner = YES;

	if(m_style.hasProgressBar)
	{
		m_progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
		m_progressBar.autoresizingMask = UIViewAutoresizingNone;
		m_progressBar.backgroundColor = [UIColor clearColor];
		[self addSubview:m_progressBar];
		
		addSpinner = NO;
	} 
	
	if( m_style.hasProgressBar || 
		m_style.hasSecondaryText)
	{
		m_progressBarTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		m_progressBarTextLabel.textColor = [UIColor whiteColor];
		m_progressBarTextLabel.backgroundColor = [UIColor clearColor];
		m_progressBarTextLabel.textAlignment = UITextAlignmentCenter;
		m_progressBarTextLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]]; 
		m_progressBarTextLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
		m_progressBarTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
		m_progressBarTextLabel.autoresizingMask = UIViewAutoresizingNone;
		[self addSubview:m_progressBarTextLabel];

//		[self updateProgress:m_progressValue];

		addSpinner = NO;
	}

	if(addSpinner)
	{
	// add spinner
		m_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		
		[m_spinner startAnimating];
		m_spinner.frame = CGRectMake(0,0,20,20);
		m_spinner.autoresizingMask = UIViewAutoresizingNone;
		[self addSubview:m_spinner];
	}
	else
	{
		m_progressBarSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		[m_progressBarSpinner startAnimating];
		m_progressBarSpinner.frame = CGRectMake(0,0,20,20);
		m_progressBarSpinner.autoresizingMask = UIViewAutoresizingNone;
		m_progressBarSpinner.hidesWhenStopped = YES;
		[self addSubview:m_progressBarSpinner];
	}
}

- (void) updateProgress:(unsigned long long) amountWritten 
            totalAmount:(unsigned long long) totalAmount;
{
	if(m_progressBar)
	{	
		GtAssert([NSThread isMainThread], @"not on main thread, use updateProgress:(GtProgressValue*) value");
   
		m_progressBar.progress = ((float) amountWritten) / ((float) totalAmount);
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	if(m_style.canDrag)
	{
		m_progressFlags.dragging = YES;
		m_opacity = self.alpha;
		self.alpha = 0.5;
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesMoved:touches withEvent:event];
	if(m_progressFlags.dragging)
	{
		UITouch* touch = [touches anyObject];

		CGPoint curPoint = [touch locationInView:self.superview];
		CGPoint prevPoint = [touch previousLocationInView:self.superview];
		
		CGRect frame = GtRectMoveWithPoint(self.frame, 
			CGPointMake(curPoint.x - prevPoint.x, curPoint.y - prevPoint.y));
		self.newFrame = frame;
	}
	

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];

	if(m_progressFlags.dragging)
	{
		m_progressFlags.dragging = NO;
		self.alpha = m_opacity;
//		  [self setNeedsDisplay];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesCancelled:touches withEvent:event];
	if(m_progressFlags.dragging)
	{
		m_progressFlags.dragging = NO;
		self.alpha = m_opacity;
//		  [self setNeedsDisplay];
	}
	
}

- (GtProgressStyleStruct) _createStyle:(BOOL) modal
	hasProgressBar:(BOOL) hasProgressBar
	hasSecondaryText:(BOOL) hasSecondaryText
	canDrag:(BOOL) canDrag
	maximizeWidth:(BOOL) maximizeWidth
{
	GtProgressStyleStruct style = GtProgressStyleStructEmpty;
	style = GtProgressStyleStructEmpty;
	style.isModal = modal;
	style.hasProgressBar = hasProgressBar;
	style.hasSecondaryText = hasSecondaryText;
	style.canDrag = canDrag;
	style.maximizeWidth = maximizeWidth;
	return style;
}

- (void) _resetStyle:(GtProgressStyleStruct) style
{
	m_style = style;
	
	[self removeViews];
	[self releaseViews];
	[self _createViews];
//	  [self updateSizeAndPositionInContainerView];
}

- (void) resetStyle:(BOOL) hasProgressBar
	hasSecondaryText:(BOOL) hasSecondaryText
	canDrag:(BOOL) canDrag
	maximizeWidth:(BOOL) maximizeWidth
{
	[self _resetStyle:[self _createStyle:m_style.isModal 
		hasProgressBar:hasProgressBar 
		hasSecondaryText:hasSecondaryText 
		canDrag:canDrag 
		maximizeWidth:maximizeWidth]];

//	  [self setNeedsLayout];
}

- (id) initDefaultProgress
{
	if((self = [self initWithFrame:CGRectZero]))
	{
		[self _resetStyle:[self _createStyle:NO hasProgressBar:NO 
			hasSecondaryText:NO canDrag:NO maximizeWidth:NO]];
	}
	
	return self;
}

- (id) initDefaultModalProgress
{
	if((self = [self initWithFrame:CGRectZero]))
	{
		[self _resetStyle:[self _createStyle:YES hasProgressBar:NO 
			hasSecondaryText:NO canDrag:NO maximizeWidth:NO]];
	}
	
	return self;
}

+ (GtOldProgressView*) progressView:(BOOL) hasProgressBar
	hasSecondaryText:(BOOL) hasSecondaryText
	canDrag:(BOOL) canDrag
	maximizeWidth:(BOOL) maximizeWidth
{
	GtOldProgressView* outView = GtReturnAutoreleased([[GtOldProgressView alloc] initWithFrame:CGRectZero]);
	[outView _resetStyle:[outView _createStyle:NO 
		hasProgressBar:hasProgressBar 
			hasSecondaryText:hasSecondaryText canDrag:canDrag maximizeWidth:maximizeWidth]];
	return outView;
}

+ (GtOldProgressView*) modalProgressView:(BOOL) hasProgressBar
	hasSecondaryText:(BOOL) hasSecondaryText
	canDrag:(BOOL) canDrag
	maximizeWidth:(BOOL) maximizeWidth
{
	GtOldProgressView* outView = GtReturnAutoreleased([[GtOldProgressView alloc] initWithFrame:CGRectZero]);
	[outView _resetStyle:[outView _createStyle:YES hasProgressBar:hasProgressBar 
		hasSecondaryText:hasSecondaryText canDrag:canDrag maximizeWidth:maximizeWidth]];
	return outView;
}

+ (GtOldProgressView*) defaultProgressView
{
	return [GtOldProgressView progressView:NO
		hasSecondaryText:NO
		canDrag:NO
		maximizeWidth:NO];
}

+ (GtOldProgressView*) defaultModalProgressView
{
	return [GtOldProgressView modalProgressView:NO
		hasSecondaryText:NO
		canDrag:NO
		maximizeWidth:NO];
}

- (void) setProgressViewAlpha:(float) alpha
{
	m_roundRectView.fillAlpha = alpha;
	m_roundRectView.borderAlpha = alpha;
}

//- (void) start:(UIView*) superview
//{
//	  self.containerViewContentsDescriptor = superview.findViewContentsDescriptor;
//	  if(m_style.isModal)
//	  {
// //		[[GtWindow topWindow] openShieldView:YES];
////		[[GtWindow topWindow].shieldView.rotatingView addSubview:self];
//	  }
//	  else
//	  {
//		  [superview addSubview:self];
//	  }
//	  
//	  [self setHidden:NO];
//			  
//}
//
//- (void) startProgressInSuperview:(UIView*) inSuperview
//{
//	  if([NSThread isMainThread])
//	  {
//		  if(m_startDelay == 0)
//		  {
//			  [self start:inSuperview];
//		  }
//		  else
//		  {
//			  [self performSelector:@selector(start:) withObject:inSuperview afterDelay:m_startDelay];
//		  }
//	  }
//	  else
//	  {
//		  [self performSelectorOnMainThread:@selector(startProgressInSuperview:) withObject:inSuperview waitUntilDone:YES];
//	  }
//}
//
//- (void) startProgressInViewController:(NSViewController*) viewController
//{
//	[self startProgressInSuperview:viewController.view];
//}

- (void) showProgressInSuperview:(UIView*) superview
{
	[self showInSuperview:superview delay:self.startDelay];
}

- (void) showProgressInViewController:(UIViewController*) viewController
{	
	[self showInViewController:viewController isModal:self.modal delay:self.startDelay];
}

- (void) showProgress
{
//	[[GtNotificationDisplayManager defaultDisplayManager] showProgress:self];
}

- (void) hideProgress
{
	[self hideModalView]; 
}

- (void) setButtonTarget:(id)target action:(SEL) action isCancel:(BOOL) isCancel
{
}

- (NSString*) title
{
	return m_textLabel.text;
}

- (void) setTitle:(NSString*) text
{
	if([NSThread isMainThread])
	{
		m_textLabel.text = text; 
		[self setNeedsLayout];
	}
	else
	{
		[self performSelectorOnMainThread:@selector(setTitle:) withObject:text waitUntilDone:YES];
	}
}

- (NSString*) progressBarText 
{
	return m_progressBarTextLabel.text;
}

- (void) setProgressBarText:(NSString*) text
{
	if([NSThread isMainThread])
	{	
		if(m_progressBar)
		{
			if(m_progressBarSpinner)
			{
				[m_progressBarSpinner removeFromSuperview];
				GtReleaseWithNil(m_progressBarSpinner);
			}
		}

		if(m_progressBarTextLabel)
		{
			m_progressBarTextLabel.text = text;
					   
			[m_progressBarTextLabel sizeToFitText];	   
			m_progressBarTextLabel.frameOptimizedForSize = 
				GtRectCenterRectInRectHorizontally(self.bounds, m_progressBarTextLabel.frame);
		}
		
		// not calling setNeedsLayout here because we're assuming secondaryText is <= in width to progress text.
	}
	else
	{
		 [self performSelectorOnMainThread:@selector(setSecondaryText:) withObject:text waitUntilDone:YES];
   
	}
}

- (NSString*) buttonTitle
{
	return	nil;
}

- (void) setButtonTitle:(NSString*) text
{
}

- (NSString*) secondaryText
{
	return nil;
}

- (void) setSecondaryText:(NSString*) text
{
}

- (void) watchActivity:(id) object
{
}


@end


