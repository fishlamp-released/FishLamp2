//
//	FLLegacyProgressView.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <QuartzCore/QuartzCore.h>

#import "FLLegacySimpleProgressView.h"
#import "FLGeometry.h"

#define FADE_DURATION 0.1
#define POPINOUT_DURATION 0.05

@interface FLLegacySimpleProgressView (Private)
- (void) _createViews;
@end

const struct FLProgressStyleStruct FLProgressStyleStructEmpty = { 0,0,0,0,0,0};
 
@implementation FLLegacySimpleProgressView

@synthesize progressBar = _progressBar;
@synthesize textLabel = _textLabel;
@synthesize progressBarTextLabel = _progressBarTextLabel;
@synthesize roundRectView = _roundRectView;

FLSynthesizeStructProperty(hasSecondaryText, setHasSecondaryText, BOOL, _style);
FLSynthesizeStructProperty(hasProgressBar, setHasProgressBar, BOOL, _style);
FLSynthesizeStructProperty(canDrag, setCanDrag, BOOL, _style);
FLSynthesizeStructProperty(isModal, setIsModal, BOOL, _style);
FLSynthesizeStructProperty(maximizeWidth, setMaximizeWidth, BOOL, _style);

#define DEFAULT_LABEL_WIDTH 100.0
#define DEFAULT_LABEL_HEIGHT 30.0
#define SPINNER_RIGHT_MARGIN 6.0
#define HEIGHT_BUFFER 16.0
#define WIDTH_BUFFER 40.0
#define SPINNER_TOP 8.0
#define TEXT_TOP 11.0
#define SPINNER_LEFT 10.0

- (void) applyTheme:(FLTheme*) theme {
#if VIEW_AUTOLAYOUT
	if(!FLRectLayoutIsValid([object autoLayoutMode]) || FLRectLayoutsAreEqual(object.autoLayoutMode, FLRectLayoutNone))
	{
		[object setAutoLayoutMode: FLRectLayoutCentered];
	}
#endif
}

- (id) initWithFrame:(CGRect) frame
{
    if(CGRectEqualToRect(CGRectZero, frame))
    {
        frame = CGRectMake(0,0, 200.0f, 80.0f);
    }

	if((self = [super initWithFrame:frame]))
	{
        self.wantsApplyTheme = YES;

        self.userInteractionEnabled = YES;
		self.multipleTouchEnabled = YES;
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.backgroundColor = [UIColor clearColor];
		self.exclusiveTouch = YES;
		
		_roundRectView = [[FLRoundRectView alloc] initWithFrame:CGRectZero];
		[self addSubview:_roundRectView];
    }

	return self;
}

- (id) init
{
	return [self initWithFrame:CGRectZero];
}

- (void) removeViews
{
	[_progressBar removeFromSuperview];
	[_spinner removeFromSuperview];
	[_textLabel removeFromSuperview];
	[_dragBar removeFromSuperview];
	[_progressBarTextLabel removeFromSuperview];
	[_progressBarSpinner removeFromSuperview];
}

- (void) releaseViews
{
	FLReleaseWithNil(_progressBar);
	FLReleaseWithNil(_spinner);
	FLReleaseWithNil(_textLabel);
	FLReleaseWithNil(_dragBar);
	FLReleaseWithNil(_progressBarTextLabel);
	FLReleaseWithNil(_progressBarSpinner);
}

- (void)dealloc 
{	
	FLRelease(_roundRectView);
	
	[self releaseViews];
	FLSuperDealloc();
}

#define DragBarWidth 20
#define DragBarSubViewHeights 4

#define Padding 6
#define Margin 10
#define BetweenSpinnerAndText 4
#define MinWidthWithProgress 120
#define TextMargin 20

- (CGSize) setContentModes:(UIView*) containerView
{
	CGRect progressFrame = CGRectMake(0,0,0,0);

	FLAssertIsNotNil(_textLabel);
	
	if(_dragBar)
	{
		_dragBar.frame = CGRectMake(0,0,DragBarWidth, DragBarSubViewHeights*2);
		_dragBar.frame = FLRectSetTop(_dragBar.frame, Padding);
	
		progressFrame = FLRectSetHeight(progressFrame, FLRectGetBottom(_dragBar.frame));
		progressFrame = FLRectSetWidth(progressFrame, _dragBar.frame.size.width);
	}
	
	if(_textLabel)
	{
//		  _textLabel.text = _style.title;
		_textLabel.frameOptimizedForSize = FLRectSetSize(_textLabel.frame, 0,0);
		
		CGSize size = [_textLabel sizeThatFitsText:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
		size.height = 20;
//		  size.height += 2; // for some reason it's cutting off decenders
		
		if(_style.maximizeWidth)
		{
			progressFrame = FLRectSetWidth(progressFrame, containerView.bounds.size.width - (Margin*2));
		}
		else
		{
			progressFrame = FLRectSetWidth(progressFrame, 
				MIN(size.width + (TextMargin*2), containerView.bounds.size.width - (Margin*2)));
		}
		
		progressFrame.size.width = MIN(400.0f, progressFrame.size.width);
		
		_textLabel.frameOptimizedForSize = FLRectSetSize(_textLabel.frame, progressFrame.size.width - (TextMargin*2), size.height); 
		_textLabel.frameOptimizedForSize = FLRectCenterRectInRectHorizontally(progressFrame, _textLabel.frame);
		
		if(_dragBar)
		{
			_textLabel.frameOptimizedForSize = FLRectSetTop(_textLabel.frame, FLRectGetBottom(_dragBar.frame) + Padding);
		}
		else
		{
			_textLabel.frameOptimizedForSize = FLRectSetTop(_textLabel.frame, Padding);
		}
		
		progressFrame = FLRectSetHeight(progressFrame, FLRectGetBottom(_textLabel.frame) + Padding);
	}
	
	if(_spinner && _textLabel)
	{
		_spinner.frameOptimizedForSize = FLRectSetOrigin(_spinner.frame, Padding, Padding);

		_textLabel.frameOptimizedForSize = FLRectSetLeft(_textLabel.frame, FLRectGetRight(_spinner.frame) + BetweenSpinnerAndText);

		progressFrame = FLRectSetWidth(progressFrame, 
			Padding + _spinner.frame.size.width + BetweenSpinnerAndText + _textLabel.frame.size.width + Margin + Padding);
	
		progressFrame = FLRectSetHeight(progressFrame, FLRectGetBottom(_spinner.frame) + Padding);
		
		_textLabel.frameOptimizedForSize = FLRectCenterRectInRectVertically(progressFrame, _textLabel.frame);
	}
	
	if(_progressBar && _textLabel)
	{
		if(!_dragBar)
		{
			_textLabel.frameOptimizedForSize = FLRectSetTop(_textLabel.frame, Margin);
		}
		
		if(progressFrame.size.width < MinWidthWithProgress)
		{
			progressFrame = FLRectSetWidth(progressFrame, MinWidthWithProgress);
		}
	
		_progressBar.frame = FLRectSetHeight(_progressBar.frame, Margin);
	
		_progressBar.frame = FLRectSetTop(_progressBar.frame, FLRectGetBottom(_textLabel.frame) + Padding);
	
		_progressBar.frame = FLRectSetWidth(_progressBar.frame, _textLabel.frame.size.width);
		
		_progressBar.frame = FLRectCenterRectInRectHorizontally(progressFrame, _progressBar.frame);

		progressFrame = FLRectSetHeight(progressFrame, FLRectGetBottom(_progressBar.frame) + Padding);
	}
	
	if(_progressBarTextLabel && _textLabel)
	{
		_progressBarTextLabel.frameOptimizedForSize = FLRectSetSizeWithSize(_progressBarTextLabel.frame, _textLabel.frame.size);
		
		_progressBarTextLabel.frameOptimizedForSize = FLRectCenterRectInRectHorizontally(progressFrame, _progressBarTextLabel.frame);
		if(_progressBar)
		{
			_progressBarTextLabel.frameOptimizedForSize = FLRectSetTop(_progressBarTextLabel.frame, FLRectGetBottom(_progressBar.frame)); 
		}
		else
		{
			_progressBarTextLabel.frameOptimizedForSize = FLRectSetTop(_progressBarTextLabel.frame, FLRectGetBottom(_textLabel.frame)); 
		}
	
		progressFrame = FLRectSetHeight(progressFrame, FLRectGetBottom(_progressBarTextLabel.frame) + Padding);
	}
	
	if(_progressBarSpinner && _textLabel)
	{
		if(_progressBarTextLabel && _progressBar)
		{
			if(FLStringIsEmpty(_progressBarTextLabel.text))
			{
				[_progressBarSpinner startAnimating];
			}
			_progressBarSpinner.frameOptimizedForSize = FLRectCenterRectInRect( _progressBarTextLabel.frame, _progressBarSpinner.frame); // inside of label while we wait for text
		}
		else if(_progressBarTextLabel)
		{
			_progressBarSpinner.frameOptimizedForSize = FLRectSetTop( _progressBarSpinner.frame,	FLRectGetBottom(_progressBarTextLabel.frame) + Padding);
			progressFrame = FLRectSetHeight(progressFrame, FLRectGetBottom(_progressBarSpinner.frame) + Padding);
		}
		else
		{
			_progressBarSpinner.frameOptimizedForSize = FLRectSetTop( _progressBarSpinner.frame,	FLRectGetBottom(_textLabel.frame) + Padding);
			progressFrame = FLRectSetHeight(progressFrame, FLRectGetBottom(_progressBarSpinner.frame) + Padding);
		}
		
		_progressBarSpinner.frameOptimizedForSize = FLRectCenterRectInRectHorizontally(progressFrame, _progressBarSpinner.frame);
	}
		
	if(_dragBar)
	{
		_dragBar.frame = FLRectCenterRectInRectHorizontally(progressFrame, _dragBar.frame);
	}

	_roundRectView.newFrame = self.bounds;

	return progressFrame.size;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
#if VIEW_AUTOLAYOUT
	if([self setFrameIfChanged:FLRectOptimizedForViewSize( FLRectSetSizeWithSize(self.frame, [self setContentModes:self.superview]))])
	{
		FLViewSetPositionInSuperview(self);
	}
#endif
	_roundRectView.newFrame = self.bounds;
}

- (void) _createViews
{
	if(_style.canDrag)
	{
		_dragBar = [[UIView alloc] initWithFrame:FLRectMakeIntegral(0,0, DragBarWidth, (DragBarSubViewHeights*2) + 2)];
		_dragBar.autoresizesSubviews = NO;
		
		UIView* view1 = [[UIView alloc] initWithFrame:FLRectMakeIntegral(0,0,DragBarWidth,DragBarSubViewHeights)];
		view1.backgroundColor = [UIColor darkGrayColor];

		UIView* view2 = [[UIView alloc] initWithFrame:FLRectMakeIntegral(0,DragBarSubViewHeights+2,DragBarWidth,DragBarSubViewHeights)];
		view2.backgroundColor = [UIColor darkGrayColor];

		[_dragBar addSubview:view1];
		[_dragBar addSubview:view2];
		
		FLReleaseWithNil(view1);
		FLReleaseWithNil(view2);

		[self addSubview:_dragBar];
	}

	_textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	_textLabel.textColor = [UIColor whiteColor];
	_textLabel.shadowColor = [UIColor blackColor];
	_textLabel.shadowOffset	= CGSizeMake (0.0, 1.0);
	_textLabel.backgroundColor = [UIColor clearColor];
	_textLabel.textAlignment = UITextAlignmentCenter;
	_textLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]]; 
	_textLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth;
	_textLabel.lineBreakMode = UILineBreakModeMiddleTruncation;
	[self addSubview:_textLabel];	  
	
	BOOL addSpinner = YES;

	if(_style.hasProgressBar)
	{
		_progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
		_progressBar.autoresizingMask = UIViewAutoresizingNone;
		_progressBar.backgroundColor = [UIColor clearColor];
		[self addSubview:_progressBar];
		
		addSpinner = NO;
	} 
	
	if( _style.hasProgressBar || 
		_style.hasSecondaryText)
	{
		_progressBarTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_progressBarTextLabel.textColor = [UIColor whiteColor];
		_progressBarTextLabel.backgroundColor = [UIColor clearColor];
		_progressBarTextLabel.textAlignment = UITextAlignmentCenter;
		_progressBarTextLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]]; 
		_progressBarTextLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth;
		_progressBarTextLabel.lineBreakMode = UILineBreakModeTailTruncation;
		_progressBarTextLabel.autoresizingMask = UIViewAutoresizingNone;
		[self addSubview:_progressBarTextLabel];

//		[self updateProgress:_progressValue];

		addSpinner = NO;
	}

	if(addSpinner)
	{
	// add spinner
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		
		[_spinner startAnimating];
		_spinner.frame = CGRectMake(0,0,20,20);
		_spinner.autoresizingMask = UIViewAutoresizingNone;
		[self addSubview:_spinner];
	}
	else
	{
		_progressBarSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		[_progressBarSpinner startAnimating];
		_progressBarSpinner.frame = CGRectMake(0,0,20,20);
		_progressBarSpinner.autoresizingMask = UIViewAutoresizingNone;
		_progressBarSpinner.hidesWhenStopped = YES;
		[self addSubview:_progressBarSpinner];
	}
}

- (void) updateProgress:(unsigned long long) amountWritten 
            totalAmount:(unsigned long long) totalAmount {
	if(_progressBar)
	{	
		FLAssertWithComment([NSThread isMainThread], @"not on main thread, use updateProgress:(FLProgressValue*) value");
   
		_progressBar.progress = ((float) amountWritten) / ((float) totalAmount);
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesBegan:touches withEvent:event];
	if(_style.canDrag)
	{
		_progressFlags.dragging = YES;
		_opacity = self.alpha;
		self.alpha = 0.5;
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesMoved:touches withEvent:event];
	if(_progressFlags.dragging)
	{
		UITouch* touch = [touches anyObject];

		CGPoint curPoint = [touch locationInView:self.superview];
		CGPoint prevPoint = [touch previousLocationInView:self.superview];
		
		CGRect frame = FLRectMoveWithPoint(self.frame, 
			CGPointMake(curPoint.x - prevPoint.x, curPoint.y - prevPoint.y));
		self.newFrame = frame;
	}
	

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesEnded:touches withEvent:event];

	if(_progressFlags.dragging)
	{
		_progressFlags.dragging = NO;
		self.alpha = _opacity;
//		  [self setNeedsDisplay];
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[super touchesCancelled:touches withEvent:event];
	if(_progressFlags.dragging)
	{
		_progressFlags.dragging = NO;
		self.alpha = _opacity;
//		  [self setNeedsDisplay];
	}
	
}

- (FLProgressStyleStruct) _createStyle:(BOOL) modal
	hasProgressBar:(BOOL) hasProgressBar
	hasSecondaryText:(BOOL) hasSecondaryText
	canDrag:(BOOL) canDrag
	maximizeWidth:(BOOL) maximizeWidth
{
	FLProgressStyleStruct style = FLProgressStyleStructEmpty;
	style = FLProgressStyleStructEmpty;
	style.isModal = modal;
	style.hasProgressBar = hasProgressBar;
	style.hasSecondaryText = hasSecondaryText;
	style.canDrag = canDrag;
	style.maximizeWidth = maximizeWidth;
	return style;
}

- (void) _resetStyle:(FLProgressStyleStruct) style
{
	_style = style;
	
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
	[self _resetStyle:[self _createStyle:_style.isModal 
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

+ (FLLegacySimpleProgressView*) progressView:(BOOL) hasProgressBar
	hasSecondaryText:(BOOL) hasSecondaryText
	canDrag:(BOOL) canDrag
	maximizeWidth:(BOOL) maximizeWidth
{
	FLLegacySimpleProgressView* outView = FLAutorelease([[FLLegacySimpleProgressView alloc] initWithFrame:CGRectZero]);
	[outView _resetStyle:[outView _createStyle:NO 
		hasProgressBar:hasProgressBar 
			hasSecondaryText:hasSecondaryText canDrag:canDrag maximizeWidth:maximizeWidth]];
	return outView;
}

+ (FLLegacySimpleProgressView*) modalProgressView:(BOOL) hasProgressBar
	hasSecondaryText:(BOOL) hasSecondaryText
	canDrag:(BOOL) canDrag
	maximizeWidth:(BOOL) maximizeWidth
{
	FLLegacySimpleProgressView* outView = FLAutorelease([[FLLegacySimpleProgressView alloc] initWithFrame:CGRectZero]);
	[outView _resetStyle:[outView _createStyle:YES hasProgressBar:hasProgressBar 
		hasSecondaryText:hasSecondaryText canDrag:canDrag maximizeWidth:maximizeWidth]];
	return outView;
}

+ (FLLegacySimpleProgressView*) defaultProgressView
{
	return [FLLegacySimpleProgressView progressView:NO
		hasSecondaryText:NO
		canDrag:NO
		maximizeWidth:NO];
}

+ (FLLegacySimpleProgressView*) defaultModalProgressView
{
	return [FLLegacySimpleProgressView modalProgressView:NO
		hasSecondaryText:NO
		canDrag:NO
		maximizeWidth:NO];
}

- (void) setProgressViewAlpha:(float) alpha
{
	_roundRectView.fillAlpha = alpha;
	_roundRectView.borderAlpha = alpha;
}

//- (void) start:(UIView*) superview
//{
//	  self.containerViewContentsDescriptor = superview.findViewContentsDescriptor;
//	  if(_style.isModal)
//	  {
// //		[[FLWindow topWindow] openShieldView:YES];
////		[[FLWindow topWindow].shieldView.rotatingView addSubview:self];
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
//		  if(_startDelay == 0)
//		  {
//			  [self start:inSuperview];
//		  }
//		  else
//		  {
//			  [self performSelector:@selector(start:) withObject:inSuperview afterDelay:_startDelay];
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

//- (void) showProgressInSuperview:(CocoaView*) superview
//{
//	[self showInSuperview:superview delay:self.startDelay];
//}
//
//- (void) showProgressInViewController:(CocoaViewController*) viewController
//{	
//	[self showInViewController:viewController isModal:self.modal delay:self.startDelay];
//}
//
//- (void) showProgress
//{
//	[[FLNotificationDisplayManager defaultDisplayManager] showProgress:self];
//}
//
//- (void) hideProgress
//{
//	[self hideModalView]; 
//}

- (void) setButtonTarget:(id)target action:(SEL) action isCancel:(BOOL) isCancel
{
}

- (NSString*) title
{
	return _textLabel.text;
}

- (void) setTitle:(NSString*) text
{
	if([NSThread isMainThread])
	{
		_textLabel.text = text; 
		[self setNeedsLayout];
	}
	else
	{
		[self performSelectorOnMainThread:@selector(setTitle:) withObject:text waitUntilDone:YES];
	}
}

- (NSString*) progressBarText 
{
	return _progressBarTextLabel.text;
}

- (void) setProgressBarText:(NSString*) text
{
	if([NSThread isMainThread])
	{	
		if(_progressBar)
		{
			if(_progressBarSpinner)
			{
				[_progressBarSpinner removeFromSuperview];
				FLReleaseWithNil(_progressBarSpinner);
			}
		}

		if(_progressBarTextLabel)
		{
			_progressBarTextLabel.text = text;
					   
			[_progressBarTextLabel sizeToFitText];	   
			_progressBarTextLabel.frameOptimizedForSize = 
				FLRectCenterRectInRectHorizontally(self.bounds, _progressBarTextLabel.frame);
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


