//
//	GtToolbar.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/17/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtAutoLayoutViewController.h"

@interface GtToolbar : UIToolbar {
@private
	GtThemeState m_themeState;
}

@end

@interface GtToolbarViewController : GtAutoLayoutViewController {
}

- (id) initWithToolbar:(GtToolbar*) toolbar;
+ (id) toolbarViewController:(GtToolbar*) toolbar;

@property (readonly, retain, nonatomic) GtToolbar* toolbar;

@end