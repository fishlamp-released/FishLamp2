//
//	GtDefaultUserNotificationErrorFormatters.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/2/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtDefaultUserNotificationErrorFormatters.h"
#import "GtUserNotificationView.h"
#import "NSFileManager+GtExtras.h"
#import "GtSoapError.h"
#import "GtErrorDescriber.h"

//#import <CFNetwork/CFNetworkErrors.h>

#define MovePhone NSLocalizedString(@"Moving your device to a location that has better reception may help fix this problem.", nil)

void InstallDefaultUserNotificationErrorFormatters()
{
	[[GtErrorDescriberManager instance] addErrorDescriber:GtReturnAutoreleased([[NSUrlErrorDomainErrorFormatter alloc] init]) ];
//	  [[GtErrorDescriberManager instance] addErrorDescriber:GtReturnAutoreleased([[NSPOSIXErrorDomainErrorFormatter alloc] init]) ]; 
	[[GtErrorDescriberManager instance] addErrorDescriber:GtReturnAutoreleased([[GtSoapFaultErrorDomainErrorFormatter alloc] init])]; 
}

@implementation NSUrlErrorDomainErrorFormatter


- (NSString*) describeError:(NSError*) error
{
//	  errorDescription.title = descriptionOrNil.failureText;	
//	  
//	  if(GtStringIsEmpty(errorDescription.title))
//	  {
//		  errorDescription.title = @"An error occurred on the server.";
//	  }	  

	GtStringBuilder* builder = GtReturnAutoreleased([[GtStringBuilder alloc] init]);
	
	switch(error.code)
	{
		case NSURLErrorUserAuthenticationRequired:
			[builder appendLine:NSLocalizedString(@"Authentication Required.", nil)];
			break;
	
		case NSURLErrorTimedOut:
			[builder appendLine:NSLocalizedString(@"The server is not responding.", nil)];
			[builder appendLine];
			[builder appendLine:MovePhone];
			break;

		case kCFURLErrorNotConnectedToInternet:
			[builder appendLine:NSLocalizedString(@"The device is not connected to the network.", nil)];
			[builder appendLine];
			[builder appendLine:NSLocalizedString(@"Please try again when you have a network connection.", nil)];
			break;
			
		case NSURLErrorNetworkConnectionLost:
			[builder appendLine:NSLocalizedString(@"The network connection was lost.", nil)];
			[builder appendLine];
			[builder appendLine:MovePhone];
			break;

		case NSURLErrorCannotFindHost:
		case NSURLErrorCannotConnectToHost:		
			[builder appendLine:NSLocalizedString(@"Unable to connect to server.", nil)];
			[builder appendLine];
			
			break;

		default:
			[builder appendLine:NSLocalizedString(@"A network error occured.", nil)];
			break;
			
	}

	return [builder buildString];
}

- (NSString*) domain
{
	return NSURLErrorDomain;
}


- (BOOL) willDescribeError:(NSError*) error
{
	return GtStringsAreEqual(error.domain, self.domain);
}

@end

@implementation GtSoapFaultErrorDomainErrorFormatter

- (BOOL) willDescribeError:(NSError*) error
{
	return GtStringsAreEqual(error.domain, self.domain);
}

- (NSString*) describeError:(NSError*) error
{
	GtStringBuilder* builder = GtReturnAutoreleased([[GtStringBuilder alloc] init]);
	
	[builder appendLine:NSLocalizedString(@"The server returned an error.", nil)];
	[builder appendLine];
					  
	GtSoapFault11* fault = error.soapFault;
		
	if(GtStringIsNotEmpty(fault.faultstring))
	{
		[builder appendLine:fault.faultstring];
		[builder appendLine];
	}
	
#if DEBUG	 
	if(GtStringIsNotEmpty(fault.detail))
	{
		[builder appendLine:fault.detail];
		[builder appendLine];
	}
	
	if(GtStringIsNotEmpty(fault.faultactor))
	{
		[builder appendLine:fault.faultactor];
		[builder appendLine];
	}
#endif
	
#if DEBUG
	[builder appendLineWithFormat:@"FaultCode: %@", fault.faultcode];
#endif

	return [builder buildString];
}

- (NSString*) domain
{
	return GtSoapFaultDomain;
}


@end
/*
@implementation NSPOSIXErrorDomainErrorFormatter

- (NSString*) describeError:(NSError*) error
{
//	  errorDescription.title = descriptionOrNil.failureText;	
//	  switch(errorDescription.error.code)
//	  {
//		  case EPERM:
//			  errorDescription.description = @"Please try again when connected to Wifi or when you have a better connection.";
//			  break;
//	  }
	
	return @"";
}

- (NSString*) domain
{
	return NSPOSIXErrorDomain;
}

- (NSUInteger) priority
{
	return GtLowErrorFormatterPriority;
}

- (BOOL) willDescribeError:(NSError*) error
{
	return GtStringsAreEqual(error.domain, self.domain);
}

@end


@implementation NSCocoaErrorDomainErrorFormatter

// FoundationErrors.h

- (BOOL) formatErrorForDisplay:(NSError*) error 
					   actionDescription:(GtActionDescription*) descriptionOrNil
					 
			   forNotification:(id<GtDisplayedNotification>) errorDescription
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


@implementation CFNetworkDomainErrorFormatter

// CFNetworkErrors.h

- (BOOL) formatErrorForDisplay:(NSError*) error 
			   forNotification:(id<GtDisplayedNotification>) errorDescription
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
