//
//	GtPinEditingView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@protocol GtPinEditingViewDelegate;

@interface GtPinEditingView : UIView {
@private
	NSMutableArray* m_buttons;
	NSMutableArray* m_numberLabels;
	UILabel* m_titleLabel;
	id<GtPinEditingViewDelegate> m_delegate;
	NSString* m_pinToCheck;
	NSUInteger m_attemptCount;
	NSUInteger m_maxAttempts;
	BOOL m_pinCheckMode;
	BOOL m_checkingNewPinMode;
	
	UILabel* m_errorLabel;
}

@property (readonly, retain, nonatomic) NSString* pinToCheckAgainst;
@property (readwrite, assign, nonatomic) id<GtPinEditingViewDelegate> delegate;
@property (readwrite, retain, nonatomic) UIColor* borderColor;
@property (readwrite, assign, nonatomic) CGFloat cornerRadius;
@property (readwrite, assign, nonatomic) CGFloat borderWidth;

@property (readonly, retain, nonatomic) NSString* pin;

- (void) setPinCheckMode:(NSString*) pinToCheck maxAttempts:(NSUInteger) maxAttempts;

@end

@protocol GtPinEditingViewDelegate <NSObject>
- (void) pinEditViewDidCancel:(GtPinEditingView*) pinEditingView;
- (void) pinEditView:(GtPinEditingView*) pinEditingView didSetPin:(NSString*) pin;
- (void) pinEditViewUserDidEnterCorrectPin:(GtPinEditingView*) pinEditingView;

@end