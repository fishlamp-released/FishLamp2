//
//	GtViewControllerModalShield.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/21/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtModalShield.h"
#import "UIImage+GtColorize.h"
#import "GtAsserts.h"

@implementation GtModalShieldView
@end

@interface GtNavigationBarShieldView : GtModalShieldView {
	UINavigationController* m_navigationController;
}
@property (readwrite, retain, nonatomic) UINavigationController* navigationController;
@end

@implementation GtNavigationBarShieldView

@synthesize navigationController = m_navigationController;

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
		self.backgroundColor = [UIColor blackColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		self.alpha = 0.5;
    }

    return self;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	self.newFrame = m_navigationController.navigationBar.frame;
}

- (void) didMoveToSuperview
{
	if(!self.superview)
	{
		m_navigationController = nil;
	}
}
@end

@implementation GtModalShield

- (void) _shieldNavigationBar:(UIViewController*) controller
{
	if(controller.navigationController)
	{
		m_barShield = [[GtNavigationBarShieldView alloc] initWithFrame:controller.navigationController.navigationBar.frame];
        m_barShield.navigationController = controller.navigationController;
		[controller.navigationController.view addSubview:m_barShield];
	}
}

- (void) _shieldView:(UIView*) superview
{
	m_viewShield = [[GtFingerprintView alloc] initWithFrame:superview.bounds];
	[superview addSubview:m_viewShield];
}

- (void) showShieldInViewController:(UIViewController*) viewController
{
	GtAssertIsNil(m_viewShield);
	GtAssertNil(m_barShield);
	GtAssertNotNil(viewController);

	[self _shieldView:viewController.view];
	[self _shieldNavigationBar:viewController];
}

- (void) hideShield
{
	if(m_barShield)
	{
		[m_barShield removeFromSuperview];
		GtReleaseWithNil(m_barShield);
	}
	if(m_viewShield)
	{
		[m_viewShield removeFromSuperview];
		GtReleaseWithNil(m_viewShield);
	}
}

- (void) dealloc
{
	[self hideShield];
	GtSuperDealloc();
}

- (NSArray*) passThroughViewsForPopover
{
	return m_viewShield ? [NSArray arrayWithObject:m_viewShield] : nil;
}

@end

@implementation GtFingerprintView

- (id) initWithFrame:(CGRect) rect
{
	if((self = [super initWithFrame:rect]))
	{
		self.exclusiveTouch = YES;
		self.multipleTouchEnabled = YES;
        self.backgroundColor = [UIColor blackColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
        self.alpha = 0.7;
    }
	
	return self;
}

- (void)doneRemoving:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[((UIView*) context) removeFromSuperview];
}

- (void) drawAnimationAt:(CGPoint) pt
{
	static UIImage* s_image = nil;
	if(!s_image)
	{
		s_image = [UIImage imageNamed:@"thumbprint-white.png"];
		s_image = [[s_image colorizeImage:[UIColor darkGrayColor] blendMode:kCGBlendModeOverlay] retain];
	}

	UIImageView* view = GtReturnAutoreleased([[UIImageView alloc] initWithImage:s_image]);
	
	view.frame = GtRectSetSizeWithSize( view.frame, s_image.size);
	view.frame = GtRectCenterOnPoint( view.frame, pt);
	
//	CGRect frame = view.frame;
//	  frame.size = m_image.size;
//	frame.origin.x = pt.x - (frame.size.width/2);
//	frame.origin.y = pt.y - (frame.size.height/2);
//	view.frame = GtRectOptimizeForSize(frame);
	
	[self addSubview:view];
	
	static int counter = 0;
	NSString* animationName = [NSString stringWithFormat:@"%d", ++counter];
	
	[UIView beginAnimations:animationName context:view];
	[UIView setAnimationDuration:3.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(doneRemoving:finished:context:)];
	view.alpha = 0.0;
	[UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	[self drawAnimationAt:[touch locationInView:self]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
}

@end

