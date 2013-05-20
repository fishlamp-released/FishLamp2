//
//	GtDefaultUserNotificationErrorFormatters.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/2/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUserNotificationView.h"
#import "GtErrorDescriber.h"

extern void InstallDefaultUserNotificationErrorFormatters();

@interface NSUrlErrorDomainErrorFormatter : NSObject<GtErrorDescriber>
@end

/*@interface NSPOSIXErrorDomainErrorFormatter : NSObject<GtErrorDescriber>
@end

@interface NSCocoaErrorDomainErrorFormatter : NSObject<GtErrorDescriber>
@end
*/
/*
@interface CFNetworkDomainErrorFormatter : NSObject<GtErrorDescriber>
@end
*/
@interface GtSoapFaultErrorDomainErrorFormatter : NSObject<GtErrorDescriber>
@end
