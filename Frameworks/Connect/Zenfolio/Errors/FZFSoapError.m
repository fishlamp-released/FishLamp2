//
//  FLZenfolioSoapError.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioSoapError.h"
#import "FLSoapFault11.h"
#import "FLZenfolioErrors.h"
#import "FLPrettyString.h"

@implementation NSError (ZenfolioSoapError)

+ (NSError*) errorWithZenfolioSoapFault:(FLSoapFault11*) fault {

    FLZenfolioErrorCode error = [[FLZenfolioErrors instance] errorCodeFromString:fault.faultcode];

    FLPrettyString* stringBuilder = [FLPrettyString prettyString];
    
	switch(error)
	{
		case FLZenfolioErrorCodeInvalidCredentials:
			[stringBuilder appendLine:NSLocalizedString(@"Invalid Credentials", nil)];
		break;
		
		default:
		case FLZenfolioErrorCodeErrorIsNotZenfolioError:
		case FLZenfolioErrorCodeUnspecified:
		case FLZenfolioErrorCodeConnectionIsNotSecure:
		case FLZenfolioErrorCodeDuplicateEmail:
		case FLZenfolioErrorCodeDuplicateLoginName:
			FLLog(@"We should never get this soap error from the server: %@", fault.faultstring);
		break;
		
		case FLZenfolioErrorCodeAccountLocked:
			[stringBuilder appendLine:NSLocalizedString(@"Your Zenfolio account is Locked", nil)];
			
			[stringBuilder endLine];
			[stringBuilder appendLine:NSLocalizedString(@"Please log into the website to correct this problem.", nil)];
		break;
		
		case FLZenfolioErrorCodeInvalidParam:
			[stringBuilder appendLine:NSLocalizedString(@"An application error has occurred", nil)];
			[stringBuilder endLine];
			[stringBuilder appendLine:NSLocalizedString(@"Please try what you were doing again and if it continues to fail, please contact Zenfolio support and report this issue.", nil)];
		break;
		
		case FLZenfolioErrorCodeNoSuchObject:
			[stringBuilder appendLine:NSLocalizedString(@"An item no longer exists on the server", nil)];
			[stringBuilder endLine];
            [stringBuilder appendLine:NSLocalizedString(@"This may mean that the application is out of sync. Please try what you were doing again, or try refreshing your current view.", nil)];
		break;
		
		case FLZenfolioErrorCodeNotAuthorized: 
			[stringBuilder appendLine:NSLocalizedString(@"You do not have access to this item.", nil)];
			[stringBuilder endLine];
			[stringBuilder appendLine:NSLocalizedString(@"Please contact the owner and ask for access if this is appropriate.", nil)];
		break;
		
		case FLZenfolioErrorCodeNotAuthenticated:
			[stringBuilder appendLine:NSLocalizedString(@"You are not authenticated.", nil)];
			[stringBuilder endLine];
			[stringBuilder appendLine:NSLocalizedString(@"Please login in again to correct this problem.", nil)];
		break;
	}
	
#if DEBUG
    [stringBuilder endLine];
    [stringBuilder appendLineWithFormat:@"(DEBUG ONLY) Soap fault:%@ faultstring:%@", fault.faultcode, fault.faultstring];
#endif
	
    NSDictionary* userInfo = 
        [NSDictionary dictionaryWithObjectsAndKeys:fault, FLUnderlyingSoapFaultKey, [stringBuilder string], NSLocalizedDescriptionKey, nil]; 
        
    return [NSError errorWithDomain:FLZenfolioErrorDomain code:error userInfo:userInfo];
}



@end
