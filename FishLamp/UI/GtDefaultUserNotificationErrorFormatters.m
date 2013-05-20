//
//  GtDefaultUserNotificationErrorFormatters.m
//  MyZen
//
//  Created by Mike Fullerton on 1/2/10.
//  Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "GtDefaultUserNotificationErrorFormatters.h"
#import "GtUserNotificationView.h"
#import "GtFileUtilities.h"
#import "GtSoapError.h"

//#import <CFNetwork/CFNetworkErrors.h>

#define AddOne(TYPE) do { TYPE* FORMATTER = [GtAlloc(TYPE) init]; [GtUserNotificationView addErrorFormatter:FORMATTER]; GtRelease(FORMATTER); } while(0)

#define MovePhone @" Moving your phone to a location that has better reception may help fix this problem."
#define BadNetConnection @"Your phone appears to be having difficulty initiating or maintaining a data connection."

#define WillContinueTrying @"%@ will continue to try to complete this task"



void InstallDefaultUserNotificationErrorFormatters()
{
    AddOne(NSUrlErrorDomainErrorFormatter);
    AddOne(NSUrlErrorDomainWarningFormatter);
    AddOne(NSPOSIXErrorDomainErrorFormatter);
    AddOne(GtSoapFaultErrorDomainErrorFormatter);
}

@implementation NSUrlErrorDomainErrorFormatter


- (BOOL) formatErrorForDisplay:(NSError*) error 
               forNotification:(GtUserNotificationView*) notification
{
    if(notification.willTryAgain)
    {
        return NO;
    }

    switch(error.code)
    {
        case NSURLErrorTimedOut:
            notification.title = @"The server did not respond";
            [notification addSuggestedRemedyToText];
            [notification.text appendString:BadNetConnection];
            [notification.text appendLine:MovePhone];
            break;
				
        case NSURLErrorNetworkConnectionLost:
            notification.title = @"Lost connection to network";	
            [notification addSuggestedRemedyToText];
            [notification.text appendString:BadNetConnection];
            [notification.text appendLine:MovePhone];
            break;

        
        case NSURLErrorCannotFindHost:
        case NSURLErrorCannotConnectToHost:		
            notification.title = @"Unable to connect to server";	
            [notification addSuggestedRemedyToText];
            break;

        default:
            notification.title = @"A network error occured";	
            [notification addSuggestedRemedyToText];
            break;
			
    }
    
    return YES;

}

- (NSString*) domain
{
    return NSURLErrorDomain;
}

- (NSUInteger) priority
{
    return GtLowErrorFormatterPriority;
}

@end

@implementation NSUrlErrorDomainWarningFormatter

- (void) addWarningContinueText:(GtUserNotificationView*) notification
{
	[notification.text appendLineWithFormat:@"%@ is trying again to finish this request, but may not be successful.", [GtFileUtilities appName]];
	[notification.text appendLine];
	
}

- (BOOL) formatErrorForDisplay:(NSError*) error 
               forNotification:(GtUserNotificationView*) notification
{
    if(!notification.willTryAgain)
    {
        return NO;
    }

    switch(error.code)
	{
		case NSURLErrorTimedOut:
			notification.title = @"The server is not responding";
			[self addWarningContinueText:notification]; 
			[notification.text appendString:BadNetConnection];
			[notification.text appendLine:MovePhone];
			[notification setErrorCodeWithInteger: error.code];
			return YES;
			break;
			
		case NSURLErrorNetworkConnectionLost:
			notification.title = @"Connection to network in intermittent";	
			[self addWarningContinueText:notification]; 
			[notification.text appendString:BadNetConnection];
			[notification.text appendLine:MovePhone];
			[notification setErrorCodeWithInteger: error.code];
			return YES;
			break;
	}    
    return YES;

}

- (NSString*) domain
{
    return NSURLErrorDomain;
}

- (NSUInteger) priority
{
    return GtLowErrorFormatterPriority;
}

@end

@implementation GtSoapFaultErrorDomainErrorFormatter

- (BOOL) formatErrorForDisplay:(NSError*) error 
               forNotification:(GtUserNotificationView*) notification
{
    GtSoapFault11* fault = error.soapFault;
    
    notification.errorCode = fault.faultcode;
    notification.title = @"An error occured on the server";
    
    if(fault.faultstringHasValue)
    {
        [notification.text appendLine:fault.faultstring];
        [notification.text appendLine];
    }
    
    if(fault.detailHasValue)
    {
        [notification.text appendLine:fault.detail];
        [notification.text appendLine];
    }
    
    if(fault.faultactorHasValue)
    {
        [notification.text appendLine:fault.faultactor];
        [notification.text appendLine];
    }
    
	return YES;
}

- (NSString*) domain
{
    return GtSoapFaultDomain;
}

- (NSUInteger) priority
{
    return GtLowErrorFormatterPriority;
}

@end

@implementation NSPOSIXErrorDomainErrorFormatter

- (void) addWarningContinueText:(GtUserNotificationView*) notification
{
	[notification.text appendLineWithFormat:@"%@ is trying again to finish this request, but may not be successful.", [GtFileUtilities appName]];
	[notification.text appendLine];
}


- (BOOL) formatErrorForDisplay:(NSError*) error 
               forNotification:(GtUserNotificationView*) notification
{
    switch(error.code)
    {
        case EPERM:
            if(notification.isWarningNotification)
            {
                notification.title = @"Uploading data to the server is failing.";	
                [self addWarningContinueText:notification]; 
            }
            else
            {
                notification.title = @"Uploading data to server failed.";
            }
			
            [notification addSuggestedRemedyToText];
            
            [notification.text appendLine:@"Your connection to the server was unexpectedly dropped by the 3g network.\n\nThis may be due to a poor or intermittent network connection.\n"];
            [notification.text appendLine:@"If this continues to fail, trying again with Wifi or when you have a better connection may help."];
            break;
    }
    
	return YES;
}

- (NSString*) domain
{
    return NSPOSIXErrorDomain;
}

- (NSUInteger) priority
{
    return GtLowErrorFormatterPriority;
}

@end


@implementation NSCocoaErrorDomainErrorFormatter

// FoundationErrors.h

- (BOOL) formatErrorForDisplay:(NSError*) error 
               forNotification:(GtUserNotificationView*) notification
{
   
    
	return YES;
}

- (NSString*) domain
{
    return NSCocoaErrorDomain;
}

- (NSUInteger) priority
{
    return GtLowErrorFormatterPriority;
}

@end

/*
@implementation CFNetworkDomainErrorFormatter

// CFNetworkErrors.h

- (BOOL) formatErrorForDisplay:(NSError*) error 
               forNotification:(GtUserNotificationView*) notification
{
   
    
	return YES;
}

- (NSString*) domain
{
    return kCFErrorDomainCFNetwork;
}

- (NSUInteger) priority
{
    return GtLowErrorFormatterPriority;
}

@end
*/
