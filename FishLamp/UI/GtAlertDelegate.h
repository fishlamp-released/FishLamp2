//
//  GtAlert.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/5/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE

@interface GtAlertDelegate : NSObject <UIAlertViewDelegate> {
	NSInvocation *m_callback;
}

- (id) initWithSelector:(NSObject*) object selector: (SEL) selector;

@end
#endif