//
//  FLURLErrorDomain.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSURLErrorDomainGenericDescriber.h"
#import "FLPrettyString.h"

//#import <CFNetwork/CFNetworkErrors.h>

@implementation NSURLErrorDomainGenericDescriber


- (NSString*) descriptionForErrorCode:(NSInteger) errorCode {
 
    FLPrettyString* text = [FLPrettyString prettyString];
	
    switch(errorCode)
    {
        case NSURLErrorUserAuthenticationRequired:
            [text appendLine:NSLocalizedString(@"Authentication Required.", nil)];
            break;
    
        case NSURLErrorTimedOut:
            [text appendLine:NSLocalizedString(@"The server is not responding.", nil)];
//			[text appendLine];
//			[text appendLine:MovePhone];
            break;

        case kCFURLErrorNotConnectedToInternet:
            [text appendLine:NSLocalizedString(@"A network connection can't be found.", nil)];
            [text appendLine];
            [text appendLine:NSLocalizedString(@"Please try again when you have a network connection.", nil)];
            break;
            
        case NSURLErrorNetworkConnectionLost:
            [text appendLine:NSLocalizedString(@"The network connection was lost.", nil)];
//			[text appendLine];
//			[text appendLine:MovePhone];
            break;

        case NSURLErrorCannotFindHost:
        case NSURLErrorCannotConnectToHost:		
            [text appendLine:NSLocalizedString(@"Unable to connect to server.", nil)];
//			[text appendLine];
            break;

        default:
            [text appendLine:NSLocalizedString(@"A network error occured.", nil)];
            break;
    }

	return [text string];
}

@end
