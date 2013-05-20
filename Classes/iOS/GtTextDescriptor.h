//
//	GtTextDescriptor.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/1/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

typedef struct {
	unsigned int disabled : 1;
	unsigned int highlighted : 1;
	unsigned int selected: 1; 
} GtTextDescriptorState;

@interface GtTextDescriptor : NSObject<NSCopying> {
@private
	UIFont* m_font;
	
	//text
	UIColor* m_enabledColor;
	UIColor* m_disabledColor;
	UIColor* m_highlightedColor;
	UIColor* m_selectedColor;
	UIColor* m_selectedShadowColor;
	//shadow
	UIColor* m_enabledShadowColor;
	UIColor* m_disabledShadowColor;
	UIColor* m_highlightedShadowColor;
	
	CGSize m_shadowOffset;
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
	shadowOffset:(CGSize) shadowOffset;	   // default is CGSizeMake(0, -1) -- a top shadow
	
+ (GtTextDescriptor*) textDescriptor:(UIFont*) font
	enabledColor:(UIColor*) enabledColor
	enabledShadowColor:(UIColor*) enabledShadowColor
	disabledColor:(UIColor*) disabledColor
	disabledShadowColor:(UIColor*) disabledShadowColor
	highlightedColor:(UIColor*) highlightedColor
	highlightedShadowColor:(UIColor*) highlightedShadowColor
	selectedColor:(UIColor*) selectedColor
	selectedShadowColor:(UIColor*) selectedShadowColor
	shadowOffset:(CGSize) shadowOffset;

+ (GtTextDescriptor*) textDescriptor;

@property (readwrite, retain, nonatomic)	 UIFont* font;

@property (readwrite, retain, nonatomic)	 UIColor* enabledColor;
@property (readwrite, retain, nonatomic)	 UIColor* enabledShadowColor;

@property (readwrite, retain, nonatomic)	 UIColor* disabledColor;
@property (readwrite, retain, nonatomic)	 UIColor* disabledShadowColor;

@property (readwrite, retain, nonatomic)	 UIColor* highlightedColor;
@property (readwrite, retain, nonatomic)	 UIColor* highlightedShadowColor;

@property (readwrite, retain, nonatomic)	 UIColor* selectedColor;
@property (readwrite, retain, nonatomic)	 UIColor* selectedShadowColor;

@property (readwrite, assign, nonatomic)	 CGSize	 shadowOffset;	  // default is CGSizeMake(0, -1) -- a top shadow

- (UIColor*) textColorForState:(GtTextDescriptorState) state;
- (UIColor*) shadowColorForState:(GtTextDescriptorState) state;

@end