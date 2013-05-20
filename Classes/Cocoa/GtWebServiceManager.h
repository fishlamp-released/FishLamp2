//
//	GtSoapWebServiceManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/13/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtNetworkServerContext.h"

@interface GtWebServiceManager : GtNetworkServerContext {
}

@property (readonly, retain, nonatomic) NSString* url;
@property (readonly, retain, nonatomic) NSString* targetNamespace;
@end
