//
//  GtThemeChooserViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/7/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtEditObjectViewController.h"
#import "GtSavedThemeInfo.h"
#import "GtUserSession.h"

@interface GtThemeChooserViewController : GtEditObjectViewController {
@private
	GtSavedThemeInfo* m_savedThemeInfo;
}

@end
