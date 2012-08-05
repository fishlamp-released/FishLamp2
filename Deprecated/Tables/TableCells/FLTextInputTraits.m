//
//	FLTextInputTraits.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/4/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLTextInputTraits.h"

@implementation FLTextInputTraits

@synthesize autocapitalizationType; // default is UITextAutocapitalizationTypeNone
@synthesize autocorrectionType;			// default is UITextAutocorrectionTypeDefault
@synthesize keyboardType;						  // default is UIKeyboardTypeDefault
@synthesize keyboardAppearance;				// default is UIKeyboardAppearanceDefault
@synthesize returnKeyType;						 // default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
@synthesize enablesReturnKeyAutomatically;					// default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
@synthesize secureTextEntry;
@synthesize clearsOnBeginEditing;

- (id) init
{
	if((self = [super init]))
	{
		self.autocapitalizationType = UITextAutocapitalizationTypeNone;
		self.autocorrectionType = UITextAutocorrectionTypeDefault;
		self.keyboardType =	 UIKeyboardTypeDefault;
		self.keyboardAppearance = UIKeyboardAppearanceDefault;
		self.returnKeyType = UIReturnKeyDefault;
		self.enablesReturnKeyAutomatically = NO;
		self.secureTextEntry = NO;
	}
	
	return self;
}

- (void) copyTextInputTraitsToControl:(id<UITextInputTraits>) control
{
	control.autocorrectionType = self.autocorrectionType;
	control.autocapitalizationType = self.autocapitalizationType;
	control.keyboardType =	self.keyboardType;
	control.keyboardAppearance = self.keyboardAppearance;
	control.returnKeyType =	 self.returnKeyType;
	control.enablesReturnKeyAutomatically = self.enablesReturnKeyAutomatically;
	control.secureTextEntry = self.secureTextEntry;
	
	if([control isKindOfClass:[UITextField class]])
	{
		[((UITextField*)control) setClearsOnBeginEditing:self.clearsOnBeginEditing];
	}
}

@end