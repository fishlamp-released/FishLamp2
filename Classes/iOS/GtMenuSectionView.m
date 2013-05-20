//
//  GtMenuViewSection.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMenuSectionView.h"
#import "GtViewLayout.h"

@implementation GtMenuSectionView

- (void) setSectionTitle:(NSString*) title
{
    m_header.menuHeaderTitle = title;
}

- (NSString*) sectionTitle
{
    return m_header.menuHeaderTitle;
}

- (id) initWithSectionTitle:(NSString*) sectionTitle
{
    if((self = [super initWithFrame:CGRectMake(0,0,100,40)]))
    {
        self.backgroundColor = [UIColor clearColor];
    
        m_header = [[GtMenuSectionHeaderView alloc] initWithFrame:CGRectMake(0,0, 100, 42)];
        m_header.menuHeaderTitle = sectionTitle;
        m_header.hidden = GtStringIsEmpty(sectionTitle);
        [self addSubview:m_header];
        
        self.viewLayout = [GtRowViewLayout viewLayout];
            //    self.viewLayout
    }
    
    return self;
}

- (void) dealloc
{
    GtRelease(m_header);
    GtSuperDealloc();
}

//- (CGSize) layoutSubviewsWithViewLayout
//{
//    CGSize size = [super layoutSubviewsWithViewLayout];
//    self.frameOptimizedForLocation = GtRectSetSizeWithSize(self.frame, size);
//    return size;
//}

- (NSString*) description
{
    return [NSString stringWithFormat:@"%@: %@:\n%@", [super description], m_header.menuHeaderTitle, [self.subviews description]];
}
@end

