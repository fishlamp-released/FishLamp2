//
//	FLPullToRefreshHeaderView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/2/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLPullToRefreshHeaderView.h"
#import "SDKImage+Colorize.h"
#import "FLLabel.h"

typedef enum {
	FLPullToRefreshHeaderViewPulling = 0,
	FLPullToRefreshHeaderViewDormant,
	FLPullToRefreshHeaderViewRefreshing,	
} FLPullToRefreshHeaderViewState;


#define HEIGHT 65.0f

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define BORDER_COLOR [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f

@interface FLPullToRefreshHeaderView (Private)
@property (readwrite, nonatomic, assign) FLPullToRefreshHeaderViewState state;
@end

@implementation FLPullToRefreshHeaderView

@synthesize delegate = _delegate;

//- (void) onSetGradientColorProperties
//{
//	  self.gradientStartColor = [UIColor lightLightGrayColor];
//	  self.gradientEndColor = [UIColor lightGrayColor];
//}

- (void) applyTheme:(FLTheme*) theme {

//	label.backgroundColor = [UIColor clearColor];
//	label.textDescriptor = self.titleDescriptor;

//		_statusLabel.themeAction = @selector(applyThemeToTableViewCellTitleLabel:);
}

- (id)initWithFrame:(CGRect)frame 
{
	if ((self = [super initWithFrame:frame])) 
	{
        self.wantsApplyTheme = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor clearColor];
	
		_backgroundView = [[FLGradientView alloc] initWithFrame:CGRectZero];
		_backgroundView.alpha = 1.0; // 0.6f;
		[self addSubview:_backgroundView];
//		  [_backgroundView setGradientToDarkGray];
	
		_statusLabel = [[FLLabel alloc] initWithFrame:CGRectZero];
		_statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
		_statusLabel.textColor = [UIColor blackColor]; //TEXT_COLOR;
		_statusLabel.shadowColor = [UIColor whiteColor]; //[UIColor colorWithWhite:0.9f alpha:1.0f];
//		_statusLabel.shadowOffset = FLSizeMake(0.0f, 1.0f);
		_statusLabel.backgroundColor = [UIColor clearColor];
		_statusLabel.textAlignment = UITextAlignmentCenter;
		[self addSubview:_statusLabel];
	
		_lastUpdatedDate = [[FLLabel alloc] initWithFrame:CGRectZero];
		_lastUpdatedDate.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_lastUpdatedDate.font = [UIFont systemFontOfSize:12.0f];
		_lastUpdatedDate.textColor = _statusLabel.textColor; //TEXT_COLOR;
		_lastUpdatedDate.shadowColor = _statusLabel.shadowColor; //[UIColor colorWithWhite:0.9f alpha:1.0f];
//		_lastUpdatedDate.shadowOffset = FLSizeMake(0.0f, 1.0f);
		_lastUpdatedDate.backgroundColor = [UIColor clearColor];
		_lastUpdatedDate.textAlignment = UITextAlignmentCenter;
	//	_lastUpdatedDate.themeAction = @selector(applyThemeToTableViewCellTitleLabel:);
		[self addSubview:_lastUpdatedDate];
			
		_arrowImage = [[CALayer alloc] init];
		_arrowImage.contentsGravity = kCAGravityResizeAspect;
		_arrowImage.contents = (id)[[UIImage imageNamed:@"grayArrow.png"] colorizeImage:[UIColor lightGrayColor] 
			blendMode:kCGBlendModeOverlay].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			_arrowImage.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:_arrowImage];
		
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		_spinner.hidesWhenStopped = YES;
		[self addSubview:_spinner];
		
	  // self.backgroundColor = [UIColor whiteColor]; // [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];

		self.state = FLPullToRefreshHeaderViewDormant;
		
		self.alpha = 0.0;
	}
	return self;
}

- (BOOL) isVisibleInScrollView:(UIScrollView*) scrollView
{
	return ((scrollView.contentOffset.y + 1.0) <= (scrollView.contentInset.top*-1.0));
}

- (void) scrollViewDidScroll:(UIScrollView*) scrollView
{
	if(scrollView.isDragging && self.state != FLPullToRefreshHeaderViewRefreshing) 
	{
		if([self isVisibleInScrollView:scrollView])
		{
			self.state = FLPullToRefreshHeaderViewPulling;
		}
		else 
		{
			self.state = FLPullToRefreshHeaderViewDormant;
		}
	}
}

- (void) setFinishedRefreshing
{
	self.state = FLPullToRefreshHeaderViewDormant;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if([self isVisibleInScrollView:scrollView] && self.state != FLPullToRefreshHeaderViewRefreshing)
	{
		[_delegate pullToRefreshHeaderViewBeginRefreshing:self];
		self.state = FLPullToRefreshHeaderViewRefreshing;
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	self.newFrame = CGRectMake(0.0f, 0.0f - HEIGHT, self.superview.bounds.size.width, HEIGHT);
	_backgroundView.newFrame = self.bounds;
	
	CGRect bounds = self.bounds;
	_statusLabel.newFrame = FLRectOptimizedForViewSize(FLRectCenterRectInRect(bounds, CGRectMake(0.0f, 0.0f, self.frame.size.width, 20.0f)));
	_lastUpdatedDate.newFrame = FLRectOptimizedForViewSize(
		FLRectAlignRectVertically(_statusLabel.frame, 
			FLRectCenterRectInRectHorizontally(bounds, 
				CGRectMake(0.0f, 0.0f, self.frame.size.width, 16.0f)))); 
	_arrowImage.frame = FLRectOptimizedForViewSize(FLRectCenterRectInRectVertically(bounds, CGRectMake(25.0f, 0, 30.0f, 55.0f)));
	_spinner.newFrame = FLRectOptimizedForViewSize(FLRectCenterRectInRectVertically(bounds, CGRectMake(25.0f, 0, 20.0f, 20.0f)));
}

- (void) dealloc
{
	FLRelease(_backgroundView);
	FLRelease(_statusLabel);
	FLRelease(_arrowImage);
	FLRelease(_spinner);
	super_dealloc_();
}

- (void) updateLastUpdateTime:(NSDate*) date
{
	static NSDateFormatter *s_formatter = nil;
	if(!s_formatter)
	{
		s_formatter = [[NSDateFormatter alloc] init];
		[s_formatter setAMSymbol:@"AM"];
		[s_formatter setPMSymbol:@"PM"];
		[s_formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
	}
	if(date)
	{
		_lastUpdatedDate.text = [NSString stringWithFormat:(NSLocalizedString(@"Last Updated: %@", nil)), [s_formatter stringFromDate:date]];
	}
	else
	{
		_lastUpdatedDate.text = @"";
	}
}

//- (void)setCurrentDate {
//	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//	[formatter setAMSymbol:@"AM"];
//	[formatter setPMSymbol:@"PM"];
//	[formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
//	_lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [formatter stringFromDate:[NSDate date]]];
//	[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"FLRefreshTableView_LastRefresh"];
//	[[NSUserDefaults standardUserDefaults] synchronize];
//	FLRelease(formatter);
//}

- (FLPullToRefreshHeaderViewState) state
{
	return _pullFlags.state;
}

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
}


- (void)setState:(FLPullToRefreshHeaderViewState)aState
{
	UIScrollView* scrollView = [_delegate pullToRefreshHeaderViewGetScrollView:self];

	if(aState != self.state)
	{
		switch (aState) 
		{
			case FLPullToRefreshHeaderViewPulling:
				[self updateLastUpdateTime:[self.delegate pullToRefreshHeaderViewLastUpdatedDate:self]];
				_previousInset = scrollView.contentInset.top;
				_statusLabel.text = NSLocalizedString(@"Release to refresh…", nil);
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
				[CATransaction commit];
				
				[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:.3];
				self.alpha = 1.0;
				[UIView commitAnimations];
				break;

			case FLPullToRefreshHeaderViewDormant:

				_statusLabel.text = NSLocalizedString(@"Pull down to refresh…", nil);

				if (self.state == FLPullToRefreshHeaderViewPulling) 
				{
					[CATransaction begin];
					[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
					_arrowImage.transform = CATransform3DIdentity;
					[CATransaction commit];
				}
				
				[_spinner stopAnimating];
				[CATransaction begin];
				[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
				_arrowImage.hidden = NO;
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
				
				[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:.3];
				[UIView setAnimationDelegate:self];
				[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
				[scrollView setContentInset:UIEdgeInsetsMake(_previousInset, 0.0f, 0.0f, 0.0f)];
				[UIView commitAnimations];

				[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:.3];
				self.alpha = 0.0;
				[UIView commitAnimations];

				break;

			case FLPullToRefreshHeaderViewRefreshing:
				_statusLabel.text = NSLocalizedString(@"Refreshing…", nil);
				[_spinner startAnimating];
				[CATransaction begin];
				[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
				_arrowImage.hidden = YES;
				[CATransaction commit];
		
				[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:0.2];
				scrollView.contentInset = UIEdgeInsetsMake(_previousInset + self.frame.size.height, 0.0f, 0.0f, 0.0f);
				[UIView commitAnimations];

				break;

			default:
				break;
		}
		
		_pullFlags.state = aState;
	}
}

- (UIEdgeInsets) willUpdateTableViewContentInset:(UIEdgeInsets) insets
{
	if(self.state == FLPullToRefreshHeaderViewRefreshing)
	{
		insets.top += self.frame.size.height;
	}
	
	return insets;
}

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	float pt = FLRectGetBottom(self.bounds);
	
	CGContextRef ctx = UIGraphicsGetCurrentContext(); //get the graphics context
	CGContextSetLineWidth(ctx, 2.0);

	CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1); 
	CGContextMoveToPoint(ctx, 0, 0);
	CGContextAddLineToPoint(ctx , self.bounds.size.width, 0);
	
	CGContextSetRGBStrokeColor(ctx, 0.7, 0.7, 0.7, 1); 
	CGContextMoveToPoint(ctx, 0, pt);
	CGContextAddLineToPoint(ctx , self.bounds.size.width, pt);
	CGContextStrokePath(ctx);

}

@end
