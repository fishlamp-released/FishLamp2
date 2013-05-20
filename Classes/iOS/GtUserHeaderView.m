//
//  GtUserHeaderView.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUserHeaderView.h"
#import "GtRoundRectView.h"

@implementation GtUserHeaderView

@synthesize thumbnailView = m_thumbnail;
@synthesize nameLabel = m_nameLabel;
@synthesize logoView = m_logo;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.themeAction = @selector(applyThemeToUserHeaderView:);
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		self.backgroundColor = [UIColor clearColor];
	
		m_thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,50,50)];
		m_thumbnail.contentMode = UIViewContentModeScaleAspectFit;
		m_thumbnail.backgroundColor = [UIColor whiteColor];
		[self addSubview:m_thumbnail];
		
		m_thumbnail.layer.cornerRadius = GtRoundRectViewCornerRadiusDefault;
		m_thumbnail.layer.borderWidth = 0.5;
		m_thumbnail.layer.borderColor = [UIColor lightGrayColor].CGColor;
		m_thumbnail.clipsToBounds = YES;
		
		m_nameLabel = [[GtLabel alloc] initWithFrame:CGRectMake(60,0,100,20)];
		m_nameLabel.backgroundColor = [UIColor clearColor];
		m_nameLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
		m_nameLabel.textColor = [UIColor blackColor];
		[self addSubview:m_nameLabel];
		
		m_logo = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,24,24)];
		m_logo.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:m_logo];

	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_logo);
	GtRelease(m_spinner);
	GtRelease(m_thumbnail);
	GtRelease(m_nameLabel);
	GtSuperDealloc();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	m_thumbnail.frameOptimizedForSize = GtRectCenterRectInRectVertically(self.bounds, m_thumbnail.frame);
	
	m_nameLabel.frameOptimizedForSize = GtRectCenterRectInRectVertically(self.bounds,
		GtRectSetWidth(
			GtRectSetLeft(m_nameLabel.frame, GtRectGetRight(m_thumbnail.frame) + 10.0f), 
				self.bounds.size.width - m_thumbnail.frame.size.width - 20.0));
	
	m_logo.frameOptimizedForLocation = GtRectCenterRectInRectVertically(self.bounds, GtRectJustifyRectInRectRight(self.bounds, m_logo.frame));
	
	if(m_spinner)
	{
		m_spinner.frameOptimizedForLocation = GtRectCenterRectInRect(m_thumbnail.bounds, m_spinner.frame);
	}	
}

- (NSString*) name
{
	return m_nameLabel.text;
}	

- (void) setName:(NSString*) name
{
	m_nameLabel.text = name;
	[self setNeedsLayout];
}

- (void) setThumbnail:(UIImage*) image
{
	m_thumbnail.image = image;
	if(m_thumbnail.image)
	{
		[m_thumbnail resizeProportionally:CGSizeMake(50,50)];
		
//		m_thumbnail.frame = CGRectInset(m_thumbnail.frame, -1, -1);
		
	}
	[self setNeedsLayout];
}

- (UIImage*) thumbnail
{
	return m_thumbnail.image;
}

- (void) startSpinner
{
	if(!m_spinner)
	{
		m_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[m_spinner startAnimating];
		[m_thumbnail addSubview:m_spinner];
		[self setNeedsLayout];
	}
}

- (void) stopSpinner
{
	if(m_spinner)
	{
		[m_spinner removeFromSuperview];
		GtReleaseWithNil(m_spinner);
	}
}

@end
