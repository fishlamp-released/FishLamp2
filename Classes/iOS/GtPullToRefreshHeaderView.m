//
//	GtPullToRefreshHeaderView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/2/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPullToRefreshHeaderView.h"
#import "UIImage+GtColorize.h"
#import "GtLabel.h"

typedef enum {
	GtPullToRefreshHeaderViewPulling = 0,
	GtPullToRefreshHeaderViewDormant,
	GtPullToRefreshHeaderViewRefreshing,	
} GtPullToRefreshHeaderViewState;


#define HEIGHT 65.0f

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define BORDER_COLOR [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define GtIP_ANIMATION_DURATION 0.18f

@interface GtPullToRefreshHeaderView (Private)
@property (readwrite, nonatomic, assign) GtPullToRefreshHeaderViewState state;
@end

@implementation GtPullToRefreshHeaderView

@synthesize delegate = m_delegate;

//- (void) onSetGradientColorProperties
//{
//	  self.gradientStartColor = [UIColor lightLightGrayColor];
//	  self.gradientEndColor = [UIColor lightGrayColor];
//}

- (id)initWithFrame:(CGRect)frame 
{
	if ((self = [super initWithFrame:frame])) 
	{
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor clearColor];
	
		m_backgroundView = [[GtGradientView alloc] initWithFrame:CGRectZero];
		m_backgroundView.alpha = 1.0; // 0.6f;
		[self addSubview:m_backgroundView];
//		  [m_backgroundView setGradientToDarkGray];
	
		m_statusLabel = [[GtLabel alloc] initWithFrame:CGRectZero];
		m_statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		m_statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
		m_statusLabel.textColor = [UIColor blackColor]; //TEXT_COLOR;
		m_statusLabel.shadowColor = [UIColor whiteColor]; //[UIColor colorWithWhite:0.9f alpha:1.0f];
//		m_statusLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		m_statusLabel.backgroundColor = [UIColor clearColor];
		m_statusLabel.textAlignment = UITextAlignmentCenter;
		m_statusLabel.themeAction = @selector(applyThemeToTableViewCellTitleLabel:);
		[self addSubview:m_statusLabel];
	
		m_lastUpdatedDate = [[GtLabel alloc] initWithFrame:CGRectZero];
		m_lastUpdatedDate.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		m_lastUpdatedDate.font = [UIFont systemFontOfSize:12.0f];
		m_lastUpdatedDate.textColor = m_statusLabel.textColor; //TEXT_COLOR;
		m_lastUpdatedDate.shadowColor = m_statusLabel.shadowColor; //[UIColor colorWithWhite:0.9f alpha:1.0f];
//		m_lastUpdatedDate.shadowOffset = CGSizeMake(0.0f, 1.0f);
		m_lastUpdatedDate.backgroundColor = [UIColor clearColor];
		m_lastUpdatedDate.textAlignment = UITextAlignmentCenter;
	//	m_lastUpdatedDate.themeAction = @selector(applyThemeToTableViewCellTitleLabel:);
		[self addSubview:m_lastUpdatedDate];
			
		m_arrowImage = [[CALayer alloc] init];
		m_arrowImage.contentsGravity = kCAGravityResizeAspect;
		m_arrowImage.contents = (id)[[UIImage imageNamed:@"grayArrow.png"] colorizeImage:[UIColor lightGrayColor] 
			blendMode:kCGBlendModeOverlay].CGImage;
		
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
		if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
			m_arrowImage.contentsScale = [[UIScreen mainScreen] scale];
		}
#endif
		
		[[self layer] addSublayer:m_arrowImage];
		
		m_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		m_spinner.hidesWhenStopped = YES;
		[self addSubview:m_spinner];
		
	  // self.backgroundColor = [UIColor whiteColor]; // [UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:237.0/255.0 alpha:1.0];

		self.state = GtPullToRefreshHeaderViewDormant;
		
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
	if(scrollView.isDragging && self.state != GtPullToRefreshHeaderViewRefreshing) 
	{
		if([self isVisibleInScrollView:scrollView])
		{
			self.state = GtPullToRefreshHeaderViewPulling;
		}
		else 
		{
			self.state = GtPullToRefreshHeaderViewDormant;
		}
	}
}

- (void) setFinishedRefreshing
{
	self.state = GtPullToRefreshHeaderViewDormant;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if([self isVisibleInScrollView:scrollView] && self.state != GtPullToRefreshHeaderViewRefreshing)
	{
		[m_delegate pullToRefreshHeaderViewBeginRefreshing:self];
		self.state = GtPullToRefreshHeaderViewRefreshing;
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	self.newFrame = CGRectMake(0.0f, 0.0f - HEIGHT, self.superview.bounds.size.width, HEIGHT);
	m_backgroundView.newFrame = self.bounds;
	
	CGRect bounds = self.bounds;
	m_statusLabel.newFrame = GtRectGrowRectToOptimizedSizeIfNeeded(GtRectCenterRectInRect(bounds, CGRectMake(0.0f, 0.0f, self.frame.size.width, 20.0f)));
	m_lastUpdatedDate.newFrame = GtRectGrowRectToOptimizedSizeIfNeeded(
		GtRectAlignRectVertically(m_statusLabel.frame, 
			GtRectCenterRectInRectHorizontally(bounds, 
				CGRectMake(0.0f, 0.0f, self.frame.size.width, 16.0f)))); 
	m_arrowImage.frame = GtRectGrowRectToOptimizedSizeIfNeeded(GtRectCenterRectInRectVertically(bounds, CGRectMake(25.0f, 0, 30.0f, 55.0f)));
	m_spinner.newFrame = GtRectGrowRectToOptimizedSizeIfNeeded(GtRectCenterRectInRectVertically(bounds, CGRectMake(25.0f, 0, 20.0f, 20.0f)));
}

- (void) dealloc
{
	GtRelease(m_backgroundView);
	GtRelease(m_statusLabel);
	GtRelease(m_arrowImage);
	GtRelease(m_spinner);
	GtSuperDealloc();
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
		m_lastUpdatedDate.text = [NSString stringWithFormat:(NSLocalizedString(@"Last Updated: %@", nil)), [s_formatter stringFromDate:date]];
	}
	else
	{
		m_lastUpdatedDate.text = @"";
	}
}

//- (void)setCurrentDate {
//	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//	[formatter setAMSymbol:@"AM"];
//	[formatter setPMSymbol:@"PM"];
//	[formatter setDateFormat:@"MM/dd/yyyy hh:mm:a"];
//	m_lastUpdatedLabel.text = [NSString stringWithFormat:@"Last Updated: %@", [formatter stringFromDate:[NSDate date]]];
//	[[NSUserDefaults standardUserDefaults] setObject:m_lastUpdatedLabel.text forKey:@"GtRefreshTableView_LastRefresh"];
//	[[NSUserDefaults standardUserDefaults] synchronize];
//	GtRelease(formatter);
//}

- (GtPullToRefreshHeaderViewState) state
{
	return m_pullFlags.state;
}

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
}


- (void)setState:(GtPullToRefreshHeaderViewState)aState
{
	UIScrollView* scrollView = [m_delegate pullToRefreshHeaderViewGetScrollView:self];

	if(aState != self.state)
	{
		switch (aState) 
		{
			case GtPullToRefreshHeaderViewPulling:
				[self updateLastUpdateTime:[self.delegate pullToRefreshHeaderViewLastUpdatedDate:self]];
				m_previousInset = scrollView.contentInset.top;
				m_statusLabel.text = NSLocalizedString(@"Release to refresh…", nil);
				[CATransaction begin];
				[CATransaction setAnimationDuration:GtIP_ANIMATION_DURATION];
				m_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
				[CATransaction commit];
				
				[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:.3];
				self.alpha = 1.0;
				[UIView commitAnimations];
				break;

			case GtPullToRefreshHeaderViewDormant:

				m_statusLabel.text = NSLocalizedString(@"Pull down to refresh…", nil);

				if (self.state == GtPullToRefreshHeaderViewPulling) 
				{
					[CATransaction begin];
					[CATransaction setAnimationDuration:GtIP_ANIMATION_DURATION];
					m_arrowImage.transform = CATransform3DIdentity;
					[CATransaction commit];
				}
				
				[m_spinner stopAnimating];
				[CATransaction begin];
				[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
				m_arrowImage.hidden = NO;
				m_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
				
				[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:.3];
				[UIView setAnimationDelegate:self];
				[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
				[scrollView setContentInset:UIEdgeInsetsMake(m_previousInset, 0.0f, 0.0f, 0.0f)];
				[UIView commitAnimations];

				[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:.3];
				self.alpha = 0.0;
				[UIView commitAnimations];

				break;

			case GtPullToRefreshHeaderViewRefreshing:
				m_statusLabel.text = NSLocalizedString(@"Refreshing…", nil);
				[m_spinner startAnimating];
				[CATransaction begin];
				[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
				m_arrowImage.hidden = YES;
				[CATransaction commit];
		
				[UIView beginAnimations:nil context:NULL];
				[UIView setAnimationDuration:0.2];
				scrollView.contentInset = UIEdgeInsetsMake(m_previousInset + self.frame.size.height, 0.0f, 0.0f, 0.0f);
				[UIView commitAnimations];

				break;

			default:
				break;
		}
		
		m_pullFlags.state = aState;
	}
}

- (UIEdgeInsets) willUpdateTableViewContentInset:(UIEdgeInsets) insets
{
	if(self.state == GtPullToRefreshHeaderViewRefreshing)
	{
		insets.top += self.frame.size.height;
	}
	
	return insets;
}

- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];
	
	float pt = GtRectGetBottom(self.bounds);
	
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
