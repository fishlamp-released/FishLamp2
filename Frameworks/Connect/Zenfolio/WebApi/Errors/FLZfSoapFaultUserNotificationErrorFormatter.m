////
////	FLZfSoapFaultUserNotificationErrorFormatter.m
////	MyZen
////
////	Created by Mike Fullerton on 1/2/10.
////	Copyright 2010 GreenTongue Software. All rights reserved.
////
//
//#import "FLZfSoapFaultUserNotificationErrorFormatter.h"
//#import "FLZfErrors.h"
//#import "FLSoapError.h"
//#import "FLStringBuilder.h"
//
//@implementation FLZfSoapFaultUserNotificationErrorFormatter
//
//- (NSString*) describeError:(NSError*) error
//{
//    FLStringBuilder* stringBuilder = [FLStringBuilder stringBuilder];
//    
//	switch(error.zenfolioFaultCode)
//	{
//		case errInvalidCredentials:
//			return @"";
//		break;
//		
//		default:
//		case errNotZfError:
//		case errUnspecified:
//		case errConnectionIsNotSecure:
//		case errDuplicateEmail:
//		case errDuplicateLoginName:
//			FLLog(@"We should never get this soap error from the server: %@", error.soapFault.faultstring);
//		break;
//		
//		case errAccountLocked:
//			[stringBuilder appendLine:NSLocalizedString(@"Your Zenfolio account is Locked", nil)];
//			
//			[stringBuilder endLine];
//			[stringBuilder appendLine:NSLocalizedString(@"Please log into the website to correct this problem.", nil)];
//		break;
//		
//		case errInvalidParam:
//			[stringBuilder appendLine:NSLocalizedString(@"An application error has occurred", nil)];
//			[stringBuilder endLine];
//			[stringBuilder appendLine:NSLocalizedString(@"Please try what you were doing again and if it continues to fail, please contact Zenfolio support and report this issue.", nil)];
//		break;
//		
//		case errNoSuchObject:
//			[stringBuilder appendLine:NSLocalizedString(@"An item no longer exists on the server", nil)];
//			
//			[stringBuilder endLine];
//		[stringBuilder appendLine:NSLocalizedString(@"This may mean that the application is out of sync. Please try what you were doing again, or try refreshing your current view.", nil)];
//		break;
//		
//		case errNotAuthorized: 
//			[stringBuilder appendLine:NSLocalizedString(@"You do not have access to this item.", nil)];
//			[stringBuilder endLine];
//			[stringBuilder appendLine:NSLocalizedString(@"Please contact the owner and ask for access if this is appropriate.", nil)];
//		break;
//		
//		case errNotAuthenticated:
//			[stringBuilder appendLine:NSLocalizedString(@"You are not authenticated.", nil)];
//			[stringBuilder endLine];
//			[stringBuilder appendLine:NSLocalizedString(@"Please login in again to correct this problem.", nil)];
//		break;
//	}
//
//	
//#if DEBUG
//		[stringBuilder endLine];
//		[stringBuilder appendString:@"DEBUG ONLY:"];
//		[stringBuilder appendLine: [error.soapFault faultstring]];
//#endif
//	
//	return [stringBuilder buildString];
//}
//
//- (NSString*) domain
//{
//	return FLSoapFaultDomain;
//}
//
//- (BOOL) willDescribeError:(NSError*) error
//{
//	return FLStringsAreEqual(error.domain, self.domain);
//}
//
//@end
