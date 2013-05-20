//
//	GtTextView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/1/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>


#import "GtTextDescriptor.h"
#import "GtLabel.h"

@interface GtTextView : UITextView {
@private
	BOOL m_canResign;
	GtTextDescriptor* m_textDescriptor;
	GtTextDescriptorState m_state;
	GtThemeState m_themeState;
	
	UIEdgeInsets m_edgeInsets;
	BOOL m_useEnforceEdgeInsets;
	
	GtLabel* m_placeholderTextLabel;
	
	UIEdgeInsets m_viewLayoutMargins;
}


@property (readwrite, assign, nonatomic) UIEdgeInsets enforcedEdgeInsets;
@property (readwrite, assign, nonatomic) BOOL useEnforcedEdgeInsets;

@property (readwrite, copy, nonatomic) GtTextDescriptor* textDescriptor;
@property (readwrite, nonatomic, assign, getter=isEnabled)				  BOOL enabled; // same as editable (superclass), here for compatibility

@property (readonly, retain, nonatomic) GtLabel* placeholderTextLabel;
@property (readwrite, retain, nonatomic) NSString* placeholderText;

- (void) updatePlaceholderTextVisibility;

- (void) setCanResignFirstResponder:(BOOL) canResign;

@property (readwrite, assign, nonatomic) UIEdgeInsets viewLayoutMargins;// these are deltas when used with 

@end

@interface UITextView (Extras)
- (void) insertStringAtSelection:(NSString*) string;
@end