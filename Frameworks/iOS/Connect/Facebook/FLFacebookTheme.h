//
//  FLFacebookTheme.h
//  fBee
//
//  Created by Mike Fullerton on 6/2/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLTextDescriptor.h"

@protocol FLFacebookTheme <NSObject>

- (void) applyThemeToNameInTable:(FLLabelWidget*) widget;
- (void) applyThemeToMessageInTable:(FLLabelWidget*) widget;
- (FLTextDescriptor*) textDescriptorForMessageTextInTable;

@end
