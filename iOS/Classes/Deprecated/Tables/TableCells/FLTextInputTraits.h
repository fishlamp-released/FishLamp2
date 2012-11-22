//
//	FLTextInputTraits.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/4/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FLTextInputTraits : NSObject<UITextInputTraits>
{
	UITextAutocapitalizationType autocapitalizationType; // default is UITextAutocapitalizationTypeNone
	UITextAutocorrectionType autocorrectionType;		 // default is UITextAutocorrectionTypeDefault
	UIKeyboardType keyboardType;						 // default is UIKeyboardTypeDefault
	UIKeyboardAppearance keyboardAppearance;			 // default is UIKeyboardAppearanceDefault
	UIReturnKeyType returnKeyType;						 // default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
	BOOL enablesReturnKeyAutomatically;					 // default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
	BOOL secureTextEntry;
	BOOL clearsOnBeginEditing;
}

@property(nonatomic) UITextAutocapitalizationType autocapitalizationType; // default is UITextAutocapitalizationTypeNone
@property(nonatomic) UITextAutocorrectionType autocorrectionType;		  // default is UITextAutocorrectionTypeDefault
@property(nonatomic) UIKeyboardType keyboardType;						  // default is UIKeyboardTypeDefault
@property(nonatomic) UIKeyboardAppearance keyboardAppearance;			  // default is UIKeyboardAppearanceDefault
@property(nonatomic) UIReturnKeyType returnKeyType;						  // default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
@property(nonatomic) BOOL enablesReturnKeyAutomatically;				  // default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
@property(nonatomic,getter=isSecureTextEntry) BOOL secureTextEntry;		 // default is NO

@property(nonatomic) BOOL clearsOnBeginEditing;							// only for single line text entry

- (void) copyTextInputTraitsToControl:(id<UITextInputTraits>) control;

@end
