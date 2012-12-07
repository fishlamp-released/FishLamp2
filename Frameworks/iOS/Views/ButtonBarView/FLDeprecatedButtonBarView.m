//
//	FLDeprecatedButtonbarView.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/19/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLDeprecatedButtonbarView.h"
#import "FLNavigationControllerViewController.h"
#import "FLGradientButton.h"
#import "FLImage+Colorize.h"
#import "FLViewController.h"
#import "FLGradientView.h"

#define kResizableView 1
#define kFadeAnimationDuration 0.3f

typedef enum {
 FLButtonBarViewAnimationStateNone,
 FLButtonBarViewAnimationStateAnimatingShow,
 FLButtonBarViewAnimationStateAnimatingHide 
} FLButtonBarViewAnimationState;


@interface FLButtonbarViewContainer : NSObject {
@private
	NSString* _key;
	UIView* _view;
	FLButtonBarViewAnimationState _animationState;
}
@property (readwrite, assign, nonatomic) FLButtonBarViewAnimationState animationState;
@property (readwrite, retain, nonatomic) UIView* view;
@property (readwrite, retain, nonatomic) NSString* key;
- (id) initWithView:(UIView*) view key:(NSString*) key;
+ (FLButtonbarViewContainer*) buttonbarViewContainer:(UIView*) view key:(NSString*) key;
@end

@implementation FLButtonbarViewContainer

@synthesize view = _view;
@synthesize key = _key;
@synthesize animationState = _animationState;
#if 0 
//DEBUG
- (void) setAnimationState:(FLButtonBarViewAnimationState) state
{
	_animationState = state;
	
	switch(_animationState)
	{
		case FLButtonBarViewAnimationStateNone: FLLog(@"Set animation state to NONE"); break;
		case FLButtonBarViewAnimationStateAnimatingShow: FLLog(@"Set animation state to SHOW"); break;
		case FLButtonBarViewAnimationStateAnimatingHide: FLLog(@"Set animation state to HIDE"); break;
	}
}
#endif

- (id) initWithView:(UIView*) view key:(NSString*) key
{
	if((self = [super init]))
	{
		self.view = view;
		self.key = key;
	}
	
	return self;
}
+ (FLButtonbarViewContainer*) buttonbarViewContainer:(UIView*) view key:(NSString*) key
{
	return FLAutorelease([[FLButtonbarViewContainer alloc] initWithView:view key:key]);
}

- (void) dealloc
{
	FLRelease(_view);
	FLRelease(_key);
	super_dealloc_();
}

@end


@interface FLDeprecatedButtonbarView ()
- (void) updateLayout:(BOOL) animated;
@end

@implementation FLDeprecatedButtonbarView {
@private
	UILabel* _label;
	UILabel* _subtitleLabel;
	NSMutableArray* _leftViews;
	NSMutableArray* _rightViews;
	struct {
		unsigned int isInitialized: 1;
        unsigned int automaticallyShowBackButton;
	} _navBarFlags;
	
	CGFloat _leftIndent;
}
 
@synthesize leftIndent = _leftIndent;
@synthesize titleLabel = _label;

FLSynthesizeStructProperty(isInitialized, setIsInitialized, BOOL, _navBarFlags);
FLSynthesizeStructProperty(automaticallyShowBackButton, setAutomaticallyShowBackButton, BOOL, _navBarFlags);

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
		self.autoresizesSubviews = NO;
		self.userInteractionEnabled = YES;
		self.exclusiveTouch = YES;
	}

	return self;
}

- (void) dealloc
{
	FLRelease(_leftViews);
	FLRelease(_rightViews);
	FLRelease(_label);
	super_dealloc_();
}

- (CGRect) rectForButtonWithKey:(NSString*) key forDisplayInView:(UIView*) view
{
	UIView* ourBarView = [self viewForKey:key];
	return ourBarView ? [view convertRect:ourBarView.frame fromView:self] : CGRectZero;
}

- (void) disableAllButtons
{
	for(id view in _leftViews)
	{
		if([view respondsToSelector:@selector(setEnabled:)])
		{
			[view setEnabled:NO];
		}
	}
	for(id view in _rightViews)
	{
		if([view respondsToSelector:@selector(setEnabled:)])
		{
			[view setEnabled:NO];
		}
	}
}

- (FLButtonbarViewContainer*) _viewContainerForKey:(NSString*) key array:(NSArray*) array
{
	for(FLButtonbarViewContainer* viewContainer in array)
	{
		if(FLStringsAreEqual(viewContainer.key, key))
		{
			return viewContainer;
		}
	}
	
	return nil;
}

- (FLButtonbarViewContainer*) _viewContainerForKey:(NSString*) key
{
	FLButtonbarViewContainer* viewContainer = [self _viewContainerForKey:key array:_leftViews];
	return viewContainer ? viewContainer : [self _viewContainerForKey:key array:_rightViews];
}

- (void) setViewHidden:(BOOL) hidden forKey:(NSString*) key animated:(BOOL) animated
{
	FLButtonbarViewContainer* container = [self _viewContainerForKey:key];
	if(container && container.view.hidden != hidden)
	{
		if(animated)
		{
			container.animationState = hidden ? FLButtonBarViewAnimationStateAnimatingHide : FLButtonBarViewAnimationStateAnimatingShow;
			[container.view setHiddenWithFade:hidden duration:kFadeAnimationDuration finishedBlock:^(UIView* blockView) 
				{ container.animationState = FLButtonBarViewAnimationStateNone; }];
			[self updateLayout:YES];
		}
		else
		{
			container.animationState = FLButtonBarViewAnimationStateNone;
			container.view.hidden = hidden;
			[self setNeedsLayout];
		}
	}
}

- (void) setViewEnabled:(BOOL) enabled forKey:(NSString*) key
{
	id view = [self viewForKey:key];
	if(view)
	{
		if([view respondsToSelector:@selector(setEnabled:)])
		{
			[view setEnabled:enabled];
		}
		[self setNeedsLayout];
	}
}

- (NSString*) title
{
	return _label ? _label.text : @"";
}

- (void) setTitle:(NSString*) title
{
	if(!_label)
	{
		_label = [[UILabel alloc] initWithFrame:self.bounds];
		_label.autoresizingMask = UIViewAutoresizingNone;
		if(DeviceIsPad())
		{
			_label.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
		}
		else
		{
			_label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
		}
		_label.textColor = [UIColor whiteColor];
		_label.shadowColor = [UIColor darkTextColor];
		_label.shadowOffset	= FLSizeMake (0.0, 0.0);
		_label.lineBreakMode = UILineBreakModeTailTruncation;
		_label.backgroundColor = [UIColor clearColor];
		_label.textAlignment = UITextAlignmentCenter;
		[self addSubview:_label];
	}

	if(FLStringIsEmpty(title))
	{
		_label.text = @"";
	}
	else
	{
		_label.text = title;
	}

	[self setNeedsLayout];
}

- (NSString*) subtitle
{
	return _subtitleLabel ? _subtitleLabel.text : nil;
}

- (void) setSubtitle:(NSString*) subtitle
{
	if(!FLStringsAreEqual(subtitle, self.subtitle))
	{
		if(FLStringIsNotEmpty(subtitle))
		{
			if(!_subtitleLabel)
			{
				_subtitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
				_subtitleLabel.autoresizingMask = UIViewAutoresizingNone;
				_subtitleLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
				_subtitleLabel.textColor = [UIColor grayColor];
				_subtitleLabel.shadowColor = [UIColor darkTextColor];
				_subtitleLabel.shadowOffset	= FLSizeMake (0.0, 0.0);
				_subtitleLabel.lineBreakMode = UILineBreakModeTailTruncation;
				_subtitleLabel.backgroundColor = [UIColor clearColor];
				_subtitleLabel.textAlignment = UITextAlignmentCenter;
				[self addSubview:_subtitleLabel];
			}
		
			_subtitleLabel.text = subtitle;
			[self setNeedsLayout];
		}
		else if(_subtitleLabel)
		{
			_subtitleLabel.text = @"";
			[self setNeedsLayout];
		}
	}
}

- (void) setSubtitleWithItemCount:(NSUInteger) itemCount actionItemName:(NSString*) actionItemName
{
	if(itemCount == 1)
	{
		self.subtitle = [NSString stringWithFormat:@"1 %@", actionItemName];
	}	
	else
	{
		self.subtitle = [NSString stringWithFormat:@"%d %@s", itemCount, actionItemName];
	}
}

- (UIView*) viewForKey:(NSString*) key
{
	FLButtonbarViewContainer* viewContainer = [self _viewContainerForKey:key];
	return viewContainer ? viewContainer.view : nil;
}

- (BOOL) _setView:(UIView*) view forKey:(NSString*)key animated:(BOOL) animated array:(NSMutableArray*) array
{
	for(NSUInteger i = 0; i < array.count; i++)
	{
		FLButtonbarViewContainer* viewContainer = [array objectAtIndex:i];
		if(FLStringsAreEqual(viewContainer.key, key) && viewContainer.view != view)
		{
			[viewContainer.view removeFromSuperview];
			viewContainer.view = view;
			[self addSubview:view];

			if(animated)
			{
				viewContainer.animationState = FLButtonBarViewAnimationStateAnimatingShow;
				[view animateOntoScreen:FLViewAnimationTypeFade duration:kFadeAnimationDuration finishedBlock:^(UIView* blockView) 
					{ viewContainer.animationState = FLButtonBarViewAnimationStateNone; }];
				[self updateLayout:YES];
			}
			else
			{
				viewContainer.animationState = FLButtonBarViewAnimationStateNone;
				[self setNeedsLayout];
			}
			
			return YES;
		}
	}
	return NO;
}

- (void) setView:(UIView*) view forKey:(NSString*)key animated:(BOOL) animated
{
	if(![self _setView:view forKey:key animated:animated array:_leftViews])
	{
		[self _setView:view forKey:key animated:animated array:_rightViews];
	}
}

- (void) removeViewForKey:(NSString*) key animated:(BOOL) animated
{
	FLButtonbarViewContainer* viewContainer = [self _viewContainerForKey:key array:_leftViews];
	if(viewContainer)
	{
		[_leftViews removeObject:FLAutorelease(retain_(viewContainer))];
	}
	else
	{
		viewContainer = [self _viewContainerForKey:key array:_rightViews];
		if(viewContainer)
		{
			[_rightViews removeObject:FLAutorelease(retain_(viewContainer))];
		}
	}
	
	if(viewContainer)
	{
		if(animated)
		{
			viewContainer.animationState = FLButtonBarViewAnimationStateAnimatingHide;
			[viewContainer.view removeFromSuperviewWithAnimationType:FLViewAnimationTypeFade duration:kFadeAnimationDuration finishedBlock:^(UIView* finishBlock) 
				{ viewContainer.animationState = FLButtonBarViewAnimationStateNone; } ];
			[self updateLayout:YES];
		}
		else
		{
			viewContainer.animationState = FLButtonBarViewAnimationStateNone; 
			[viewContainer.view removeFromSuperview];
			[self setNeedsLayout];
		}
	}
}

+ (UIButton*) createImageButton:(UIImage*) image 
                               target:(id) target 
                               action:(SEL) action
{
    FLAssertIsNotNil_(image);
    FLAssertIsNotNil_(target);
    FLAssertIsNotNil_(action);

	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0,0, image.size.width, image.size.height);
	[button setImage:image forState:UIControlStateNormal];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	button.tag = kResizableView;
	button.enabled = YES;
	button.showsTouchWhenHighlighted = YES;
	return button;
}


+ (UIButton*) createImageButtonByName:(NSString*) imageName 
                           imageColor:(NSUInteger) colorOfImageInFile
                               target:(id) target 
                               action:(SEL) action
{
    UIImage* image = nil;
    switch(colorOfImageInFile)
    {
        case FLImageColorBlack:
        case FLImageColorGray:
        image = [UIImage whiteImageNamed:imageName];
        break;

        case FLImageColorLightGray:
        image = [[UIImage imageNamed:imageName] colorizeImage:[UIColor lightGrayColor] blendMode:kCGBlendModeOverlay];
        break;

        case FLImageColorWhite:
        image = [UIImage imageNamed:imageName];
        break;
    }
    
    return [self createImageButton:image target:target action:action];
}

+ (UIView*) createEmptyItem
{
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0,0, 22, 22);
	button.enabled = NO;
	button.showsTouchWhenHighlighted = NO;
	return button;
}

- (FLLegacyButton*) backButton
{
	return (FLLegacyButton*) [self viewForKey:FLButtonbarViewBackButtonKey];
}

- (BOOL) backButtonHidden
{
	return [self viewForKey:FLButtonbarViewBackButtonKey].hidden;
}

- (void) setBackButtonHidden:(BOOL) hidden animated:(BOOL) animated
{
	[self setViewHidden:hidden forKey:FLButtonbarViewBackButtonKey animated:animated];
}

- (void) setBackButtonHidden:(BOOL) hidden
{
	[self setViewHidden:hidden forKey:FLButtonbarViewBackButtonKey animated:NO];
}

- (void) _addView:(UIView*) view 
    forKey:(NSString*) key 
    array:(NSMutableArray*) array 
    appendView:(BOOL) appendView
    animated:(BOOL) animated
{
	if(![self _setView:view forKey:key animated:animated array:array])
	{
		[self addSubview:view];
		
		FLButtonbarViewContainer* container = [FLButtonbarViewContainer buttonbarViewContainer:view key:key];
		if(appendView) 
        {
            [array addObject:container];
        }
        else
        {
            [array insertObject:container atIndex:0];
        }
				
		if(animated)
		{
			container.animationState = FLButtonBarViewAnimationStateAnimatingShow;
			[view animateOntoScreen:FLViewAnimationTypeFade duration:kFadeAnimationDuration finishedBlock:^(UIView* blockView) 
				{ container.animationState = FLButtonBarViewAnimationStateNone; }];
			[self updateLayout:YES];
		}
		else
		{
			container.animationState = FLButtonBarViewAnimationStateNone;
			
			[self setNeedsLayout];
		}
	}
}

- (void) addBackButton:(NSString*) title target:(id) target action:(SEL) action 
{
    FLAssertIsNil_(self.backButton);

	FLBackButtonDeprecated* backButton = [FLBackButtonDeprecated backButton:title target:target action:action];
	backButton.tag = NO;
	[backButton setViewSizeToContentSize];

	if(!_leftViews)
	{
		_leftViews = [[NSMutableArray alloc] init];
	}
	
	[self _addView:backButton forKey:FLButtonbarViewBackButtonKey array:_leftViews appendView:NO animated:NO];
}

- (void) addButtonToRightSide:(FLLegacyButton*) button forKey:(NSString*) key animated:(BOOL) animated
{
	[button setViewSizeToContentSize];
	button.tag = NO;
	[self addViewToRightSide:button forKey:key animated:animated];
}

- (void) addButtonToLeftSide:(FLLegacyButton*) button forKey:(NSString*) key animated:(BOOL) animated
{
	button.tag = NO;
	[button setViewSizeToContentSize];
	[self addViewToLeftSide:button forKey:key animated:animated];
}

- (void) addViewToRightSide:(UIView*) view forKey:(NSString*) key animated:(BOOL) animated
{
	if(!_rightViews)
	{
		_rightViews = [[NSMutableArray alloc] init];
	}
	[self _addView:view forKey:key array:_rightViews appendView:YES animated:animated];
}

- (void) addViewToLeftSide:(UIView*) view forKey:(NSString*) key animated:(BOOL) animated
{
	if(!_leftViews)
	{
		_leftViews = [[NSMutableArray alloc] init];
	}
	
	[self _addView:view forKey:key array:_leftViews appendView:YES animated:animated];
}

//- (void) addImageButtonToRightSide:(UIImage*) image target:(id) target action:(SEL) action forKey:(NSString*) key animated:(BOOL) animated
//{
//	UIButton* button = [FLDeprecatedButtonbarView createImageButton:image target:target action:action];
//	button.tag = kResizableView;
//	[self addViewToRightSide:button forKey:key animated:animated];
//}
//
//- (void) addImageButtonToLeftSide:(UIImage*) image target:(id) target action:(SEL) action forKey:(NSString*) key animated:(BOOL) animated
//{
//	UIButton* button = [FLDeprecatedButtonbarView createImageButton:image target:target action:action];
//	button.tag = kResizableView;
//	[self addViewToLeftSide:button forKey:key animated:animated];
//}


- (void) layoutSubviews
{
	[super layoutSubviews];
	[self updateLayout:NO];
}


- (void) updateLayout:(BOOL) animated
{

	static CGFloat s_buffer = 0.0;
	static CGFloat s_minBuffer = 4.0f;
	static CGFloat s_minWidth = 0.0;
//	  static CGFloat s_rightSideMargin = 2.0f;
	static CGFloat s_leftBuffer = 10.0f;
	if(!s_buffer)
	{
		if(DeviceIsPad())
		{
			s_buffer = 20.0f;
			s_minWidth = 60.0f;
			s_leftBuffer = 8.0f;
			
		}
		else
		{
			s_buffer = 20.0f;
			s_minWidth = 30.0f;
			s_leftBuffer = 4.0f;
		}
	}
	
	if(!self.superview)
	{
		return;
	}
	
	UIView* lastLeftView = nil;
	UIView* lastRightView = nil;
	
	CGFloat height = self.bounds.size.height;
//	  FLLog(@"spacing %f", self.superview.bounds.origin.x - self.frame.origin.x);
	FLLegacyButton* backButton = self.backButton;

	NSUInteger left = backButton && !backButton.hidden ? 0.0 : s_leftBuffer; // ((self.frame.origin.x - self.superview.bounds.origin.x) > s_leftBuffer) ? s_buffer + 6.0 : s_rightSideMargin;
	if(_leftViews)
	{
		for(FLButtonbarViewContainer* viewContainer in _leftViews)
		{	
			UIView* leftView = viewContainer.view;
//			  leftView.backgroundColor = [UIColor greenColor];
			if(!leftView.hidden && viewContainer.animationState != FLButtonBarViewAnimationStateAnimatingHide)
			{
				if(leftView.tag == kResizableView)
				{
					if(left != 0)
					{
						left += s_buffer;
					}
				
					CGRect r = FLRectSetSize(leftView.frame, 
							MAX(leftView.frame.size.width, height), 
							MAX(leftView.frame.size.height, height));
						
					r.origin.x = left;
					r = FLRectCenterRectInRectVertically(self.bounds, r);
					
					leftView.frameOptimizedForSize = r;
					left += (MAX(s_minWidth, leftView.frame.size.width));
				}
				else
				{
					if(left != 0)
					{
						left += s_minBuffer;
					}
				
					[leftView setViewSizeToContentSize];

					CGRect r = CGRectMake(left,0,leftView.frame.size.width, height);
					leftView.frameOptimizedForSize = FLRectCenterRectInRect(r, leftView.frame);
					
					left = FLRectGetRight(leftView.frame);
				}

				
				lastLeftView = leftView;
			}
		}
	}
	
	NSUInteger right = FLRectGetRight(self.bounds);
	BOOL firstRightView = YES;
	if(_rightViews)
	{
		for(FLButtonbarViewContainer* viewContainer in _rightViews.reverseObjectEnumerator)
		{
			UIView* rightView = viewContainer.view;
			if(!rightView.hidden && viewContainer.animationState != FLButtonBarViewAnimationStateAnimatingHide)
			{
				CGRect layoutRect = CGRectMake(0,0,MAX(s_minWidth, rightView.frame.size.width), height);
				if(rightView.tag == kResizableView)
				{
					CGRect r = FLRectSetSize(rightView.frame, 
								MAX(rightView.frame.size.width, height),
								MAX(rightView.frame.size.height, height));
					
					layoutRect.size.width = MAX(s_minWidth, r.size.width);
					layoutRect.origin.x = (right - layoutRect.size.width - (firstRightView ? 0: s_buffer)); 
					
					r = FLRectCenterRectInRectVertically(layoutRect, r);
					r.origin.x = FLRectGetRight(layoutRect) - r.size.width;
					
					rightView.frameOptimizedForSize = r;
					right = layoutRect.origin.x;
				}
				else
				{
					[rightView setViewSizeToContentSize];
					layoutRect.origin.x = (right - layoutRect.size.width - s_leftBuffer);
					rightView.frameOptimizedForSize = FLRectCenterRectInRect(layoutRect, rightView.frame);
					right = layoutRect.origin.x;
				}
			
				lastRightView = rightView; 
			}
			
			firstRightView = NO;
		}	 
	}
	
	// center the label
	
	left = (lastLeftView ? FLRectGetRight(lastLeftView.frame) : 0.0) + 4.0;
	right = lastRightView ? lastRightView.frame.origin.x : FLRectGetRight(self.bounds);
	
	CGFloat maxSize = right - left;
	   
	CGRect titleRect = CGRectZero;
	CGRect subtitleRect = CGRectZero;
		
	titleRect.size = [_label sizeThatFitsText];
	titleRect = FLRectCenterRectInRect(self.bounds, FLRectSetWidth(titleRect, MIN(maxSize, titleRect.size.width)));
	
	if(_subtitleLabel && FLStringIsNotEmpty(_subtitleLabel.text))
	{
		titleRect = FLRectMoveVertically(titleRect, -6);

		subtitleRect.size = [_subtitleLabel sizeThatFitsText];
		subtitleRect = FLRectCenterRectInRect(self.bounds, subtitleRect);
		subtitleRect.origin.y = FLRectGetBottom(titleRect) - 2.0f;
	}
	
//	  CGPoint centerPoint = FLRectGetCenter(self.bounds); //[self convertPoint:FLRectGetCenter(self.superview.bounds) fromView:self.superview];
//	  frame = FLRectOptimizedForViewSize(FLRectCenterOnPoint(frame, centerPoint));
	
	CGFloat insetLeft = 0.0;
	CGFloat insetRight = 0.0;
	if(titleRect.origin.x < left)
	{
		insetLeft = left - titleRect.origin.x;
	}
	if(FLRectGetRight(titleRect) > right)
	{
		insetRight = FLRectGetRight(titleRect) - right;
	}
	
	if(insetLeft != 0.0 || insetRight != 0.0)
	{
		if(insetLeft > insetRight)
		{
			titleRect = FLRectMoveHorizontally(titleRect, insetLeft);
			subtitleRect = FLRectMoveHorizontally(subtitleRect, insetLeft);
		}
		else
		{
			titleRect = FLRectMoveHorizontally(titleRect, -insetRight);
			subtitleRect = FLRectMoveHorizontally(subtitleRect, -insetRight);
		}
	}
	_label.frameOptimizedForSize = titleRect;
	if(_subtitleLabel && FLStringIsNotEmpty(_subtitleLabel.text))
	{
		_subtitleLabel.frameOptimizedForSize = subtitleRect;
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	// intentionally eating the event.
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	// intentionally eating the event.
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	// intentionally eating the event.
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	// intentionally eating the event.
}

- (void) viewControllerTitleDidChange:(UIViewController*) viewController
{
    self.title = viewController.title;
    if(self.backButton)
    {
        [self backButton].title = viewController.backButtonTitle;
    }
    [self setNeedsLayout];
}

- (void) viewControllerViewWillAppear:(UIViewController*) viewController
{
    [self viewControllerTitleDidChange:viewController];
}

- (void) viewController:(UIViewController*) viewController willBePushedOnNavigationController:(UINavigationController *)controller
{
    if(self.automaticallyShowBackButton && !self.backButton)
    {
        [self addBackButton:viewController.backButtonTitle target:controller action:@selector(respondToBackButtonPress:)];
    }
}

- (void) addBackgroundGradientView
{
    FLGradientView* gradient = [[FLGradientView alloc] initWithFrame:self.bounds];
    gradient.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    gradient.alpha = 0.6f;
    [self insertSubview:gradient atIndex:0];
    FLRelease(gradient);
}

+ (void) createTopToolbarForViewController:(UIViewController*) viewController
{
    FLDeprecatedButtonbarView* toolbar = FLAutorelease([[FLDeprecatedButtonbarView alloc] initWithFrame:CGRectMake(0,0,viewController.view.frame.size.width, 44)]);
    toolbar.title = viewController.title;
    [toolbar addBackgroundGradientView];
    viewController.topBarView = toolbar;
}

@end

