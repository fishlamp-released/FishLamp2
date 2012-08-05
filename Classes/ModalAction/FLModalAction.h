//
//	FLModalAction.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
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