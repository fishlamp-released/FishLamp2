//
//	FLFloatingViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/14/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLFloatingViewController.h"
#import "FLNavigationControllerViewController.h"
#import "FLViewController.h"
#import "FLBackgroundTaskMgr.h"
#import "FLApplication.h"
#import "FLFloatingViewController.h"
#import "FLKeyboardManager.h"
#import "FLViewController.h"

#define kAnimationDuration 0.1

NSString *const FLPopoverViewWasResized = @"FLPopoverViewWasResized";

@interface FLFloatingViewController ()
- (BOOL) isRelatedToController:(FLFloatingViewController*) controller;
- (void) resizeToContentSizeAnimated:(BOOL)animated;
@property (readwrite, retain, nonatomic) UIViewController* contentViewController;
@end

@interface FLFloatingViewEventReceiver : NSObject<FLApplicationEventInterceptor> {
@private
	NSMutableArray* _popupStack;
	BOOL _propagateEvents;
	BOOL _willDismiss;
}

//@property (readwrite, assign, nonatomic) BOOL presentingModalViewController;
@property (readonly, retain, nonatomic) NSArray* viewControllers;

- (void) addPopupViewController:(FLFloatingViewController*) controller;
- (void) removePopupViewController:(FLFloatingViewController*) controller;

FLSingletonProperty(FLFloatingViewEventReceiver);
@end

@implementation FLFloatingViewEventReceiver
@synthesize viewControllers = _popupStack;

FLSynthesizeSingleton(FLFloatingViewEventReceiver);

- (id) init
{
	if((self = [super init]))
	{
		_popupStack = [[NSMutableArray alloc] init];
	}

	return self;
}

- (void) addPopupViewController:(FLFloatingViewController*) controller
{
	[_popupStack addObject:controller];
}

- (void) removePopupViewController:(FLFloatingViewController*) controller
{
	[_popupStack removeObject:controller];
}

- (FLFloatingViewController*) controllerFromView:(FLFloatingView*) view
{
    for(FLFloatingViewController* controller in _popupStack)
    {
        if(controller.view == view)
        {   
            return controller;
        }   
    }
    return nil;
}

- (BOOL) floatingViewControllerIsInModalController:(FLFloatingViewController*) controller
{
	if([FLViewController isPresentingModalViewController])
	{
		UIViewController* modalViewController = [FLViewController presentingModalViewController].modalViewController;
	
		return [controller.view isDescendantOfView:modalViewController.view];
	}
	
	return NO;
}

- (BOOL) didInterceptEvent:(UIEvent*) event
{
	if(_popupStack.count == 0)
	{
		return NO;
	}
	
	if(event.type == UIEventTypeTouches)
	{
		NSSet* touches = [event allTouches];
		UITouch* touch = [touches anyObject];
		switch(touch.phase)
		{
			case UITouchPhaseBegan:
			{
                FLFloatingViewController* topController = _popupStack.lastObject;
				_willDismiss = topController.presentationBehavior.canAutoDismissDontUseThis &&
                                !topController.contentViewIsModal;

//               !topController.isModal && !topController.contentViewIsModal;
				_propagateEvents = NO;
			
			// check for touch in hover view heirarchy
				UIView* touchedView = touch.view;
				UIView* view = touchedView;
				while(view)
				{
                    // if hit modal shield, propgate and return
					if([view isKindOfClass:[FLModalShieldView class]])
					{
						_willDismiss = NO;
						_propagateEvents = YES;
						return !_propagateEvents;
					}
				
					if([view isKindOfClass:[FLFloatingView class]])
					{
						if(view == topController.view)
						{
							_willDismiss = NO;
							_propagateEvents = YES;
						}
                        else
                        {
                            // don't dismiss if the popups are related
                            FLFloatingViewController* controller = [self controllerFromView:(FLFloatingView*) view];
                            if(controller && [controller isRelatedToController:topController])
                            {
                                _willDismiss = NO;
                                _propagateEvents = YES;
                            }
							
							
                        }
                        
						return !_propagateEvents;
					}
					
					view = view.superview;
				}
				
			// check for touch in modal controller above us.
				if(	[FLViewController isPresentingModalViewController] &&
					![self floatingViewControllerIsInModalController:topController])
				{
					_willDismiss = NO;
					_propagateEvents = YES;
					return !_propagateEvents;
				}
				
				
                // we're going to iterate through the top view's siblings here and
                // look for a reason not to dismiss 
				NSArray* siblings = topController.view.superview.subviews;
				for(UIView* sibling in [siblings reverseObjectEnumerator])
				{
                    // if the sibling is our top view, then stop looking for a reason not to dismiss
                    // because that means the touch was in a view below us, and we should continue
                    // dismissing.
					if(sibling == topController.view)  
					{	
						break;
					}
					
					if(touchedView == sibling || [sibling hitTest:[touch locationInView:sibling] withEvent:event] == touchedView)
					{
                        // if we get here, this means the touched view is above the top popup view in the superviews stack (our list of siblings), and we don't want to be dismissed.
                        // basically - this means there's a view above us that is supposed to receive the events and supposed to NOT
                        // dismiss the top popup.
						_propagateEvents = YES;
						_willDismiss = NO;
						break;
					}
				}
				
			}
			break;
 
			case UITouchPhaseCancelled:
			break;
			
			case UITouchPhaseMoved:
			case UITouchPhaseStationary:
			break;
			
			case UITouchPhaseEnded:
				if(_willDismiss)
				{
                    FLFloatingViewController* pop = _popupStack.lastObject;
                
                    if(pop.parentFloatingViewController)
                    {
                        [pop.parentFloatingViewController hideViewController:YES];
                    }
                    else
                    {
                        [pop hideViewController:YES];
                    }
				}
			break;
		
		}
	}	
	
	return !_propagateEvents;
}

- (void) dealloc
{
	FLRelease(_popupStack);
	[[FLApplication sharedApplication] removeEventInterceptor:self];
	FLSuperDealloc();
}

@end 

@interface FLFloatingViewController ()
@property (readwrite, assign, nonatomic) FLFloatingViewController* parentFloatingViewController;
@end

@implementation FLFloatingViewController

@synthesize contentViewSize = _contentViewSize;
@synthesize wasDismissedCallback = _wasDismissedCallback;
@synthesize contentViewController = _contentViewController;
@synthesize childFloatingViewController = _childPopover;
@synthesize parentFloatingViewController = _parentPopover;
@synthesize positionProvider = _positionProvider;

FLSynthesizeStructProperty(contentViewIsModal, setContentViewIsModal, BOOL, _state);

- (FLFloatingView*) floatingView
{
    return (FLFloatingView*) self.view;
}

- (BOOL) isRelatedToController:(FLFloatingViewController*) controller
{
    if(_childPopover == controller || _parentPopover == controller)
    {
        return YES;
    }
    
    return NO;
}

- (void) setChildFloatingViewController:(FLFloatingViewController *)childFloatingViewController
{
    FLSetObjectWithRetain(_childPopover, childFloatingViewController);
    if(childFloatingViewController.parentFloatingViewController != self)
    {
        childFloatingViewController.parentFloatingViewController = self;
    }
}

- (void) setParentFloatingViewController:(FLFloatingViewController *)parentFloatingViewController
{
    _parentPopover = parentFloatingViewController;
    if(_parentPopover.childFloatingViewController != self)
    {
        _parentPopover.childFloatingViewController = self;
    }
}

+ (void) initialize
{
	static BOOL s_init = NO;
	if(!s_init)
	{	
		s_init = YES;
		[[FLApplication sharedApplication] addEventInterceptor:[FLFloatingViewEventReceiver instance]];
	}
}

- (id) init
{
    self = [super init];
    if(self)
    {
   		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) 
				name: FLKeyboardDidShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) 
				name: FLKeyboardDidHideNotification object:nil];
    }

    return self;
}

- (void) keyboardDidShow:(id) sender
{
	_state.adjustingForKeyboard = YES;
	[self resizeToContentSizeAnimated:YES];
}

- (void) keyboardDidHide:(id) sender
{
	_state.adjustingForKeyboard = NO;
	[self resizeToContentSizeAnimated:YES];
}

- (id) initWithArrowDirection:(FLFloatingViewControllerArrowDirection)arrowDirection
         fromPositionProvider:(id) provider
{
	if((self = [super init]))
	{
        _arrowDirection = arrowDirection;
        self.positionProvider = provider;
        [[FLFloatingViewEventReceiver instance] addPopupViewController:self];
        [[FLBackgroundTaskMgr instance] addObserver:self];
    }
	
	return self;
}

- (void) setParentPopover:(FLFloatingViewController*) parent
{
    _parentPopover = parent;
}

- (void) dismissChild
{
    if(_childPopover)
    {
        [_childPopover setParentPopover:nil];
        [_childPopover hideViewController:YES];
        FLReleaseWithNil(_childPopover);
    }
}

- (void) setChildPopoverViewController:(FLFloatingViewController*) child
{
    if(child != _childPopover)
    {
        if(_childPopover)
        {
            [self dismissChild];
        }
        FLSetObjectWithRetain(_childPopover, child);
        [_childPopover setParentPopover:self];
    }
}   

- (void) dealloc
{
	[[FLFloatingViewEventReceiver instance] removePopupViewController:self];
    [[FLBackgroundTaskMgr instance] removeObserver:self];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    FLRelease(_childPopover);
	FLRelease(_contentViewController);
	FLSuperDealloc();
}

- (BOOL) backgroundTaskMgrCanBeginBackgroundTasks:(FLBackgroundTaskMgr*) mgr
{
// TODO: this makes no sense. This contained view needs to decide.... right?
    return self.presentationBehavior.canAutoDismissDontUseThis;
}

- (void)hideViewController:(BOOL)animated
{
	FLAutorelease(FLReturnRetain(self));
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[[FLFloatingViewEventReceiver instance] removePopupViewController:self];
    [[FLBackgroundTaskMgr instance] removeObserver:self];

    if(_childPopover)
    {
        [self dismissChild];
    }
   
    [super hideViewController:animated];

	FLInvokeCallback(_wasDismissedCallback, self);
}

- (UINavigationController*) navigationController
{
	if([self.contentViewController isKindOfClass:[FLNavigationControllerViewController class]])
	{
		return ((FLNavigationControllerViewController*) self.contentViewController).rootNavigationController;
	}
	
	return nil;
}

- (void) loadView
{
    self.view = FLAutorelease([[FLFloatingView alloc] initWithFrame:CGRectMake(0,0,200,200)]);
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    self.floatingView.contentView = self.contentViewController.view;
    self.floatingView.arrowDirection = _arrowDirection;
    self.floatingView.contentView = self.contentViewController.view;
}

- (void) setContentViewController:(UIViewController*) viewController
{
    if(_contentViewController)
    {
        if([_contentViewController isViewLoaded])
        {
            [_contentViewController.view removeFromSuperview];
        }
    }
    
    FLSetObjectWithRetain(_contentViewController, viewController);
    [self addChildViewController:_contentViewController];

    if(self.isViewLoaded)
    {
        self.floatingView.contentView = _contentViewController.view;
        [self resizeToContentSizeAnimated:NO];
    }
}

- (void) updateViewSizeAndPosition:(CGRect) inBounds
{
    [self resizeToContentSizeAnimated:NO];
}

#define kLayoutPadding 5.0f

- (CGRect) _checkFrame:(CGRect) frame inFrame:(CGRect) superFrame
{
    if(frame.origin.x < kLayoutPadding)
    {
        frame.origin.x = kLayoutPadding;
    }
    else if(FLRectGetRight(frame) > (FLRectGetRight(superFrame) - kLayoutPadding))
    {
        frame.origin.x = FLRectGetRight(superFrame) - kLayoutPadding - frame.size.width;
    }
    
    if(frame.origin.y < superFrame.origin.y)
    {
        frame.origin.y = superFrame.origin.y + 4;
    }

    return frame;
}

- (void) _setFramePosition:(CGRect) frame animated:(BOOL) animated
{
    FLFloatingView* view = self.floatingView;
    UIView* containerView = view.containerView;

	if(view.superview)
	{
		CGRect prevFrame = view.frame;
	
		CGRect maxVisibleRect = [self maxVisibleRect:_state.adjustingForKeyboard];
		
		if(frame.size.height > maxVisibleRect.size.height)
		{
			CGFloat delta = frame.size.height - maxVisibleRect.size.height;
			delta += 5.0f;
			frame.size.height -= delta;
			containerView.newFrame = FLRectAddHeight(containerView.frame, -delta);
		}
		if(frame.size.width > maxVisibleRect.size.width)
		{
			CGFloat delta = frame.size.width - maxVisibleRect.size.width;
			delta += 5.0f;
			frame.size.width -= delta;
			containerView.newFrame = FLRectAddWidth(containerView.frame, -delta);
		}
	
		CGRect keyboardRect = CGRectZero; 
		if(_state.adjustingForKeyboard)
		{
			keyboardRect = FLRectJustifyRectInRectBottom(view.superview.bounds, [[FLKeyboardManager instance] keyboardRectForView:view.superview]);
		}
        
        CGRect superFrame = [self maxVisibleRect:NO];
        
        if(!_positionProvider || _arrowDirection == FLFloatingViewArrowDirectionNone)
		{
            frame = FLRectCenterRectInRectHorizontally(superFrame, FLRectPositionRectInRectVerticallyTopThird(superFrame, frame));
            
            if(frame.origin.y < superFrame.origin.y)
            {
                frame = FLRectCenterRectInRectVertically(superFrame, frame);
            }

            if(_state.adjustingForKeyboard && CGRectIntersectsRect(frame, keyboardRect))
			{
				frame.origin.y = keyboardRect.origin.y - frame.size.height - 5.0f;
			}
            
            view.frameOptimizedForSize = [self _checkFrame:frame inFrame:superFrame];
            view.targetRect = CGRectZero;
        }
		else
		{
			id<FLFloatingViewTargetProvider> provider = (id<FLFloatingViewTargetProvider>) _positionProvider;

			FLAssertWithComment([provider respondsToSelector:@selector(frame)], @"must implement frame");
			FLAssertWithComment([provider respondsToSelector:@selector(superview)], @"must implement frame");
			
			CGRect fromFrame = [view.superview convertRect:provider.floatingViewTargetFrame fromView:provider.floatingViewTargetView];
		
			switch(_arrowDirection)
			{
				case FLFloatingViewArrowDirectionUp:
					frame.origin.y = FLRectGetBottom(fromFrame);
					frame.origin.x = FLRectGetCenter(fromFrame).x - (frame.size.width/2.0);
				break;
				
                case FLFloatingViewArrowDirectionDown:
					if(_state.adjustingForKeyboard)
					{
						frame.origin.y = keyboardRect.origin.y - frame.size.height - 5.0f;
					}
					else
					{
						frame.origin.y = fromFrame.origin.y - frame.size.height;
					}
					
					frame.origin.x = FLRectGetCenter(fromFrame).x - (frame.size.width/2.0);
				break;
                
				case FLFloatingViewArrowDirectionLeft:
                    frame.origin.x = FLRectGetRight(fromFrame);
                    frame.origin.y = FLRectGetCenter(fromFrame).y - (frame.size.height/2.0);
                break;
                
				case FLFloatingViewArrowDirectionRight:
                    frame.origin.x = fromFrame.origin.x - frame.size.width;
                    frame.origin.y = FLRectGetCenter(fromFrame).y - (frame.size.height/2.0);
                break;
                
				case FLFloatingViewArrowDirectionNone:
				// no-op this will get hit in the if statement above.
                break;
			}
			
            view.frameOptimizedForSize = [self _checkFrame:frame inFrame:superFrame];
            view.targetRect = [view.superview convertRect:fromFrame toView:view];

		} 

        [view setNeedsLayout];
//            [view layoutIfNeeded];
		
		if(!CGRectEqualToRect(prevFrame, view.frame))
		{
			[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:FLPopoverViewWasResized object:nil
				userInfo:[NSDictionary dictionaryWithObject:self forKey:FLPopoverViewWasResized]]];
		}
	}
	
}

- (void) resizeToContentSizeAnimated:(BOOL)animated
{
    FLFloatingView* view = self.floatingView;

    CGSize size = self.contentViewSize;

	CGRect myFrame = FLRectSetSize(view.frame, 
		size.width + (view.frameWidth*2), 
		size.height + (view.frameWidth*2));

	CGRect containerViewFrame = CGRectMake(view.frameWidth, view.frameWidth, size.width, size.height);
    	
    CGFloat arrowWidth = view.arrowWidth;
    
	switch(_arrowDirection)
	{
		case FLFloatingViewArrowDirectionUp:
			myFrame.size.height += arrowWidth + 2;
			containerViewFrame.origin.y += arrowWidth;
		break;
		case FLFloatingViewArrowDirectionDown:
			myFrame.size.height += arrowWidth + 2;
		break;
		case FLFloatingViewArrowDirectionLeft:
            myFrame.size.width += arrowWidth + 2;
            containerViewFrame.origin.x += arrowWidth;
		break;
		case FLFloatingViewArrowDirectionRight:
            myFrame.size.width += arrowWidth+ 2;
		break;

		case FLFloatingViewArrowDirectionNone:
		break;
	}
	
	view.containerView.frame = containerViewFrame;
	
	[self _setFramePosition:myFrame animated:animated];
	
	[view setNeedsLayout];
}

- (void) setContentViewSize:(CGSize)size animated:(BOOL)animated
{
    FLAssertWithComment(!FLSizeIsEmpty(size), @"empty size");
    FLAssertWithComment(size.height > 0, @"invalid height");
    FLAssertWithComment(size.width > 0, @"invalid width");

    _contentViewSize = size;
	[self resizeToContentSizeAnimated:animated];
}

- (void) setContentViewSize:(CGSize) size
{
	[self setContentViewSize:size animated:YES];
}

- (FLFloatingViewController*) floatingViewController
{
    return self;
}

@end

@implementation UIView (FLFloatingViewTargetProvider)
- (CGRect) floatingViewTargetFrame
{	
	return self.bounds;
}
- (UIView*) floatingViewTargetView
{
	return self;
}
@end

@implementation FLWidget (FLFloatingViewTargetProvider)
- (CGRect) floatingViewTargetFrame
{	
	return self.frame;
}
- (UIView*) floatingViewTargetView
{
	return self.view;
}
@end

@implementation UIViewController (FLFloatingViewController)

FLSynthesizeAssociatedProperty(FLAssociationPolicyRetainNonatomic, contentSizeForViewInFloatingViewValue, setContentSizeForViewInFloatingViewValue, NSValue*)

- (FLFloatingViewController*) floatingViewController {
    return [[self parentViewController] floatingViewController];
}

- (CGSize) contentSizeForViewInFloatingView {
    NSValue* value = self.contentSizeForViewInFloatingViewValue;

    return value ? [value FLSizeValue] : CGSizeZero;
}

- (void) setContentSizeForViewInFloatingView:(CGSize) size {
    self.contentSizeForViewInFloatingViewValue = [NSValue valueWithFLSize:size];
}

- (FLFloatingViewController*) presentFloatingViewController:(UIViewController*) controller
                                    permittedArrowDirection:(FLFloatingViewControllerArrowDirection)arrowDirection
                                       fromPositionProvider:(id) provider
                                               withBehavior:(id<FLPresentationBehavior>) behavior
                                              withAnimation:(id<FLViewControllerTransitionAnimation>) animation {
    FLFloatingViewController* floatingViewController = FLAutorelease( [[FLFloatingViewController alloc] initWithArrowDirection:arrowDirection fromPositionProvider:provider]);

    floatingViewController.contentViewController = controller;
    
    if(animation) {
        floatingViewController.transitionAnimation = animation;
    }
    if(behavior) {
        floatingViewController.presentationBehavior = behavior;;
    }
    
    [self showChildViewController:floatingViewController];

    return floatingViewController;
}                        

- (FLFloatingViewController*) presentFloatingViewController:(UIViewController*) controller
                                               withBehavior:(id<FLPresentationBehavior>) behavior
                                              withAnimation:(id<FLViewControllerTransitionAnimation>) animation
{
    return [self presentFloatingViewController:controller 
                       permittedArrowDirection:FLFloatingViewControllerArrowDirectionNone 
                          fromPositionProvider:nil 
                                  withBehavior:behavior 
                                 withAnimation:animation];
}          

- (FLFloatingViewController*) presentFloatingViewController:(UIViewController*) controller
    animated:(BOOL) animated
{
    FLAssertIsImplemented();
    
    return nil;
}
- (FLFloatingViewController*) presentModalFloatingViewController:(UIViewController*) controller
    animated:(BOOL) animated
{
    FLAssertIsImplemented();
    
    return nil;
}
                                            


@end
