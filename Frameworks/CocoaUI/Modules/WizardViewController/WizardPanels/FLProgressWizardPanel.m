//
//  FLProgressWizardPanel.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLProgressWizardPanel.h"
#import "UIViewController+FLAdditions.h"
#import "FLView.h"

@implementation FLProgressWizardPanelView

//- (id) initWithCoder:(NSCoder *)aDecoder {
//    self = [super initWithCoder:aDecoder];
//    if(self) {
//        [self setupView];
//    }
//    return self;
//}
//
//- (id) initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if(self) {
//        [self setupView];
//    }
//    return self;
//}

- (void) awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor gray85Color];
}

@end


@implementation FLProgressWizardPanelProgressView
@synthesize progressIndicator = _progressIndicator;
@synthesize progressLabel = _progressLabel;

- (NSString*) progressText {
    return _progressLabel.stringValue;
}

- (void) setProgressText:(NSString*) text {
    _progressLabel.stringValue = text;
}

- (void) viewDidMoveToSuperview {
    if(self.superview) {
        [self.progressIndicator startAnimation:self];
    }
    else {
        [self.progressIndicator stopAnimation:self];
    }
}

- (void) awakeFromNib {
    [super awakeFromNib];
    
    _progressLabel.font = [NSFont fontWithName:@"MyriadPro-Bold" size:14];
}

@end

@implementation FLProgressWizardPanelTextView 
@synthesize textField = _textLabel;

- (NSString*) textValue {
    return _textLabel.stringValue;
}

- (void) setTextValue:(NSString*) text {
    _textLabel.stringValue = text;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    
    NSFont* font = [NSFont fontWithName:@"MyriadPro-Bold" size:14];;
    
    _textLabel.font = font;
}
    

@end

@interface FLProgressWizardPanel ()

@end

@implementation FLProgressWizardPanel
@synthesize progressView1 = _progressView1;
@synthesize progressView2 = _progressView2;
@synthesize textView1 = _textView1;
@synthesize textView2 = _textView2;

@synthesize currentView = _currentView;


#if FL_MRC
- (void) dealloc {
//    [_progress release];
//    [_progressLabel release];
    [super dealloc];
}
#endif

- (id) init {
    return [self initWithDefaultNibName];
}

+ (id) progressWizardPanel {
    return FLAutorelease([[[self class] alloc] initWithDefaultNibName]);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
#if OSX
        self.view.wantsLayer = YES;
        self.progressView1.wantsLayer = YES;
        self.progressView2.wantsLayer = YES;
        self.textView1.wantsLayer = YES;
        self.textView2.wantsLayer = YES;
#endif    
    }
    
    
    return self;
}

- (void) loadView {
    [super loadView];
    


//    FLView* blueView = FLAutorelease([[FLView alloc] initWithFrame:self.progressContainer.bounds]);
//    blueView.backgroundColor = [UIColor gray85Color];
//    [self.progressContainer addSubview:blueView];
//    [blueView sendToBack];
//
//    FLView* greenView = FLAutorelease([[FLView alloc] initWithFrame:self.progressContainer.bounds]);
//    greenView.backgroundColor = [UIColor gray85Color];
//    [self.errorContainer addSubview:greenView];
//    [greenView sendToBack];
}

- (void) respondToError:(NSError*) error errorMessage:(NSString*) errorMessage {
    
    FLProgressWizardPanelTextView* view = self.textView1;
    if(self.currentView == view) {
        view = self.textView2;
    }
   
    view.textValue = errorMessage;
   
    [self flipToNextViewWithDirection:FLFlipAnimationDirectionDown nextView:view completion:^{
        self.wizard.otherButton.enabled = NO;
        self.wizard.backButton.enabled = YES;
    }];
}

- (void) wizardPanelWillAppear {
    [super wizardPanelWillAppear];
    self.wizard.nextButton.enabled = NO;
    self.wizard.backButton.enabled = NO;
    self.wizard.otherButton.enabled = YES;
    self.wizard.otherButton.hidden = NO;
    self.wizard.otherButton.title = NSLocalizedString(@"Cancel", nil);
}

- (void) wizardPanelDidAppear {
    [super wizardPanelDidAppear];
}

- (void) respondToOtherButton:(id) sender {
    [super respondToOtherButton:(id) sender];
    
    [self.wizard popWizardPanelAnimated:YES completion:^(FLWizardPanel* panel){
    }];
}

- (void) flipToNextViewWithDirection:(FLFlipAnimationDirection) direction 
                            nextView:(UIView*) nextView
                            completion:(void (^)()) completion {

    completion = FLAutoreleasedCopy(completion);

    self.wizard.otherButton.enabled = NO;
    self.wizard.backButton.enabled = NO;
    self.wizard.nextButton.enabled = NO;

    FLAnimator* animator = [FLAnimator animator:0.5];
    
    [animator addAnimation:[FLFlipAnimation flipAnimation:direction 
                                               withTarget:self.currentView 
                                              withSibling:nextView]];
    [animator startAnimating:^{
        [self.currentView removeFromSuperview];
        
        self.currentView = nextView;
        if(completion) {
            completion();
        }
    }];
}

- (void) setInitialView:(UIView*) view {
    CGRect frame = self.view.bounds;
    frame.size.width = 200;
    frame.size.height = 40;
    view.frame = FLRectCenterRectInRect(self.view.bounds, frame);
    [self.view addSubview:view];
    self.currentView = view;
}

@end

