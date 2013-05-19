//
//	FLModalAction.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLPerformSelectorOperation.h"
#import "FLAction.h"

@interface FLModalAction : FLAction {
	FLPerformSelectorOperation* _operation;
}
- (id) initWithProgressText:(NSString*) title;

@property (readonly, retain, nonatomic) FLPerformSelectorOperation* operation;

@end