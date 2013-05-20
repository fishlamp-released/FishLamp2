//
//  GtToolbarView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/8/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtToolbarView.h"
#import "GtViewLayout.h"
#import "UIImage+GtColorize.h"

@implementation GtToolbarItem

@synthesize frame = m_frame;
@synthesize minSize = m_minSize;
@synthesize callback = m_callback;
@synthesize view = m_view;

GtSynthesizeStructProperty(isDisabled, setDisabled, BOOL, m_state);
GtSynthesizeStructProperty(isHidden, setHidden, BOOL, m_state);

- (id) init
{
    if((self = [super init]))
    {
    }
    return self;
}


- (id) initWithView:(id) view target:(id) target action:(SEL) action
{
    if((self = [super init]))
    {
        self.callback = GtCallbackMake(target, action);
        self.view = view;
    }
    
    return self;
}

- (void) updateLayoutWithAlignment:(GtToolbarItemAlignment) alignment 
    inView:(UIView*) toolbarView
{
    if(self.view)
    {
        CGRect viewFrame = [self.view frame];
        CGRect frame = self.frame;
        frame.size.width = viewFrame.size.width + 10.0f;
        frame.size.height = toolbarView.bounds.size.height;
        
        viewFrame = GtRectCenterRectInRectVertically(frame, viewFrame);
        
        switch(alignment)
        {
            case GtToolbarItemAlignmentCenter:
                    viewFrame = GtRectCenterRectInRect(frame, viewFrame);
                break;
            case GtToolbarItemAlignmentRight:
                    viewFrame = GtRectJustifyRectInRectRight(frame, viewFrame);
                break;
            case GtToolbarItemAlignmentLeft:
                    viewFrame = GtRectJustifyRectInRectLeft(frame, viewFrame);
                break;
        }
        
        self.frame = frame;
        [self.view setFrame:GtRectMoveRectToOptimizedLocationIfNeeded(viewFrame)];
    }
}

- (void) wasAddedToToolbarView:(UIView*) view
{
}

- (void) wasRemovedFromToolbarView:(UIView*) view
{
}

- (void) drawRect:(CGRect) rect inToolbarView:(UIView*) view
{
}

@end

@implementation GtToolbarItemGroup

@synthesize frame = m_frame;
@synthesize toolbarView = m_toolbarView;

- (id) initWithToolbarView:(GtToolbarView*) view
{
    if((self = [super init]))
    {
        m_toolbarView = view;
        m_items = [[NSMutableArray alloc] init];
        self.viewLayout = [GtColumnViewLayout columnViewLayout];
        self.viewLayout.padding = UIEdgeInsetsMake(0, 10, 0, 10);
    }
    
    return self;
}

- (void) addToolbarItem:(GtToolbarItem*) item
{
    [m_items addObject:item];
    [item wasAddedToToolbarView:self.toolbarView];
}

- (void) removeToolbarItem:(GtToolbarItem*) item
{
    [item wasRemovedFromToolbarView:self.toolbarView];
    [m_items removeObject:item];
}

- (void) removeAllToolbarItems
{
    for(GtToolbarItem* item in m_items)
    {
        [item wasRemovedFromToolbarView:self.toolbarView];
    }   
    [m_items removeAllObjects];
}

- (void) drawRect:(CGRect) rect inToolbarView:(GtToolbarView*) view
{
    for(GtToolbarItem* item in m_items)
    {
        [item drawRect:rect inToolbarView:view];
    }
}

- (void) dealloc
{
    [self removeAllToolbarItems];
    GtRelease(m_items);
    GtSuperDealloc();
}

- (void) updateLayoutWithAlignment:(GtToolbarItemAlignment) alignment
    inView:(UIView*) view
{
    for(GtToolbarItem* item in m_items)
    {
        [item updateLayoutWithAlignment:alignment inView:view];
    }
    CGRect frame = m_frame;
    frame.size = [self.viewLayout layoutArrangeableViews:m_items inBounds:m_frame];
    self.frame = frame;
    for(GtToolbarItem* item in m_items)
    {
        [item updateLayoutWithAlignment:alignment inView:view];
    }
}

@end

@implementation GtToolbarView

#import "GtGradientView.h"

@synthesize backgroundView = m_backgroundView;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
		self.autoresizesSubviews = NO;
		self.userInteractionEnabled = YES;
		self.exclusiveTouch = YES;
        
        GtGradientView* gradient = GtReturnAutoreleased([[GtGradientView alloc] initWithFrame:self.bounds]);
        gradient.autoresizingMask = UIViewAutoresizingFlexibleEverything;
        gradient.alpha = 0.6f;
        self.backgroundView = gradient;
    }

	return self;
}

- (id) init
{
    return [self initWithFrame:CGRectMake(0,0,320,44)];
}

+ (GtToolbarView*) toolbarView
{
    return GtReturnAutoreleased([[GtToolbarView alloc] init]);
}

- (void) dealloc
{
    GtRelease(m_backgroundView);
	GtRelease(m_leftItems);
	GtRelease(m_centerItems);
	GtRelease(m_rightItems);
	GtSuperDealloc();
}

-(GtToolbarItemGroup*) leftItems
{
    if(!m_leftItems)
    {
        m_leftItems = [[GtToolbarItemGroup alloc] initWithToolbarView:self];
    }
    return m_leftItems;
}

-(GtToolbarItemGroup*) rightItems
{
    if(!m_rightItems)
    {
        m_rightItems = [[GtToolbarItemGroup alloc] initWithToolbarView:self];
    }
    return m_rightItems;
}

-(GtToolbarItemGroup*) centerItems
{
    if(!m_centerItems)
    {
        m_centerItems = [[GtToolbarItemGroup alloc] initWithToolbarView:self];
    }
    return m_centerItems;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    if(m_backgroundView)
    {
        m_backgroundView.frame = self.bounds;
    }
    
    CGFloat left = self.bounds.origin.x;
    CGFloat right  = GtRectGetRight(self.bounds);
    if(m_leftItems)
    {   
        m_leftItems.frame = self.bounds;
        [m_leftItems updateLayoutWithAlignment:GtToolbarItemAlignmentLeft inView:self];
        left = GtRectGetRight(m_leftItems.frame);
    }
    if(m_rightItems)
    {
        m_rightItems.frame = self.bounds;
        [m_rightItems updateLayoutWithAlignment:GtToolbarItemAlignmentRight inView:self];
        m_rightItems.frame = GtRectJustifyRectInRectRight(self.bounds, m_rightItems.frame);
        [m_rightItems updateLayoutWithAlignment:GtToolbarItemAlignmentRight inView:self];
        right = m_leftItems.frame.origin.x;
    }
    if(m_centerItems)
    {
        m_centerItems.frame = self.bounds;
        [m_centerItems updateLayoutWithAlignment:GtToolbarItemAlignmentCenter inView:self];
        CGRect frame = m_centerItems.frame;
        
        m_centerItems.frame = GtRectCenterRectInRect(self.bounds, frame);

        if(GtRectGetRight(frame) > right)
        {
            frame.origin.x = right - frame.size.width;
        }
        
        if(frame.origin.x < left)
        {
            frame.origin.x = left;
            
            if(GtRectGetRight(frame) > right)
            {
                frame.size.width = right - left;
            }
        }
        
        m_centerItems.frame = frame;
        [m_centerItems updateLayoutWithAlignment:GtToolbarItemAlignmentCenter inView:self];
    }
}

- (void) setBackgroundView:(UIView*) backgroundView
{
    if(m_backgroundView)
    {
        [m_backgroundView removeFromSuperview];
    }

    GtAssignObject(m_backgroundView, backgroundView);
    [self insertSubview:m_backgroundView atIndex:0];
}

@end

@implementation GtToolbarItemView

+ (id) toolbarItemView:(UIView*) view target:(id) target action:(SEL) action;
{
    return GtReturnAutoreleased([[[self class] alloc] initWithView:view target:target action:action]);
}

- (void) wasAddedToToolbarView:(UIView*) view
{
    [view addSubview:self.view];
}

- (void) wasRemovedFromToolbarView:(UIView*) view
{
    [self.view removeFromSuperview];
}

@end

@implementation GtImageButtonToolbarItem

- (id) initWithImageName:(NSString*) imageName target:(id) target action:(SEL) action
{
    if((self = [super init]))
    {
        self.callback = GtCallbackMake(target, action);

        UIImage* image = [UIImage whiteImageNamed:imageName];
        GtAssertNotNil(image);
        
        GtAssertNotNil(target);
        GtAssertNotNil(action);

        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0,0, image.size.width, image.size.height);
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        button.enabled = YES;
        button.showsTouchWhenHighlighted = YES;
        
        self.view = button;
    }
    
    return self;
}

+ (id) imageButtonToolbarItem:(NSString*) imageName target:(id) target action:(SEL) action
{
    return GtReturnAutoreleased([[GtImageButtonToolbarItem alloc] initWithImageName:imageName target:target action:action]);

}

@end

