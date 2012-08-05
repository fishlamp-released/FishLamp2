//
//  FLNotificationViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/23/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAutoPositionedViewController.h"

@interface FLNotificationViewController : FLAutoPositionedViewController {
}
@end

#import "FLAction.h"

@interface FLActionErrorNotificationHandler : NSObject<FLActionErrorDelegate>

FLSingletonProperty(FLActionErrorNotificationHandler);

@end

