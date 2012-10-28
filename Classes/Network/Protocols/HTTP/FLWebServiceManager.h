//
//	FLSoapWebServiceManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLNetworkServerContext.h"

@interface FLWebServiceManager : FLNetworkServerContext {
}

@property (readonly, retain, nonatomic) NSString* url;
@property (readonly, retain, nonatomic) NSString* targetNamespace;
@end
