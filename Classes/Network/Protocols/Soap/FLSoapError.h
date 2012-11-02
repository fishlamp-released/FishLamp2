//
//	FLSoapError.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"
#import "FLFrameworkErrorDomain.h"
#import "FLSoapFault11.h"
#import "FLErrorDomain.h"
#import "NSError+FLExtras.h"

#define FLUnderlyingSoapFaultKey @"FLUnderlyingSoapFaultKey"

@interface NSError (FLSoapExtras) 

@property (readonly, strong, nonatomic) FLSoapFault11* soapFault;

+ (id) errorWithSoapFault:(FLSoapFault11*) fault;
- (id) initWithSoapFault:(FLSoapFault11*) fault;

@end
