//
//  FLProgressDisplay.h
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCocoaUIRequired.h"

#import "FLProgressViewProtocol.h"

/// @brief A block with a abstract progressViewController as a parameter.
typedef void (^FLProgressViewControllerBlock)(id progress);

/// @brief FLProgressViewController is protocol describing simple API progress.
/// The controller does not have to be a view controller.
/// Also the implementer of this protocol SHOULD implement all of the methods
/// in the FLProgressViewController, though it's enclosed view may or may
/// not implement the protocol.
@protocol FLProgressViewController <FLProgressView>

/// @brief The progress view. 
/// May or may not conform to the FLProgressView protocol.
@property (readonly, retain, nonatomic) id progressView;

/// @brief Event that fires when the progress will show
/// @returns The block for the event.
@property (readwrite, copy, nonatomic) FLProgressViewControllerBlock onShowProgress;

/// @brief Event that fires whent the progress will show.
/// @returns The block for the event.
@property (readwrite, copy, nonatomic) FLProgressViewControllerBlock onHideProgress;

/// @brief Is the progress hidden?
/// @returns YES if hidden
@property (readonly, assign, nonatomic) BOOL isProgressHidden;

/// @brief Show the progress.
- (void) showProgress;

/// @brief Hide the progress.
- (void) hideProgress;
@end

