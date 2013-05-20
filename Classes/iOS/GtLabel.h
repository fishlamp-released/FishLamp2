//
//	GtLabel.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtTextDescriptor.h"

@interface GtLabel : UILabel {
@private
	BOOL m_underline;
	GtTextDescriptor* m_textDescriptor;
	GtTextDescriptorState m_state;
	GtThemeState m_themeState;
}

@property (readwrite, assign, nonatomic) BOOL willUnderline;
@property (readwrite, assign, nonatomic, getter=isSelected) BOOL selected;

@property (readwrite, copy, nonatomic) GtTextDescriptor* textDescriptor;

@end