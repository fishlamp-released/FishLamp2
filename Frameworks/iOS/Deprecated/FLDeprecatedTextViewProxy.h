//
//	UIView+FLTextView.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UITextField.h>
#import <UIKit/UITextView.h>
#import <UIKit/UILabel.h>

// to help deal with various text views polymorphically...
// they're here just for the compiler and get and set nothing.

//@interface UIView (FLTextView) 
//@property(nonatomic,copy)	  NSString		 *text;			   // default is nil
//@property(nonatomic,retain) UIFont		 *font;			   // default is nil (system font 17 plain)
//@property(nonatomic,retain) UIColor *textColor;
//@property(nonatomic)		  UITextAlignment		  textAlignment; 
//@end

// TODO: Get rid of this.


#import "FLTextDescriptor.h"

@interface FLDeprecatedTextViewProxy : NSObject {
	id _proxiedView;
}

- (id) initWithView:(UIView*) view;

@property(readwrite, retain, nonatomic) UIView* view; 

@property(nonatomic,copy)	NSString* text;			   // default is nil
@property(nonatomic,retain) UIFont* font;			 // default is nil (system font 17 plain)
@property(nonatomic,retain) UIColor* textColor;
@property(nonatomic)		UITextAlignment			textAlignment; 

@property (readonly, assign, nonatomic) BOOL viewIsLabelView;
@property (readonly, assign, nonatomic) BOOL viewIsTextField;
@property (readonly, assign, nonatomic) BOOL viewIsTextView;

- (UILabel*) labelView;
- (UITextField*) textField;
- (UITextView*) textView;

// not all of the proxied views respond to these selectors, if not, it's a no-op
@property (nonatomic, retain, readwrite) UIColor* shadowColor; 
@property (nonatomic, assign, readwrite) FLSize shadowOffset;

@property (nonatomic, copy, readwrite) FLTextDescriptor* textDescriptor;

@property (readonly, assign, nonatomic) UILineBreakMode lineBreakMode;

@end
