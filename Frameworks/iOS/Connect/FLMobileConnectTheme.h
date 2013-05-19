//
//  FLMobileConnectTheme.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLLabelWidget.h"
#import "FLTextDescriptor.h"

@protocol FLMobileConnectTheme <NSObject> 
- (void) applyThemeToNameInTable:(FLLabelWidget*) widget;
- (void) applyThemeToMessageInTable:(FLLabelWidget*) widget;
- (FLTextDescriptor*) textDescriptorForMessageTextInTable;
@end