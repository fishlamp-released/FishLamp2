//
//  GtTheme.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/7/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

typedef enum {
	GtThemeTextSizeSmall,
	GtThemeTextSizeMedium,
	GtThemeTextSizeLarge,
} GtThemeTextSize;

#import "GtSavedThemeInfo.h"

@interface GtTheme : NSObject {
@private 
	GtThemeTextSize m_textSize;
	NSString* m_name;
}

- (id) initWithSavedThemeInfo:(GtSavedThemeInfo*) info; 

@property (readwrite, retain, nonatomic) NSString* name;
@property (readwrite, assign, nonatomic) GtThemeTextSize fontSize;

@end

