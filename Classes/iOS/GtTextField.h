//
//	GtTextField.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtTextDescriptor.h"
#import "GtViewLayout.h"

@interface GtTextField : UITextField {
@private
	BOOL m_canResign;
	GtTextDescriptor* m_textDescriptor;
	GtTextDescriptor* m_placeholderTextDescriptor;
	GtTextDescriptorState m_state;
	GtThemeState m_themeState;
	UIEdgeInsets m_viewLayoutMargins;
}

@property (readwrite, assign, nonatomic) BOOL canResignFirstResponder;
@property (readwrite, copy, nonatomic) GtTextDescriptor* textDescriptor;
@property (readwrite, copy, nonatomic) GtTextDescriptor* placeholderTextDescriptor;
@property (readwrite, assign, nonatomic) UIEdgeInsets viewLayoutMargins;// these are deltas when used with 

@end
