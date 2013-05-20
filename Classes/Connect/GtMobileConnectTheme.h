//
//  GtMobileConnectTheme.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtLabelWidget.h"
#import "GtTextDescriptor.h"

@protocol GtMobileConnectTheme <NSObject> 
- (void) applyThemeToNameInTable:(GtLabelWidget*) widget;
- (void) applyThemeToMessageInTable:(GtLabelWidget*) widget;
- (GtTextDescriptor*) textDescriptorForMessageTextInTable;
@end