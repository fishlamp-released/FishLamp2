//
//  FLFacebookTheme.h
//  fBee
//
//  Created by Mike Fullerton on 6/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLTextDescriptor.h"

@protocol FLFacebookTheme <NSObject>

- (void) applyThemeToNameInTable:(FLLabelWidget*) widget;
- (void) applyThemeToMessageInTable:(FLLabelWidget*) widget;
- (FLTextDescriptor*) textDescriptorForMessageTextInTable;

@end
