//
//	GtModalAction.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtPerformSelectorOperation.h"
#import "GtAction.h"

@interface GtModalAction : GtAction {
	GtPerformSelectorOperation* m_operation;
}
- (id) initWithProgressText:(NSString*) title;

@property (readonly, retain, nonatomic) GtPerformSelectorOperation* operation;

@end