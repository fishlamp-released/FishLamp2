//
//	FLSoapNetworkRequestBehavior.m
//	FishLampCoreLib
//
//	Created by Mike Fullerton on 11/7/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLSoapOperationDelegate.h"
#import "FLSoapNetworkConnection.h"
#import "FLWebServiceManager.h"
#import "FLSoapParser.h"
#import "FLSoapError.h"
#import "FLSoapFault11.h"
#import "FLSoapStringBuilder.h"

@implementation FLSoapOperationDelegate 

@synthesize authenticator = _authenticator;

#if FL_MRC
- (void) dealloc {
    [_authenticator release];
    [super dealloc];
}
#endif

- (FLHttpConnection*) httpOperationCreateConnection:(FLHttpOperation*) operation {
	
    NSDictionary* info = operation.serverContext.properties;

	operation.URL = [NSURL URLWithString:[info objectForKey:FLNetworkServerPropertyKeyUrl]]; 

	NSString* functionName = operation.operationName;
	FLAssertStringIsNotEmpty_v(functionName, nil);
	
	NSString* namespace = [info objectForKey:FLNetworkServerPropertyKeyTargetNamespace];
	
	FLSoapNetworkConnection* connection = [FLSoapNetworkConnection soapRequest: operation.URL
								soapActionHeader: [info objectForKey:functionName]
								soapApiNamespace: namespace];
	
	[connection.soap.body addObjectAsFunction:functionName object:operation.input xmlNamespace:namespace];
	
    if(self.authenticator) {
        [self.authenticator authenticateConnection:connection withAuthenticatedOperation:operation];
    }
    
	return connection;
}

- (void) httpOperationWillRun:(FLHttpOperation*) operation {

    if(operation.isSecure && operation.isAuthenticated) {
        if(self.authenticator) {
            [self.authenticator authenticateOperationSynchronously:operation];
        }

        operation.isAuthenticated = YES;
    }
}


#define MAX_ERR_LEN 500

- (FLSoapFault11*) checkForSoapFault:(NSData*) data {
	if(data && data.length >0 ) {
		char* first = strnstr((const char*) [data bytes], "Fault", MIN([data length], (unsigned int) MAX_ERR_LEN));
		if(first) {
			FLSoapFault11* soapFault = [FLSoapFault11 soapFault11];
			FLSoapParser* soapParser = [[FLSoapParser alloc] initWithXmlData:data];

			@try {
				[soapParser buildObjects:soapFault];
				FLDebugLog(@"Soap Fault:%@/%@", [soapFault faultcode], [soapFault faultstring]);
			}
			@finally {
				mrc_release_(soapParser);
			}
            return soapFault;
		}
	}

	return nil;
}

- (void) parseXmlResponse:(NSData*) data object:(id) object {
	FLSoapParser* soapParser = [[FLSoapParser alloc] initWithXmlData:data];
	@try {
		[soapParser buildObjects:object];
	}
	@finally {
		release_(soapParser);
	}
}

- (void) handleSoapFault:(FLSoapFault11*) fault {
    FLThrowError_([NSError errorWithSoapFault:fault]);
}

- (void) operationDidRun:(FLHttpOperation*) operation {

    NSData* data = operation.httpResponse.responseData;
    FLSoapFault11* fault = [self checkForSoapFault:data];
    if(fault) {
        [self handleSoapFault:fault];
    }
    
    FLThrowIfError_([operation.httpResponse simpleHttpResponseErrorCheck]);
   
     [self parseXmlResponse:data object:[operation output]];
}


@end
