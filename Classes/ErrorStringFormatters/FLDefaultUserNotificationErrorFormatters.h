//
//	FLDefaultUserNotificationErrorFormatters.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/2/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLOldUserNotificationView.h"
#import "FLErrorDescriber.h"

extern void InstallDefaultUserNotificationErrorFormatters();

@interface NSUrlErrorDomainErrorFormatter : NSObject<FLErrorDescriber>
@end

/*@interface NSPOSIXErrorDomainErrorFormatter : NSObject<FLErrorDescriber>
@end

@interface NSCocoaErrorDomainErrorFormatter : NSObject<FLErrorDescriber>
@end
*/
/*
@interface CFNetworkDomainErrorFormatter : NSObject<FLErrorDescriber>
@end
*/
@interface FLSoapFaultErrorDomainErrorFormatter : NSObject<FLErrorDescriber>
@end
