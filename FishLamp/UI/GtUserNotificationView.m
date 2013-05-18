//
//  GtUserNotificationView.m
//  MyZen
//
//  Created by Mike Fullerton on 12/26/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtUserNotificationView.h"
#import "GtFileUtilities.h"
#import "GtSoapError.h"

static GtWeakReference* s_currentView = nil;
static NSMutableArray* s_errorHandlers = nil;

@implementation GtUserNotificationView

GtSynthesizeString(suggestedRemedy, setSuggestedRemedy);

GtSynthesizeStructProperty(willTryAgain, setWillTryAgain, BOOL, m_userNotificationFlags);
GtSynthesizeStructProperty(viewType, setViewType, GtUserNotificationViewType, m_userNotificationFlags);

+ (void) setCurrentView:(GtUserNotificationView*) view
{
    [GtUserNotificationView hideCurrentView];

    if(!s_currentView)
    {
        s_currentView = [GtAlloc(GtWeakReference) init];
    }
    
    s_currentView.object = view;
}

+ (void) hideCurrentView
{
    if(s_currentView && s_currentView.object)
    {
        [s_currentView.object hide];
        s_currentView.object = nil;
    }
}

+ (GtUserNotificationView*) currentView
{
    return s_currentView != nil ? s_currentView.object : nil;
} 

- (id) init
{
	if(self = [super init])
	{
		self.backgroundOpacity = 1.0;
		self.borderOpacity = 1.0;
		self.isModal = NO;
		self.canDismiss = YES;
		
        [GtUserNotificationView setCurrentView:self];
	}

	return self;
}

- (id) initAsWarningNotification
{
	if(self = [self init])
	{
		self.icon = [UIImage imageNamed:@"warning-20.png"];
		GtAssertNotNil(self.icon);
		m_userNotificationFlags.viewType = GtUserNotificationViewWarningType;
	}
	return self;
}

- (id) initAsInfoNotification
{
	if(self = [self init])
	{
		self.icon = [UIImage imageNamed:@"info-20.png"];
		GtAssertNotNil(self.icon);
		m_userNotificationFlags.viewType = GtUserNotificationViewInfoType;
	}
	return self;
}

- (id) initAsErrorNotification
{
	if(self = [self init])
	{
		self.icon = [UIImage imageNamed:@"error-20.png"];
		GtAssertNotNil(self.icon);
		m_userNotificationFlags.viewType = GtUserNotificationViewErrorType;
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_suggestedRemedy);

	[super dealloc];
	
}

- (BOOL) isInfoNotification
{
	return self.viewType == GtUserNotificationViewInfoType;
}

- (BOOL) isWarningNotification
{
	return self.viewType == GtUserNotificationViewWarningType;
}

- (BOOL) isErrorNotification
{
	return self.viewType == GtUserNotificationViewErrorType;
    
}

- (void) addSuggestedRemedyToText
{
	if(m_suggestedRemedy)
	{
		[self.text appendLine:m_suggestedRemedy];
		[self.text appendLine];
	}
}

- (void) setTextWithError:(NSError*) error
    title:(NSString*) title
{
    self.title = title;
    if([self.text appendLineIfNotEmpty:[error localizedDescription]])
    {
        [self.text appendLine];
    }
    if([self.text appendLineIfNotEmpty:[error localizedFailureReason]])
    {
        [self.text appendLine];
    }
    
    for(NSString* option in [error localizedRecoveryOptions])
    {
        [self.text appendLineIfNotEmpty:option];
    }
    
    [self.text appendLineIfNotEmpty:[error localizedRecoverySuggestion]];
}


- (void) setTextWithErrorUsingFormatters:(NSError*) error
{
	[self setTextWithErrorUsingFormatters:error suggestedRemedy:nil];
}

- (void) setTextWithErrorUsingFormatters:(NSError*) error
	suggestedRemedy:(NSString*) suggestedRemedy
{
    self.suggestedRemedy = suggestedRemedy;

    self.errorCode = [NSString stringWithFormat:@"%@:%d", (error.domain == nil) ? @"UnknownDomain" : error.domain, error.code];
    
    for(id<GtUserNotificationErrorFormatterProtocol> handler in s_errorHandlers)
    {
        if( [error.domain isEqualToString:handler.domain] &&
            [handler formatErrorForDisplay:error
                          forNotification:self])
        {
            return;
        }
    }
    
    [self setTextWithError:error title:@"An unexpected error occured"];
}

NSInteger SortByPriority(  id<GtUserNotificationErrorFormatterProtocol> lhs, 
                    id<GtUserNotificationErrorFormatterProtocol> rhs, 
                    void *context)
{
    return lhs.priority < rhs.priority;
}

+ (void) addErrorFormatter:(id<GtUserNotificationErrorFormatterProtocol>) handler
{
    if(!s_errorHandlers)
    {
        s_errorHandlers = [GtAlloc(NSMutableArray) init];
    }

    [s_errorHandlers addObject:handler];
    
    [s_errorHandlers sortUsingFunction:SortByPriority context:nil];
}


@end
