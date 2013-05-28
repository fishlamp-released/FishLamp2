//
//  FLMenuViewSection.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLMenuSectionView.h"
#import "FLSingleColumnRowArrangement.h"


@implementation FLMenuSectionView

- (void) setSectionTitle:(NSString*) title
{
    _header.menuHeaderTitle = title;
}

- (NSString*) sectionTitle
{
    return _header.menuHeaderTitle;
}

- (id) initWithSectionTitle:(NSString*) sectionTitle
{
    if((self = [super initWithFrame:CGRectMake(0,0,100,40)]))
    {
        self.backgroundColor = [UIColor clearColor];
    
        _header = [[FLMenuSectionHeaderView alloc] initWithFrame:CGRectMake(0,0, 100, 42)];
        _header.menuHeaderTitle = sectionTitle;
        _header.hidden = FLStringIsEmpty(sectionTitle);
        [self addSubview:_header];
        
        self.arrangement = [FLSingleColumnRowArrangement arrangement];
            //    self.arrangement
    }
    
    return self;
}

- (void) dealloc
{
    FLRelease(_header);
    FLSuperDealloc();
}

//- (CGSize) layoutSubviewsWithArrangement
//{
//    CGSize size = [super layoutSubviewsWithArrangement];
//    self.frameOptimizedForLocation = FLRectSetSizeWithSize(self.frame, size);
//    return size;
//}

- (NSString*) description
{
    return [NSString stringWithFormat:@"%@: %@:\n%@", [super description], _header.menuHeaderTitle, [self.subviews description]];
}
@end

