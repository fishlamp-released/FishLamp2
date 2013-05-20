//
//	FLTextView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/1/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>


#import "FLTextDescriptor.h"
#import "FLLabel.h"

@interface FLTextView : UITextView {
@private
	BOOL _canResign;
	FLTextDescriptor* _textDescriptor;
	FLTextDescriptorState _state;
	
	UIEdgeInsets _edgeInsets;
	BOOL _useEnforceEdgeInsets;
	
	FLLabel* _placeholderTextLabel;
	
	UIEdgeInsets _viewLayoutMargins;
}


@property (readwrite, assign, nonatomic) UIEdgeInsets enforcedEdgeInsets;
@property (readwrite, assign, nonatomic) BOOL useEnforcedEdgeInsets;

@property (readwrite, copy, nonatomic) FLTextDescriptor* textDescriptor;
@property (readwrite, nonatomic, assign, getter=isEnabled)				  BOOL enabled; // same as editable (superclass), here for compatibility

@property (readonly, retain, nonatomic) FLLabel* placeholderTextLabel;
@property (readwrite, retain, nonatomic) NSString* placeholderText;

- (void) updatePlaceholderTextVisibility;

- (void) setCanResignFirstResponder:(BOOL) canResign;

@property (readwrite, assign, nonatomic) UIEdgeInsets viewLayoutMargins;// these are deltas when used with 

@end

@interface UITextView (Extras)
- (void) insertStringAtSelection:(NSString*) string;
@end