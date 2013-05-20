//
//  GtHierarchicalDataViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/24/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtHierarchicalGridViewController.h"
#import "GtViewLayout.h"

#import "GtGradientButton.h"
#import "GtAsyncEventHandler.h"
#import "GtToolbarView.h"
#import "UIImage+GtColorize.h"

@implementation GtHierarchicalGridViewController

@synthesize parentDataObject = m_parentObject;
@synthesize selectedCell = m_selectedCell;
@synthesize previousSelectedCell = m_previousSelectedCell;

- (id) initWithDataProvider:(id) dataProvider 
{
    if((self = [super initWithNibName:nil bundle:nil]))
    {
        [self createActionContext];
        self.dataProvider = dataProvider;
        self.viewLayout = [GtRowViewLayout rowViewLayout];
    }

    return self;
}

- (id) initWithDataProvider:(id) dataProvider parentDataObject:(id) parentDataObject
{
    if((self = [self initWithDataProvider:dataProvider]))
    {
        self.parentDataObject = parentDataObject;
    }
    return self;
}

- (BOOL) isChildViewController
{
    return [[self.viewControllerStack parentControllerForController:self] isKindOfClass:[self class]];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    GtGradientView* gradient = GtReturnAutoreleased([[GtGradientView alloc] initWithFrame:self.view.bounds]);
    gradient.alpha = 0.4;
    [self.view insertSubview:gradient belowSubview:self.scrollView];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    self.topBarView = [GtToolbarView toolbarView];
}

//- (void) _beginLoadingChildren:(id) parent
//{
//    GtAsyncEventHandler* eventHandler = [GtAsyncEventHandler asyncEventHandler:self.actionContext];
//    
//    eventHandler.didLoadDataBlock = ^(GtAsyncEventHandlerResult result, NSError* error, id data) {
//        if(!error)
//        {
//            self.parentDataObject = parent;
//            [self.cellCollection addOrReplaceCellsWithGridViewObjects:data atIndex:0];
//            [self reflowCells];
//        }
//        [self setFinishedRefreshing];
//    };
//
//    [self.dataProvider beginLoadingChildenForDataObject:parent eventHandler:eventHandler];
//}

- (void) viewWillAppear:(BOOL) animated
{
    [super viewWillAppear:animated];

    GtAsyncEventHandler* eventHandler = [GtAsyncEventHandler asyncEventHandler:self.actionContext];

    eventHandler.didLoadDataBlock = ^(GtAsyncEventHandlerResult result, NSError* error, id array) {
        if(!error)
        {
            [self.cellCollection addOrReplaceCellsWithGridViewObjects:array atIndex:0];
            [self reflowCells];
            [self setFinishedRefreshing];
        }
    };

    [self.dataProvider beginLoadingChildenForDataObject:self.parentDataObject eventHandler:eventHandler];
}

- (void) selectedCellDidChange
{

}

- (void) _closeSelf:(id) sender
{
    [self dismissViewControllerAnimated:YES];
}

- (void) willBePushedOnViewControllerStack:(GtViewControllerStack*) controller
{
    [super willBePushedOnViewControllerStack:controller];
    
    GtToolbarView* toolbar = (GtToolbarView*) self.topBarView;
    
    if([self isChildViewController])
    {
        [toolbar.leftItems addToolbarItem:[GtImageButtonToolbarItem imageButtonToolbarItem:@"back.png" target:self action:@selector(_closeSelf:)]];
        
    
//        [self.buttonbar addBackButton:@"<<" target:self action:@selector(popChild:)];
    }
    else
    {   
        [toolbar.leftItems addToolbarItem:[GtImageButtonToolbarItem imageButtonToolbarItem:@"x.png" target:self action:@selector(_closeSelf:)]];
    }
}

- (id) dataProviderForCell:(GtGridViewCellController *)cell
{
    return self.dataProvider;
}

- (UIViewController*) viewControllerForCell:(GtGridViewCellController *)cell
{
    return GtReturnAutoreleased([[[self class] alloc] initWithDataProvider:[self dataProviderForCell:cell] parentDataObject:cell.gridViewObject]);
}

- (void) showViewControllerForCell:(GtGridViewCellController *)cell
{   
    [self.viewControllerStack pushViewController:[self viewControllerForCell:cell] withAnimation:[self disclosureAnimationForCell:cell]];
}

- (void) gridViewCellWasSelected:(GtGridViewCellController *)cell
{
    if(self.selectedCell)
    {
        self.previousSelectedCell = self.selectedCell;
        self.selectedCell.selected = NO;
    }
    
    self.selectedCell = cell;
    
    [self selectedCellDidChange];
}

- (void) discloseButtonPressedForCell:(GtGridViewCellController*) cell
{
    cell.selected = YES;
    self.selectedCell = cell;
    
    [self showViewControllerForCell:cell];
}

- (void) dealloc
{
    GtRelease(m_selectedCell);
    GtRelease(m_previousSelectedCell);
    GtRelease(m_parentObject);
    GtSuperDealloc();
}

- (id<GtViewControllerStackAnimation>) disclosureAnimationForCell:(GtGridViewCellController*) cell
{
    return [GtViewControllerStack dropAndSlideFromRightAnimation];
}

@end

#import "GtRoundRectWidget.h"
#import "GtLabelWidget.h"
#import "GtGradientWidget.h"
#import "GtImageWidget.h"

@interface GtHierarchicalGridViewCellView : UIView {
@private
    GtRoundRectWidget* m_titleButton;
    GtRoundRectWidget* m_disclosureButton;
    
    GtGradientWidget* m_gradient1;
    GtGradientWidget* m_gradient2;
    
    GtImageWidget* m_disclosureImage;
    GtLabelWidget* m_label;
    
    GtHeirarchicalGridViewCell* m_cell;
}

@property (readwrite, assign, nonatomic) BOOL disclosureButtonHidden;
@property (readwrite, assign, nonatomic) BOOL disclosureButtonDisabled;

@property (readwrite, retain, nonatomic) NSString* title;

@property (readonly, retain, nonatomic) GtGradientWidget* titleGradient;
@property (readonly, retain, nonatomic) GtGradientWidget* buttonGradient;
@property (readwrite, assign, nonatomic) GtHeirarchicalGridViewCell* cell;
@end

@implementation GtHierarchicalGridViewCellView

@synthesize titleGradient = m_gradient1;
@synthesize buttonGradient = m_gradient2;
@synthesize cell = m_cell;

- (void) _gradientOneSelected:(GtWidget*) widget
{
    BOOL highlighted = widget.isHighlighted;
    BOOL selected = widget.isSelected;

    self.gridViewCellController.highlighted = highlighted;
    self.gridViewCellController.selected = selected;
}

- (void) _gradientTwoSelected:(GtWidget*) widget
{
//    self.gridViewCellController.selected = YES;
    if(widget.isSelected)
    {
        widget.selected = NO;
        [((GtHeirarchicalGridViewCell*) self.gridViewCellController) discloseButtonPressed];
    }
}

- (BOOL) disclosureButtonHidden
{
    return m_gradient2.hidden;
}

- (BOOL) disclosureButtonDisabled
{
    return m_gradient2.disabled;
}

- (void) setDisclosureButtonHidden:(BOOL) hidden
{
    m_gradient2.hidden = hidden;
    m_disclosureButton.hidden = hidden;
    
    [self setNeedsLayout];
}

- (void) setDisclosureButtonDisabled:(BOOL) disabled
{
    m_gradient2.disabled = disabled;
    
    [self setNeedsLayout];
}

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.backgroundColor = [UIColor clearColor];
    
        m_label = [[GtLabelWidget alloc] initWithFrame:frame];
        [self addWidget:m_label];

        m_label.textDescriptor.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        m_label.textDescriptor.enabledColor = [UIColor whiteColor];
        
        self.autoresizesSubviews = NO;

        m_gradient1 = [[GtGradientWidget alloc] initWithFrame:frame];
        m_gradient1.alpha = 0.5;
        [self addWidget:m_gradient1];

        m_gradient1.touchHandler = [GtSelectOnTouchDownHandler selectOnTouchDownHandler];
        m_gradient1.touchHandler.changedStateCallback = GtCallbackMake(self, @selector(_gradientOneSelected:));
        
        m_gradient2 = [[GtGradientWidget alloc] initWithFrame:frame];
        m_gradient2.touchHandler = [GtSelectOnTouchUpHandler selectOnTouchUpHandler];
        m_gradient2.touchHandler.changedStateCallback = GtCallbackMake(self, @selector(_gradientTwoSelected:));
        
        m_gradient2.alpha = 0.5;
        [self addWidget:m_gradient2];
        
        m_disclosureImage = [[GtImageWidget alloc] initWithFrame:m_gradient2.frame];
        m_disclosureImage.image = [UIImage whiteImageNamed:@"forward.png"];
        [m_disclosureImage resizeToImageSize];
        [self addWidget:m_disclosureImage];
        
//        m_titleButton = [[GtRoundRectWidget alloc] initWithFrame:frame];
//        m_titleButton.superview = self;
//        m_titleButton.cornerRadius = 1.0;
//
//        m_disclosureButton = [[GtRoundRectWidget alloc] initWithFrame:frame];
//        m_disclosureButton.superview = self;
//        m_disclosureButton.cornerRadius = 1.0;
    }

    return self;
}

- (void) dealloc
{
    GtRelease(m_disclosureImage);
    GtRelease(m_gradient1);
    GtRelease(m_gradient2);
    GtRelease(m_label);
    GtSuperDealloc();
}

- (void) setTitle:(NSString*) title
{
    m_label.text = title;
    [self setNeedsLayout];
}

- (NSString*) title
{
    return m_label.text;
}

#define kButtonWidth 44.0f
#define kLabelHeight 16.0f
#define kPadding 10.0f

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    if(m_gradient2.isHidden)
    {
        m_gradient1.frame = self.bounds;
        m_label.frameOptimizedForSize = GtRectCenterRectInRectVertically(self.bounds, 
            CGRectMake(kPadding,0,self.frame.size.width - kPadding, kLabelHeight));
        
    }
    else
    {
        m_gradient1.frame = GtRectSetWidth(self.bounds, self.bounds.size.width - kButtonWidth - 2);
        m_gradient2.frame = CGRectMake(self.bounds.size.width-kButtonWidth,0,kButtonWidth,self.bounds.size.height);
        
        m_label.frameOptimizedForSize = GtRectCenterRectInRectVertically(self.bounds, 
            CGRectMake(kPadding,0,self.frame.size.width - kButtonWidth - kPadding, kLabelHeight));
        
        m_disclosureImage.frameOptimizedForLocation = GtRectCenterRectInRect(m_gradient2.frame, m_disclosureImage.frame);
    }
}

- (void) drawRect:(CGRect) rect
{
    [super drawRect:rect];
    [m_gradient1 drawInRect:self.bounds];
    [m_gradient2 drawInRect:self.bounds];
    [m_label drawInRect:self.bounds];
    [m_disclosureImage drawRect:self.bounds];
}

- (void) updateState
{
    self.title = [self.gridViewCellController.gridViewObject gridViewDisplayName];
    m_gradient1.selected = [self.gridViewCellController isSelected];
    m_gradient1.highlighted = [self.gridViewCellController isHighlighted];
}

- (void) didMoveToGridViewCellController
{
    if(self.gridViewCellController)
    {
        [self updateState];
    }

}

@end

@implementation GtHeirarchicalGridViewCell

- (id) initWithGridViewObject:(id) object
{
    if((self = [super initWithGridViewObject:object]))
    {
        self.frame = CGRectMake(0,0, 120, 50);
    }
    return self;
}

+ (GtHeirarchicalGridViewCell*) hierarchicalGridViewCell:(id) dataObject
{
    return GtReturnAutoreleased([[GtHeirarchicalGridViewCell alloc] initWithGridViewObject:dataObject]);
}

- (UIView*) createViewForDisplayState:(GtGridViewCellDisplayState)displayState
{
    return GtReturnAutoreleased([[GtHierarchicalGridViewCellView alloc] initWithFrame:self.frame]);
}

- (void) cellDidChangeState
{
    [self.view didMoveToGridViewCellController];
}

- (void) discloseButtonPressed
{
    [((GtHierarchicalGridViewController*) self.viewController) discloseButtonPressedForCell:self];
}

@end