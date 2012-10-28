//
//	FLDefaultUserNotificationErrorFormatters.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/2/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLDefaultUserNotificationErrorFormatters.h"
#import "FLOldUserNotificationView.h"
#import "NSFileManager+FLExtras.h"
#import "FLSoapError.h"
#import "FLErrorDescriber.h"

//#import <CFNetwork/CFNetworkErrors.h>

#define MovePhone NSLocalizedString(@"Moving your device to a location that has better reception may help fix this problem.", nil)

void InstallDefaultUserNotificationErrorFormatters()
{
	[[FLErrorDescriberManager instance] addErrorDescriber:FLReturnAutoreleased([[NSUrlErrorDomainErrorFormatter alloc] init]) ];
//	  [[FLErrorDescriberManager instance] addErrorDescriber:FLReturnAutoreleased([[NSPOSIXErrorDomainErrorFormatter alloc] init]) ]; 
	[[FLErrorDescriberManager instance] addErrorDescriber:FLReturnAutoreleased([[FLSoapFaultErrorDomainErrorFormatter alloc] init])]; 
}

@implementation NSUrlErrorDomainErrorFormatter


- (NSString*) describeError:(NSError*) error
{
//	  errorDescription.title = descriptionOrNil.failureText;	
//	  
//	  if(FLStringIsEmpty(errorDescription.title))
//	  {
//		  errorDescription.title = @"An error occurred on the server.";
//	  }	  

	FLStringBuilder* builder = [FLStringBuilder stringBuilder];
    
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
	return FLStringsAreEqual(error.domain, self.domain);
}

@end

@implementation FLSoapFaultErrorDomainErrorFormatter

- (BOOL) willDescribeError:(NSError*) error
{
	return FLStringsAreEqual(error.domain, self.domain);
}

- (NSString*) describeError:(NSError*) error {
    FLStringBuilder* builder = [FLStringBuilder stringBuilder];
	
	[builder appendLine:NSLocalizedString(@"The server returned an error.", nil)];
	[builder appendLine];
					  
	FLSoapFault11* fault = error.soapFault;
		
	if(FLStringIsNotEmpty(fault.faultstring))
	{
		[builder appendLine:fault.faultstring];
		[builder appendLine];
	}
	
#if DEBUG	 
	if(FLStringIsNotEmpty(fault.detail))
	{
		[builder appendLine:fault.detail];
		[builder appendLine];
	}
	
	if(FLStringIsNotEmpty(fault.faultactor))
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

- (NSString*) domain {
	return FLSoapFaultDomain;
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
	return FLLowErrorFormatterPriority;
}

- (BOOL) willDescribeError:(NSError*) error
{
	return FLStringsAreEqual(error.domain, self.domain);
}

@end


@implementation NSCocoaErrorDomainErrorFormatter

// FoundationErrors.h

- (BOOL) formatErrorForDisplay:(NSError*) error 
					   actionDescription:(FLActionDescription*) descriptionOrNil
					 
			   forNotification:(id<FLDisplayedNotification>) errorDescription
{
   
	
	return YES;
}

- (NSString*) domain
{
	return NSCocoaErrorDomain;
}

- (NSUInteger) priority
{
	return FLLowErrorFormatterPriority;
}

@end


@implementation CFNetworkDomainErrorFormatter

// CFNetworkErrors.h

- (BOOL) formatErrorForDisplay:(NSError*) error 
			   forNotification:(id<FLDisplayedNotification>) errorDescription
{
   
	
	return YES;
}

- (NSString*) domain
{
	return kCFErrorDomainCFNetwork;
}

- (NSUInteger) priority
{
	return FLLowErrorFormatterPriority;
}

@end
*/
