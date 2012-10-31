//
//  FLEditableItemView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/12/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLEditableItemView.h"

@interface FLEditableItemView ()
@property (readwrite, strong, nonatomic) UILabel* label;
@property (readwrite, strong, nonatomic) UITextField* value;
@end

@implementation FLEditableItemView

@synthesize label = _label;
@synthesize value = _value;

@synthesize onValidate = _onValidate;
@synthesize onChanged = _onChanged;

@synthesize validated = _validated;

- (NSString*) valueText {
    return _value.text;
}

- (void) setValueText:(NSString*) value {
    _value.text = value;
}

- (void) setLabelText:(NSString *)label {
    _label.text = label;
}

- (NSString*) labelText {
    return _label.text;
}

- (NSString*) placeHolderText {
    return _value.placeholder;
}

- (void) setPlaceHolderText:(NSString *)label {
    _value.placeholder = label;
}

- (id) init {
    self = [super init];
    if (self) {
  
    }
    
    return self;
}

- (void) tappedKey:(id) sender {
    if(_onChanged) {
        _onChanged(self);
    }
}

- (id) initWithFrame:(FLRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _label = [[UILabel alloc] initWithFrame:frame];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor gray10Color];
        _label.shadowColor = [UIColor whiteColor];
        _label.shadowOffset = FLSizeMake(0,1);
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = UITextAlignmentRight;
        _label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]]; 
        
        _value = [[UITextField alloc] initWithFrame:frame];
        _value.clearButtonMode = UITextFieldViewModeWhileEditing;
        _value.backgroundColor = [UIColor whiteColor];
        _value.autoresizingMask = UIViewAutoresizingNone;
        _value.font = [UIFont systemFontOfSize:[UIFont systemFontSize]]; 
        _value.borderStyle = UITextBorderStyleBezel;
        _value.textColor = [UIColor gray10Color];
        _value.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_value addTarget:self action:@selector(tappedKey:) forControlEvents:UIControlEventEditingChanged];
        _value.delegate = self;
	        
        self.autoresizesSubviews = NO;
        self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
        
        [self addSubview:_label];
        [self addSubview:_value];
    }
    
    return self;
}

- (void) validateSelf {
    
    BOOL valid = YES;
    
    if(_onValidate) {
        _onValidate(self, &valid);
    }
    
    self.validated = valid;
    
}

- (void) setValidated:(BOOL) valid {
    _validated = valid;
    if(_validated) {
        _label.textColor = [UIColor gray10Color];
    }
    else {
        _label.textColor = [UIColor redGlossyButtonColor];
    }

    [_label setNeedsDisplay]; // might not be needed?
}

+ (FLEditableItemView*) editableItemView {
    return autorelease_([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    mrc_release_(_label);
    mrc_release_(_value);
    mrc_release_(_onValidate);
    mrc_release_(_onChanged);
    mrc_super_dealloc_();
}
#endif

- (CGFloat) calculateLabelWidth {
    return [_label sizeThatFitsText].width;
}

#define kHeight 26

- (void) layoutSubviews {
    [super layoutSubviews];
    
    if(FLStringIsNotEmpty(_label.text)) {
        _label.hidden = NO;
        _label.frameOptimizedForLocation = FLRectCenterRectInRectVertically(self.bounds, CGRectMake(0,0, _label.frame.size.width, kHeight));
        _value.frameOptimizedForLocation = FLRectCenterRectInRectVertically(self.bounds, CGRectMake(FLRectGetRight(_label.frame) + 10, 0, self.bounds.size.width - _label.frame.size.width - 10, kHeight + 8));
    }
    else {
        _label.hidden = YES;
        _value.frameOptimizedForLocation = FLRectCenterRectInRectVertically(self.bounds, CGRectMake(10, 0, self.bounds.size.width - 20, kHeight + 8));
    }
}

static FLEditableItemViewValidateBlock s_numberValidator = ^(FLEditableItemView* theView, BOOL* isValid) {
    NSString* value = theView.valueText;

    if(FLStringIsEmpty(value)) {
        *isValid = NO;
    }
        
        // TODO: validate that it's a number
};


+ (FLEditableItemViewValidateBlock) validateIsNumber {
    return s_numberValidator;
}

@end
