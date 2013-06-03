//
//  FLNotificationViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/23/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAutoPositionedViewController.h"

@interface FLNotificationViewController : FLAutoPositionedViewController {
}
@end

#import "FLAction.h"

@interface FLActionErrorNotificationHandler : NSObject<FLActionErrorDelegate>

FLSingletonProperty(FLActionErrorNotificationHandler);

@end

