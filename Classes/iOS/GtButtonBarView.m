//
//	GtButtonbarView.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/19/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtButtonbarView.h"
#import "GtNavigationControllerViewController.h"
#import "GtGradientButton.h"
#import "UIImage+GtColorize.h"

#define kResizableView 1
#define kFadeAnimationDuration 0.3f

typedef enum {
 GtButtonBarViewAnimationStateNone,
 GtButtonBarViewAnimationStateAnimatingShow,
 GtButtonBarViewAnimationStateAnimatingHide 
} GtButtonBarViewAnimationState;


@interface GtButtonbarViewContainer : NSObject {
@private
	NSString* m_key;
	UIView* m_view;
	GtButtonBarViewAnimationState m_animationState;
}
@property (readwrite, assign, nonatomic) GtButtonBarViewAnimationState animationState;
@property (readwrite, retain, nonatomic) UIView* view;
@property (readwrite, retain, nonatomic) NSString* key;
- (id) initWithView:(UIView*) view key:(NSString*) key;
+ (GtButtonbarViewContainer*) buttonbarViewContainer:(UIView*) view key:(NSString*) key;
@end

@implementation GtButtonbarViewContainer

@synthesize view = m_view;
@synthesize key = m_key;
@synthesize animationState = m_animationState;

#if 0 
//DEBUG
- (void) setAnimationState:(GtButtonBarViewAnimationState) state
{
	m_animationState = state;
	
	switch(m_animationState)
	{
		case GtButtonBarViewAnimationStateNone: GtLog(@"Set animation state to NONE"); break;
		case GtButtonBarViewAnimationStateAnimatingShow: GtLog(@"Set animation state to SHOW"); break;
		case GtButtonBarViewAnimationStateAnimatingHide: GtLog(@"Set animation state to HIDE"); break;
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
+ (GtButtonbarViewContainer*) buttonbarViewContainer:(UIView*) view key:(NSString*) key
{
	return GtReturnAutoreleased([[GtButtonbarViewContainer alloc] initWithView:view key:key]);
}

- (void) dealloc
{
	GtRelease(m_view);
	GtRelease(m_key);
	GtSuperDealloc();
}

@end


@interface GtButtonbarView ()
- (void) updateLayout:(BOOL) animated;
@end

@implementation GtButtonbarView
 
@synthesize leftIndent = m_leftIndent;
@synthesize titleLabel = m_label;

GtSynthesizeStructProperty(isInitialized, setIsInitialized, BOOL, m_navBarFlags);

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
	GtRelease(m_leftViews);
	GtRelease(m_rightViews);
	GtRelease(m_label);
	GtSuperDealloc();
}

- (CGRect) rectForButtonWithKey:(NSString*) key forDisplayInView:(UIView*) view
{
	UIView* ourBarView = [self viewForKey:key];
	return ourBarView ? [view convertRect:ourBarView.frame fromView:self] : CGRectZero;
}

- (void) disableAllButtons
{
	for(id view in m_leftViews)
	{
		if([view respondsToSelector:@selector(setEnabled:)])
		{
			[view setEnabled:NO];
		}
	}
	for(id view in m_rightViews)
	{
		if([view respondsToSelector:@selector(setEnabled:)])
		{
			[view setEnabled:NO];
		}
	}
}

- (GtButtonbarViewContainer*) _viewContainerForKey:(NSString*) key array:(NSArray*) array
{
	for(GtButtonbarViewContainer* viewContainer in array)
	{
		if(GtStringsAreEqual(viewContainer.key, key))
		{
			return viewContainer;
		}
	}
	
	return nil;
}

- (GtButtonbarViewContainer*) _viewContainerForKey:(NSString*) key
{
	GtButtonbarViewContainer* viewContainer = [self _viewContainerForKey:key array:m_leftViews];
	return viewContainer ? viewContainer : [self _viewContainerForKey:key array:m_rightViews];
}

- (void) setViewHidden:(BOOL) hidden forKey:(NSString*) key animated:(BOOL) animated
{
	GtButtonbarViewContainer* container = [self _viewContainerForKey:key];
	if(container && container.view.hidden != hidden)
	{
		if(animated)
		{
			container.animationState = hidden ? GtButtonBarViewAnimationStateAnimatingHide : GtButtonBarViewAnimationStateAnimatingShow;
			[container.view setHiddenWithFade:hidden duration:kFadeAnimationDuration finishedBlock:^(UIView* blockView) 
				{ container.animationState = GtButtonBarViewAnimationStateNone; }];
			[self updateLayout:YES];
		}
		else
		{
			container.animationState = GtButtonBarViewAnimationStateNone;
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
	return m_label ? m_label.text : @"";
}

- (void) setTitle:(NSString*) title
{
	if(!m_label)
	{
		m_label = [[UILabel alloc] initWithFrame:self.bounds];
		m_label.autoresizingMask = UIViewAutoresizingNone;
		if(DeviceIsPad())
		{
			m_label.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
		}
		else
		{
			m_label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
		}
		m_label.textColor = [UIColor whiteColor];
		m_label.shadowColor = [UIColor darkTextColor];
		m_label.shadowOffset	= CGSizeMake (0.0, 0.0);
		m_label.lineBreakMode = UILineBreakModeTailTruncation;
		m_label.backgroundColor = [UIColor clearColor];
		m_label.textAlignment = UITextAlignmentCenter;
		[self addSubview:m_label];
	}

	if(GtStringIsEmpty(title))
	{
		m_label.text = @"";
	}
	else
	{
		m_label.text = title;
	}

	[self setNeedsLayout];
}

- (NSString*) subtitle
{
	return m_subtitleLabel ? m_subtitleLabel.text : nil;
}

- (void) setSubtitle:(NSString*) subtitle
{
	if(!GtStringsAreEqual(subtitle, self.subtitle))
	{
		if(GtStringIsNotEmpty(subtitle))
		{
			if(!m_subtitleLabel)
			{
				m_subtitleLabel = [[UILabel alloc] initWithFrame:self.bounds];
				m_subtitleLabel.autoresizingMask = UIViewAutoresizingNone;
				m_subtitleLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
				m_subtitleLabel.textColor = [UIColor grayColor];
				m_subtitleLabel.shadowColor = [UIColor darkTextColor];
				m_subtitleLabel.shadowOffset	= CGSizeMake (0.0, 0.0);
				m_subtitleLabel.lineBreakMode = UILineBreakModeTailTruncation;
				m_subtitleLabel.backgroundColor = [UIColor clearColor];
				m_subtitleLabel.textAlignment = UITextAlignmentCenter;
				[self addSubview:m_subtitleLabel];
			}
		
			m_subtitleLabel.text = subtitle;
			[self setNeedsLayout];
		}
		else if(m_subtitleLabel)
		{
			m_subtitleLabel.text = @"";
			[self setNeedsLayout];
		}
	}
}

- (void) setSubtitleWithItemCount:(NSUInteger) itemCount itemName:(NSString*) itemName
{
	if(itemCount == 1)
	{
		self.subtitle = [NSString stringWithFormat:@"1 %@", itemName];
	}	
	else
	{
		self.subtitle = [NSString stringWithFormat:@"%d %@s", itemCount, itemName];
	}
}

- (UIView*) viewForKey:(NSString*) key
{
	GtButtonbarViewContainer* viewContainer = [self _viewContainerForKey:key];
	return viewContainer ? viewContainer.view : nil;
}

- (BOOL) _setView:(UIView*) view forKey:(NSString*)key animated:(BOOL) animated array:(NSMutableArray*) array
{
	for(NSUInteger i = 0; i < array.count; i++)
	{
		GtButtonbarViewContainer* viewContainer = [array objectAtIndex:i];
		if(GtStringsAreEqual(viewContainer.key, key) && viewContainer.view != view)
		{
			[viewContainer.view removeFromSuperview];
			viewContainer.view = view;
			[self addSubview:view];

			if(animated)
			{
				viewContainer.animationState = GtButtonBarViewAnimationStateAnimatingShow;
				[view animateOntoScreen:GtViewAnimationTypeFade duration:kFadeAnimationDuration finishedBlock:^(UIView* blockView) 
					{ viewContainer.animationState = GtButtonBarViewAnimationStateNone; }];
				[self updateLayout:YES];
			}
			else
			{
				viewContainer.animationState = GtButtonBarViewAnimationStateNone;
				[self setNeedsLayout];
			}
			
			return YES;
		}
	}
	return NO;
}

- (void) setView:(UIView*) view forKey:(NSString*)key animated:(BOOL) animated
{
	if(![self _setView:view forKey:key animated:animated array:m_leftViews])
	{
		[self _setView:view forKey:key animated:animated array:m_rightViews];
	}
}

- (void) removeViewForKey:(NSString*) key animated:(BOOL) animated
{
	GtButtonbarViewContainer* viewContainer = [self _viewContainerForKey:key array:m_leftViews];
	if(viewContainer)
	{
		[m_leftViews removeObject:GtReturnAutoreleased(GtRetain(viewContainer))];
	}
	else
	{
		viewContainer = [self _viewContainerForKey:key array:m_rightViews];
		if(viewContainer)
		{
			[m_rightViews removeObject:GtReturnAutoreleased(GtRetain(viewContainer))];
		}
	}
	
	if(viewContainer)
	{
		if(animated)
		{
			viewContainer.animationState = GtButtonBarViewAnimationStateAnimatingHide;
			[viewContainer.view removeFromSuperviewWithAnimationType:GtViewAnimationTypeFade duration:kFadeAnimationDuration finishedBlock:^(UIView* finishBlock) 
				{ viewContainer.animationState = GtButtonBarViewAnimationStateNone; } ];
			[self updateLayout:YES];
		}
		else
		{
			viewContainer.animationState = GtButtonBarViewAnimationStateNone; 
			[viewContainer.view removeFromSuperview];
			[self setNeedsLayout];
		}
	}
}

+ (UIButton*) createImageButtonByName:(NSString*) imageName 
    target:(id) target 
    action:(SEL) action
{
    UIImage* image = [UIImage whiteImageNamed:imageName];
    GtAssertNotNil(image);
    
    GtAssertNotNil(target);
    GtAssertNotNil(action);

	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0,0, image.size.width, image.size.height);
	[button setImage:image forState:UIControlStateNormal];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	button.tag = kResizableView;
	button.enabled = YES;
	button.showsTouchWhenHighlighted = YES;
	return button;
}

+ (UIButton*) createImageButton:(UIImage*) image target:(id) target action:(SEL) action {
    GtAssertNotNil(target);
    GtAssertNotNil(action);

	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0,0, image.size.width, image.size.height);
	[button setImage:image forState:UIControlStateNormal];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	button.tag = kResizableView;
	button.enabled = YES;
	button.showsTouchWhenHighlighted = YES;
	return button;
}

+ (UIView*) createEmptyItem
{
	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0,0, 22, 22);
	button.enabled = NO;
	button.showsTouchWhenHighlighted = NO;
	return button;
}

- (GtButton*) backButton
{
	return (GtButton*) [self viewForKey:GtButtonbarViewBackButtonKey];
}

- (BOOL) backButtonHidden
{
	return [self viewForKey:GtButtonbarViewBackButtonKey].hidden;
}

- (void) setBackButtonHidden:(BOOL) hidden animated:(BOOL) animated
{
	[self setViewHidden:hidden forKey:GtButtonbarViewBackButtonKey animated:animated];
}

- (void) setBackButtonHidden:(BOOL) hidden
{
	[self setViewHidden:hidden forKey:GtButtonbarViewBackButtonKey animated:NO];
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
		
		GtButtonbarViewContainer* container = [GtButtonbarViewContainer buttonbarViewContainer:view key:key];
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
			container.animationState = GtButtonBarViewAnimationStateAnimatingShow;
			[view animateOntoScreen:GtViewAnimationTypeFade duration:kFadeAnimationDuration finishedBlock:^(UIView* blockView) 
				{ container.animationState = GtButtonBarViewAnimationStateNone; }];
			[self updateLayout:YES];
		}
		else
		{
			container.animationState = GtButtonBarViewAnimationStateNone;
			
			[self setNeedsLayout];
		}
	}
}

- (void) addBackButton:(NSString*) title target:(id) target action:(SEL) action 
{
    GtAssertNil(self.backButton);

	GtBackButton* backButton = [GtBackButton backButton:title target:target action:action];
	backButton.tag = NO;
	[backButton setViewSizeToContentSize];

	if(!m_leftViews)
	{
		m_leftViews = [[NSMutableArray alloc] init];
	}
	
	[self _addView:backButton forKey:GtButtonbarViewBackButtonKey array:m_leftViews appendView:NO animated:NO];
}

- (void) addButtonToRightSide:(GtButton*) button forKey:(NSString*) key animated:(BOOL) animated
{
	[button setViewSizeToContentSize];
	button.tag = NO;
	[self addViewToRightSide:button forKey:key animated:animated];
}

- (void) addButtonToLeftSide:(GtButton*) button forKey:(NSString*) key animated:(BOOL) animated
{
	button.tag = NO;
	[button setViewSizeToContentSize];
	[self addViewToLeftSide:button forKey:key animated:animated];
}

- (void) addViewToRightSide:(UIView*) view forKey:(NSString*) key animated:(BOOL) animated
{
	if(!m_rightViews)
	{
		m_rightViews = [[NSMutableArray alloc] init];
	}
	[self _addView:view forKey:key array:m_rightViews appendView:YES animated:animated];
}

- (void) addViewToLeftSide:(UIView*) view forKey:(NSString*) key animated:(BOOL) animated
{
	if(!m_leftViews)
	{
		m_leftViews = [[NSMutableArray alloc] init];
	}
	
	[self _addView:view forKey:key array:m_leftViews appendView:YES animated:animated];
}

//- (void) addImageButtonToRightSide:(UIImage*) image target:(id) target action:(SEL) action forKey:(NSString*) key animated:(BOOL) animated
//{
//	UIButton* button = [GtButtonbarView createImageButton:image target:target action:action];
//	button.tag = kResizableView;
//	[self addViewToRightSide:button forKey:key animated:animated];
//}
//
//- (void) addImageButtonToLeftSide:(UIImage*) image target:(id) target action:(SEL) action forKey:(NSString*) key animated:(BOOL) animated
//{
//	UIButton* button = [GtButtonbarView createImageButton:image target:target action:action];
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
//	  GtLog(@"spacing %f", self.superview.bounds.origin.x - self.frame.origin.x);
	GtButton* backButton = self.backButton;

	NSUInteger left = backButton && !backButton.hidden ? 0.0 : s_leftBuffer; // ((self.frame.origin.x - self.superview.bounds.origin.x) > s_leftBuffer) ? s_buffer + 6.0 : s_rightSideMargin;
	if(m_leftViews)
	{
		for(GtButtonbarViewContainer* viewContainer in m_leftViews)
		{	
			UIView* leftView = viewContainer.view;
//			  leftView.backgroundColor = [UIColor greenColor];
			if(!leftView.hidden && viewContainer.animationState != GtButtonBarViewAnimationStateAnimatingHide)
			{
				if(leftView.tag == kResizableView)
				{
					if(left != 0)
					{
						left += s_buffer;
					}
				
					CGRect r = GtRectSetSize(leftView.frame, 
							MAX(leftView.frame.size.width, height), 
							MAX(leftView.frame.size.height, height));
						
					r.origin.x = left;
					r = GtRectCenterRectInRectVertically(self.bounds, r);
					
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
					leftView.frameOptimizedForSize = GtRectCenterRectInRect(r, leftView.frame);
					
					left = GtRectGetRight(leftView.frame);
				}

				
				lastLeftView = leftView;
			}
		}
	}
	
	NSUInteger right = GtRectGetRight(self.bounds);
	BOOL firstRightView = YES;
	if(m_rightViews)
	{
		for(GtButtonbarViewContainer* viewContainer in m_rightViews.reverseObjectEnumerator)
		{
			UIView* rightView = viewContainer.view;
			if(!rightView.hidden && viewContainer.animationState != GtButtonBarViewAnimationStateAnimatingHide)
			{
				CGRect layoutRect = CGRectMake(0,0,MAX(s_minWidth, rightView.frame.size.width), height);
				if(rightView.tag == kResizableView)
				{
					CGRect r = GtRectSetSize(rightView.frame, 
								MAX(rightView.frame.size.width, height),
								MAX(rightView.frame.size.height, height));
					
					layoutRect.size.width = MAX(s_minWidth, r.size.width);
					layoutRect.origin.x = (right - layoutRect.size.width - (firstRightView ? 0: s_buffer)); 
					
					r = GtRectCenterRectInRectVertically(layoutRect, r);
					r.origin.x = GtRectGetRight(layoutRect) - r.size.width;
					
					rightView.frameOptimizedForSize = r;
					right = layoutRect.origin.x;
				}
				else
				{
					[rightView setViewSizeToContentSize];
					layoutRect.origin.x = (right - layoutRect.size.width - s_leftBuffer);
					rightView.frameOptimizedForSize = GtRectCenterRectInRect(layoutRect, rightView.frame);
					right = layoutRect.origin.x;
				}
			
				lastRightView = rightView; 
			}
			
			firstRightView = NO;
		}	 
	}
	
	// center the label
	
	left = (lastLeftView ? GtRectGetRight(lastLeftView.frame) : 0.0) + 4.0;
	right = lastRightView ? lastRightView.frame.origin.x : GtRectGetRight(self.bounds);
	
	CGFloat maxSize = right - left;
	   
	CGRect titleRect = CGRectZero;
	CGRect subtitleRect = CGRectZero;
		
	titleRect.size = [m_label sizeThatFitsText];
	titleRect = GtRectCenterRectInRect(self.bounds, GtRectSetWidth(titleRect, MIN(maxSize, titleRect.size.width)));
	
	if(m_subtitleLabel && GtStringIsNotEmpty(m_subtitleLabel.text))
	{
		titleRect = GtRectMoveVertically(titleRect, -6);

		subtitleRect.size = [m_subtitleLabel sizeThatFitsText];
		subtitleRect = GtRectCenterRectInRect(self.bounds, subtitleRect);
		subtitleRect.origin.y = GtRectGetBottom(titleRect) - 2.0f;
	}
	
//	  CGPoint centerPoint = GtRectGetCenter(self.bounds); //[self convertPoint:GtRectGetCenter(self.superview.bounds) fromView:self.superview];
//	  frame = GtRectGrowRectToOptimizedSizeIfNeeded(GtRectCenterOnPoint(frame, centerPoint));
	
	CGFloat insetLeft = 0.0;
	CGFloat insetRight = 0.0;
	if(titleRect.origin.x < left)
	{
		insetLeft = left - titleRect.origin.x;
	}
	if(GtRectGetRight(titleRect) > right)
	{
		insetRight = GtRectGetRight(titleRect) - right;
	}
	
	if(insetLeft != 0.0 || insetRight != 0.0)
	{
		if(insetLeft > insetRight)
		{
			titleRect = GtRectMoveHorizontally(titleRect, insetLeft);
			subtitleRect = GtRectMoveHorizontally(subtitleRect, insetLeft);
		}
		else
		{
			titleRect = GtRectMoveHorizontally(titleRect, -insetRight);
			subtitleRect = GtRectMoveHorizontally(subtitleRect, -insetRight);
		}
	}
	m_label.frameOptimizedForSize = titleRect;
	if(m_subtitleLabel && GtStringIsNotEmpty(m_subtitleLabel.text))
	{
		m_subtitleLabel.frameOptimizedForSize = subtitleRect;
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

@end
