//
//  FLMobileConnectTheme.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLLabelWidget.h"
#import "FLTextDescriptor.h"

@protocol FLMobileConnectTheme <NSObject> 
- (void) applyThemeToNameInTable:(FLLabelWidget*) widget;
- (void) applyThemeToMessageInTable:(FLLabelWidget*) widget;
- (FLTextDescriptor*) textDescriptorForMessageTextInTable;
@end