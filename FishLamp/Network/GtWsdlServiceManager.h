//
//  GtWsdlServiceManager.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/13/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtObject.h"
#import "GtWsdlOperation.h"
#import "GtAction.h"
#import "GtWebRequestSecurityHandler.h"
#import "GtReachability.h"

@interface GtWsdlServiceManager : GtObject {
@private
	GtWebRequestSecurityHandler* m_soapSecurityHandler;
	GtReachability* m_reachability;
}

+ (GtWsdlServiceManager*) primaryServiceManager;
+ (void) setPrimaryServiceManager:(GtWsdlServiceManager*) primary;

@property (readonly, assign, nonatomic) NSString* url;
@property (readonly, assign, nonatomic) NSString* targetNamespace;
@property (readwrite, assign, nonatomic) GtWebRequestSecurityHandler* webRequestSecurityHandler;

@property (readwrite, assign, nonatomic) NSString* reachabilityHost;
@property (readonly, assign, nonatomic) GtReachability* reachability;

@end
