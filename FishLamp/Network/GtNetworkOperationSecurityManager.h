//
//  GtNetworkOperationSecurityManager.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtNetworkOperation.h"

@interface GtNetworkOperationSecurityManager : NSObject {
@private
	NSMutableDictionary* m_exceptions;
	BOOL m_operationsAreSecureByDefault;
}

GtSingletonProperty(GtNetworkOperationSecurityManager);

@property (readwrite, assign, nonatomic) BOOL operationsAreSecureByDefault;

- (void) addSecurityBehaviorForClass:(Class) class isSecure:(BOOL) isSecure;

- (BOOL) operationIsSecure:(id<GtNetworkOperationProtocol>) operation;

@end
