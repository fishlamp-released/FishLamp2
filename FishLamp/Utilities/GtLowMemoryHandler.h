//
//  GtLowMemoryHandler.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/24/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

@interface GtLowMemoryHandler : NSObject {
@private
	NSMutableArray* m_responderClasses; 
	NSMutableArray* m_responders; 
}

GtSingletonProperty(GtLowMemoryHandler);

- (void) handleLowMemoryNotification:(id)sender;

- (void) addResponderByClass:(Class) inClass; // + (void) handleLowMemoryNotificationForClass:(id)sender
- (void) addResponder:(Class) inClass; // - (void) handleLowMemoryNotification:(id) sender

+ (void) broadcastReleaseMessage;

@end
