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


@interface FLSoapServerInfo()
@property (readwrite, strong) NSDictionary* serverInfo;
@end

@implementation FLSoapServerInfo

@synthesize serverInfo = _soapServerInfo;

- (id) initWithDictionary:(NSDictionary*) dictionary {
    self = [super init];
    if(self) {  
        self.serverInfo = dictionary;
    }
    return self;
}

+ (FLSoapServerInfo*) soapServerInfo:(NSDictionary*) dictionary {
    return autorelease_([[[self class] alloc] initWithDictionary:dictionary]);
}

#if FL_MRC
- (void) dealloc {
    [_serverInfo release];
    [super dealloc];
}
#endif

- (NSURL*) serverURL {
    return [_soapServerInfo objectForKey:FLNetworkServerPropertyKeyUrl];
}

- (NSString*) soapNamespace {
    return [_soapServerInfo objectForKey:FLNetworkServerPropertyKeyTargetNamespace];
}

- (NSString*) soapActionHeaderForOperationName:(NSString*) operationName {
    FLAssertStringIsNotEmpty_v(operationName, nil);
	return [_soapServerInfo objectForKey:operationName];
}

@end


@implementation FLSoapOperationDelegate 

@synthesize authenticator = _authenticator;
@synthesize soapServerInfo = _soapServerInfo;

#if FL_MRC
- (void) dealloc {
    [_soapServerInfo release];
    [_soapNamespace release];
    [_authenticator release];
    [super dealloc];
}
#endif


- (FLHttpConnection*) httpOperationCreateConnection:(FLHttpOperation*) operation {
	
    FLAssertStringIsNotEmpty_(self.soapServerInfo.serverURL.absoluteString);
    FLAssertStringIsNotEmpty_(self.soapServerInfo.soapNamespace);
	NSString* functionName = operation.operationName;
	operation.URL = self.soapServerInfo.serverURL;
	NSString* namespace = self.soapServerInfo.soapNamespace;
    NSString* header = [self.soapServerInfo soapActionHeaderForOperationName:functionName];
   
	FLSoapNetworkConnection* connection = [FLSoapNetworkConnection soapRequest:operation.URL
                                                              soapActionHeader:header 
                                                              soapApiNamespace:namespace];
	
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
