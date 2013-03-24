//
//  FLGlobalNetworkActivityIndicator.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

extern NSString* const FLGlobalNetworkActivityShow;
extern NSString* const FLGlobalNetworkActivityHide;

@interface FLGlobalNetworkActivityIndicator : NSObject {
@private
    NSInteger _busyCount;
    BOOL _showing;
}
FLSingletonProperty(FLGlobalNetworkActivityIndicator);

@property (readwrite, assign, getter=isNetworkBusy) BOOL networkBusy;

@end

