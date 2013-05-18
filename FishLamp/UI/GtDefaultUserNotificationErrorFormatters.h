//
//  GtDefaultUserNotificationErrorFormatters.h
//  MyZen
//
//  Created by Mike Fullerton on 1/2/10.
//  Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "GtUserNotificationView.h"

extern void InstallDefaultUserNotificationErrorFormatters();

@interface NSUrlErrorDomainErrorFormatter : NSObject<GtUserNotificationErrorFormatterProtocol>
@end

@interface NSUrlErrorDomainWarningFormatter : NSObject<GtUserNotificationErrorFormatterProtocol>
@end


@interface NSPOSIXErrorDomainErrorFormatter : NSObject<GtUserNotificationErrorFormatterProtocol>
@end

@interface NSCocoaErrorDomainErrorFormatter : NSObject<GtUserNotificationErrorFormatterProtocol>
@end

@interface CFNetworkDomainErrorFormatter : NSObject<GtUserNotificationErrorFormatterProtocol>
@end

@interface GtSoapFaultErrorDomainErrorFormatter : NSObject<GtUserNotificationErrorFormatterProtocol>
@end
