//
//	FLDefaultUserNotificationErrorFormatters.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/2/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
@interface FLNetworkErrorCodeSoapFaultDomainErrorFormatter : NSObject<FLErrorDescriber>
@end
