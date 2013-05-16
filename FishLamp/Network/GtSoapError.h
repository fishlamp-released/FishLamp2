//
//  GtSoapError.h
//  MyZen
//
//  Created by Mike Fullerton on 12/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtSoapFault11.h"

#define GtSoapFaultDomain @"GtSoapErrorDomain"

@interface NSError (GtSoapExtras) 

- (id) initWithSoapFault:(GtSoapFault11*) fault;

- (BOOL) isSoapError;
- (GtSoapFault11*) soapFault;

@end
