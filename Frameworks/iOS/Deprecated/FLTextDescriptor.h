//
//	FLTextDescriptor.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/1/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
	unsigned int disabled : 1;
	unsigned int highlighted : 1;
	unsigned int selected: 1; 
} FLTextDescriptorState;

@interface FLTextDescriptor : NSObject<NSCopying> {
@private
	UIColor* _enabledColor;
	UIColor* _enabledShadowColor;
	UIColor* _disabledColor;
	UIColor* _disabledShadowColor;
	UIColor* _highlightedColor;
	UIColor* _highlightedShadowColor;
	UIColor* _selectedColor;
	UIColor* _selectedShadowColor;
	UIFont* _font;
    FLSize _shadowOffset;
}

- (id) initWithFont:(UIFont*) font
	enabledColor:(UIColor*) enabledColor
	enabledShadowColor:(UIColor*) enabledShadowColor
	disabledColor:(UIColor*) disabledColor
	disabledShadowColor:(UIColor*) disabledShadowColor
	highlightedColor:(UIColor*) highlightedColor
	highlightedShadowColor:(UIColor*) highlightedShadowColor
	selectedColor:(UIColor*) selectedColor
	selectedShadowColor:(UIColor*) selectedShadowColor
	shadowOffset:(FLSize) shadowOffset;	   // default is FLSizeMake(0, -1) -- a top shadow
	
+ (FLTextDescriptor*) textDescriptor:(UIFont*) font
	enabledColor:(UIColor*) enabledColor
	enabledShadowColor:(UIColor*) enabledShadowColor
	disabledColor:(UIColor*) disabledColor
	disabledShadowColor:(UIColor*) disabledShadowColor
	highlightedColor:(UIColor*) highlightedColor
	highlightedShadowColor:(UIColor*) highlightedShadowColor
	selectedColor:(UIColor*) selectedColor
	selectedShadowColor:(UIColor*) selectedShadowColor
	shadowOffset:(FLSize) shadowOffset;

+ (FLTextDescriptor*) textDescriptor;

@property (readwrite, retain, nonatomic)	 UIFont* font;

@property (readwrite, retain, nonatomic)	 UIColor* enabledColor;
@property (readwrite, retain, nonatomic)	 UIColor* enabledShadowColor;

@property (readwrite, retain, nonatomic)	 UIColor* disabledColor;
@property (readwrite, retain, nonatomic)	 UIColor* disabledShadowColor;

@property (readwrite, retain, nonatomic)	 UIColor* highlightedColor;
@property (readwrite, retain, nonatomic)	 UIColor* highlightedShadowColor;

@property (readwrite, retain, nonatomic)	 UIColor* selectedColor;
@property (readwrite, retain, nonatomic)	 UIColor* selectedShadowColor;

@property (readwrite, assign, nonatomic)	 FLSize	 shadowOffset;	  // default is FLSizeMake(0, -1) -- a top shadow

- (UIColor*) textColorForState:(FLTextDescriptorState) state;
- (UIColor*) shadowColorForState:(FLTextDescriptorState) state;

@end