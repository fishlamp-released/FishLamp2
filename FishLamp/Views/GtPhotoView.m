//
//  GtPhotoView.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtPhotoView.h"
#import "GtColors.h"
#import "GtGeometry.h"
#import "GtViewUtilities.h"
#import "GtUserNotificationView.h"
#import "GtUserNotificationView.h"
#import "GtUserNotificationView.h"
#import "GtUserNotificationView.h"

#import "GtViewFader.h"
#import "GtLowMemoryHandler.h"
#import "GtAction.h"

@implementation GtPhotoView

GtSynthesizeStructProperty(isLoading, setIsLoading, BOOL, m_photoViewFlags);
GtSynthesizeStructProperty(cancelled, setCancelled, BOOL, m_photoViewFlags);
GtSynthesizeStructProperty(isLoaded, setIsLoaded, BOOL, m_photoViewFlags);
GtSynthesizeStructProperty(failedToLoad, setFailedToLoad, BOOL, m_photoViewFlags);

GtSynthesize(spinner, setSpinner, UIActivityIndicatorView, m_spinner);
GtSynthesizeID(photo, setPhoto);
GtSynthesizeID(userData, setUserData);

GtSynthesizeString(details, setDetails);
GtSynthesizeString(title, setTitle);

- (void) initPhotoView
{
    m_detailsView = [GtAlloc(GtWeakReference) init];
	
	UIActivityIndicatorView* spinner = [GtAlloc(UIActivityIndicatorView) initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	spinner.hidesWhenStopped = YES;
	[spinner startAnimating];
	spinner.autoresizingMask =	UIViewAutoresizingFlexibleLeftMargin | 
							UIViewAutoresizingFlexibleRightMargin |
							UIViewAutoresizingFlexibleTopMargin |
							UIViewAutoresizingFlexibleBottomMargin;

	self.spinner = spinner;
	GtRelease(spinner);
	
	[self addSubview:m_spinner];
	
	[self setNeedsLayout];
    
    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = YES;
}

- (void) startSpinner
{
    [m_spinner startAnimating];
}

- (void) stopSpinner
{
	[m_spinner stopAnimating];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
    CGRect bounds = self.bounds;
	
	if(m_spinner)
	{
		m_spinner.frame = GtCenterRectInRect(bounds, m_spinner.frame);
	}
}

- (id)initWithFrame:(CGRect)frame
{
	if(self = [super initWithFrame:frame])
	{
		[self initPhotoView];
    }
	return self;
}

- (id)initWithImage:(UIImage *)image
{
	if(self = [super initWithImage:image])
	{
		[self initPhotoView];
    }
	return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
	if(self = [super initWithImage:image highlightedImage:highlightedImage])
	{
		[self initPhotoView];
    }
	return self;
}

- (void) cancel
{
	self.cancelled = YES;
	self.isLoading = NO;
	
	if(m_action.object)
	{
		[m_action.object terminateAction];
		m_action.object = nil;
	}
}

- (void) dealloc
{
	[self cancel];
	[self hideDetailsView];
    
    GtRelease(m_photo);
	GtRelease(m_userData);
	GtRelease(m_spinner);
	GtRelease(m_detailsView);
    GtRelease(m_action);
	GtRelease(m_errorView);
    GtRelease(m_retryButton);
    GtRelease(m_title);
	GtRelease(m_details);
    
	[super dealloc];
}

- (void) setImage:(UIImage*) image
{
	self.isLoading = NO;
    self.cancelled = NO;
		
	self.action = nil;

	self.isLoaded = image != nil;

	if(!self.isLoaded)
	{
		[self startSpinner];
	}
	
	[super setImage:image];
	
	if(self.isLoaded)
	{
		[self stopSpinner];
	}
}

- (void) setAction:(GtAction*) action
{
	if(!m_action)
	{
		m_action = [GtAlloc(GtWeakReference) init];
	}
	
	m_action.object = action;
}

- (GtAction*) action
{
	return m_action.object;
}

- (void) setDetailsView:(GtNotificationView*) view
{
	if(m_detailsView.object)
	{
		[m_detailsView.object hide];
		m_detailsView.object = nil;
	}
	
	m_detailsView.object = view;
	
	if(view)
	{
		[self addSubview:view];
        
        [view becomeFirstResponder];
	}
}

- (GtNotificationView*) detailsView
{
	return m_detailsView.object;
}

- (void) reset
{
    [m_errorView removeFromSuperview];
    GtReleaseWithNil(m_errorView);
    
    [m_retryButton removeFromSuperview];
    GtReleaseWithNil(m_retryButton);
    
    [self stopSpinner];
    
    self.isLoading = NO;
    self.isLoaded = NO;
    self.cancelled = NO;
    self.failedToLoad = NO;
}

- (void) setFailedToLoad:(id) target retryAction:(SEL) retryAction
{
    [self stopSpinner];
    self.failedToLoad = YES;
        		
	if(!m_errorView)
	{
		UILabel* label = [GtAlloc(UILabel) initWithFrame:CGRectMake(0,0, 200, 20)];
		label.textColor = [UIColor whiteColor];
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		label.font = [UIFont systemFontOfSize:12.0];
		label.text = NSLocalizedStringFromTable(@"GT_UNABLE_TO_LOAD_PHOTO_STR", @"FishLamp", nil);
		label.autoresizingMask =	UIViewAutoresizingFlexibleLeftMargin | 
									UIViewAutoresizingFlexibleRightMargin |
									UIViewAutoresizingFlexibleTopMargin |
									UIViewAutoresizingFlexibleBottomMargin;
									
		label.frame = GtCenterRectInRect(self.bounds, label.frame);
		[self addSubview:label];

		m_errorView = label;
        
        m_retryButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        [m_retryButton setTitle:@"Retry" forState:UIControlStateNormal];
        [m_retryButton addTarget:target action:retryAction forControlEvents:UIControlEventTouchUpInside];
        m_retryButton.frame = GtCenterRectHorizontallyInRect(self.bounds,             
            CGRectMake(0,label.frame.origin.y + 40, 120, 26));
        [self addSubview:m_retryButton];
    }
	
	[self stopSpinner];
}

- (BOOL) hasDetailsView
{
    return m_detailsView.object != nil;
}

- (void) hideDetailsView
{
	[self.detailsView hide];
}

- (void) showDetailsView:(BOOL) showIfEmpty withMessage:(NSString*) message
{
    if(!self.detailsView)
    {
        if((m_details && m_details.length) || showIfEmpty)
        {
            NSString* string = nil;
            if(GtStringHasValue(m_details))
            {
                string = m_details;
            }
            else if(GtStringHasValue(message))
            {
                string = message;
            }
            else
            {
                string = @"";
            }
        
            GtNotificationView* view = [GtAlloc(GtNotificationView) init];
            // TODO: make isHtml and maxTextHeight configurable
            view.isHtml  = YES;
            view.maxTextHeight = 180;
            view.location = GtNotificationViewLocationTop;
            view.animationType = GtNotificationViewAnimationTypeFade;
            [view.text appendString:string];
            self.detailsView = view;
            GtRelease(view);
        }
    }
}

@end /* GtPhotoView */
