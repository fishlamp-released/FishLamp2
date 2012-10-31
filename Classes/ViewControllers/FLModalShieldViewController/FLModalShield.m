//
//	FLViewControllerModalShield.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/21/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLModalShield.h"
#import "FLImage+Colorize.h"

@implementation FLModalShieldView
@end

@interface FLNavigationBarShieldView : FLModalShieldView {
	UINavigationController* _navigationController;
}
@property (readwrite, retain, nonatomic) UINavigationController* navigationController;
@end

@implementation FLNavigationBarShieldView

@synthesize navigationController = _navigationController;

- (id) initWithFrame:(FLRect) frame
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
	self.newFrame = _navigationController.navigationBar.frame;
}

- (void) didMoveToSuperview
{
	if(!self.superview)
	{
		_navigationController = nil;
	}
}
@end

@implementation FLModalShield

- (void) _shieldNavigationBar:(UIViewController*) controller {
	if(controller.navigationController) {
		_barShield = [[FLNavigationBarShieldView alloc] initWithFrame:controller.navigationController.navigationBar.frame];
        _barShield.navigationController = controller.navigationController;
		[controller.navigationController.view addSubview:_barShield];
	}
}

- (void) _shieldView:(UIView*) superview {
	_viewShield = [[FLFingerprintView alloc] initWithFrame:superview.bounds];
	[superview addSubview:_viewShield];
}

- (void) showShieldInViewController:(UIViewController*) viewController {
	FLAssertIsNil_(_viewShield);
	FLAssertIsNil_(_barShield);
	FLAssertIsNotNil_(viewController);

	[self _shieldView:viewController.view];
	[self _shieldNavigationBar:viewController];
}

- (void) hideShield {
	if(_barShield) {
		[_barShield removeFromSuperview];
		FLReleaseWithNil_(_barShield);
	}
	if(_viewShield) {
		[_viewShield removeFromSuperview];
		FLReleaseWithNil_(_viewShield);
	}
}

- (void) dealloc {
	[self hideShield];
	mrc_super_dealloc_();
}

- (NSArray*) passThroughViewsForPopover {
	return _viewShield ? [NSArray arrayWithObject:_viewShield] : nil;
}

@end

@implementation FLFingerprintView

- (id) initWithFrame:(FLRect) rect {
	if((self = [super initWithFrame:rect])) {
		self.exclusiveTouch = YES;
		self.multipleTouchEnabled = YES;
        self.backgroundColor = [UIColor blackColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
        self.alpha = 0.7;
    }
	
	return self;
}

- (void)doneRemoving:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	UIView* view = autorelease_(bridge_(UIView*, context));
    [view removeFromSuperview];
}

- (void) drawAnimationAt:(FLPoint) pt {
	static UIImage* s_image = nil;
	if(!s_image) {
		s_image = [UIImage imageNamed:@"thumbprint-white.png"];
        FLAssertIsNotNil_(s_image);
        
        s_image = [s_image colorizeImage:[UIColor darkGrayColor] blendMode:kCGBlendModeOverlay];
        mrc_retain_(s_image);
	}

	UIImageView* view = autorelease_([[UIImageView alloc] initWithImage:s_image]);
	
	view.frame = FLRectSetSizeWithSize( view.frame, s_image.size);
	view.frame = FLRectCenterOnPoint( view.frame, pt);
	
//	FLRect frame = view.frame;
//	  frame.size = _image.size;
//	frame.origin.x = pt.x - (frame.size.width/2);
//	frame.origin.y = pt.y - (frame.size.height/2);
//	view.frame = FLRectOptimizeForSize(frame);
	
	[self addSubview:view];
	
	static int counter = 0;
	NSString* animationName = [NSString stringWithFormat:@"%d", ++counter];
	
	[UIView beginAnimations:animationName context:(void*) view];
	[UIView setAnimationDuration:3.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(doneRemoving:finished:context:)];
	view.alpha = 0.0;
	[UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch* touch = [touches anyObject];
	[self drawAnimationAt:[touch locationInView:self]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event  {	
}

@end

