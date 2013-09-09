//
//  FLGridViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/17/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLGridViewController.h"
#import "UIScrollView+FLExtras.h"
#import "FLCallback_t.h"
#import "FLViewControllerStack.h"
#import "_FLGridCell.h"

#if DEBUG
#define TRACE 0
#endif

@interface FLGridViewController ()
@end

@implementation FLGridViewController 

@synthesize dataModel = _dataProvider;
@synthesize objectCache = _objectCache;
@synthesize arrangement = _arrangement;
@synthesize cellCollection = _cellCollection;
@synthesize visibleCellCollection = _visibleCellCollection;

FLSynthesizeStructProperty(allowMultipleSelections, setAllowMultipleSelections, BOOL, _gridViewControllerFlags);

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _objectCache = [[FLObjectCache alloc] init];
        _cellCollection = [[FLOrderedCollection alloc] init];

        _visibleCellCollection = [[FLContiguousVisibleGridCellCollection alloc] init];
        _visibleCellCollection.delegate = self;
        
        _selectedObjectIds = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (UIView*) gridViewSuperview {
    return self.scrollView;
}

- (NSArray*) selectedCells {
    if(_selectedObjectIds.count == 0) {
        return nil;
    }

    NSMutableArray* array = [NSMutableArray arrayWithCapacity:_selectedObjectIds.count];
    for(id dataRefKey in _selectedObjectIds) {
        [array addObject:[self cellForDataRefKey:dataRefKey]];
    } 

    return array;
}

- (void) dealloc {
    FLRelease(_selectedObjectIds);
    FLRelease(_visibleCellCollection);
    FLRelease(_cellCollection);
    FLRelease(_arrangement);
    FLRelease(_objectCache);
    FLRelease(_dataProvider);
    FLRelease(_scrollIndicatorView);
    FLSuperDealloc();
}

#if DEBUG
- (void) viewDidLoad {
    [super viewDidLoad];
}
#endif

- (void) viewDidUnload {
#if TRACE
    FLLog(@"%@ did unload", NSStringFromClass([self class])); 
#endif    

    [super viewDidUnload];
    
    FLReleaseWithNil(_scrollIndicatorView);
}

- (void) createScrollIndicatorView {
    _scrollIndicatorView = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 120, 12)];
    
    _scrollIndicatorView.textColor = [UIColor whiteColor];
    _scrollIndicatorView.shadowColor = [UIColor blackColor];
    _scrollIndicatorView.backgroundColor = [UIColor clearColor];
    _scrollIndicatorView.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    _scrollIndicatorView.hidden = YES;
    _scrollIndicatorView.textAlignment = UITextAlignmentRight;
    [self.view addSubview:_scrollIndicatorView];
}

- (UIScrollView*) createScrollView {
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.autoresizesSubviews = NO;
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    scrollView.delegate = self;
    scrollView.delaysContentTouches = NO;
    scrollView.minimumZoomScale = 0.5f;
    scrollView.maximumZoomScale = 2.5f;
    scrollView.multipleTouchEnabled = YES;
    scrollView.backgroundColor = [UIColor clearColor];
    return scrollView;
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
     
//     UIInterfaceOrientation oldOrientation = 
//     
//     CGRect oldBounds = self.view.bounds;
//     CGRect newBounds = oldBounds;
//
//    if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
//        newBounds.size.width = MAX(oldBounds.size.width, oldBounds.size.height);
//        newBounds.size.height = MIN(oldBounds.size.width, oldBounds.size.height);
//    }
//    else {
//        newBounds.size.width = MIN(oldBounds.size.width, oldBounds.size.height);
//        newBounds.size.height = MAX(oldBounds.size.width, oldBounds.size.height);
//    }
//
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self reflowCellsInBounds:FLRectRotate90Degrees(self.scrollView.bounds)];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    [self reflowCellsInBounds:self.scrollView.bounds];
}

- (CGRect) visibleBounds  {
    CGRect visibleRect;
	visibleRect.origin = self.scrollView.contentOffset;
	visibleRect.size = self.scrollView.bounds.size;
    visibleRect.origin.y += self.scrollView.contentInset.top;
//	visibleRect.origin.x += self.scrollView.contentInset.left;
//	visibleRect.size.height += (self.scrollView.contentInset.top + self.scrollView.contentInset.bottom);
//	visibleRect.size.width += (self.scrollView.contentInset.left + self.scrollView.contentInset.right);
    
#if TRACE
    FLLog(@"visible rect: %@", NSStringFromCGRect(visibleRect));
#endif
    
    return visibleRect;
}

- (void) removeAllCells {
    [self unselectAllCells];
    [self unloadVisibleCells];   
    [self.cellCollection removeAllObjects];
    [self.visibleCellCollection removeAllCells];
}

- (void) unloadVisibleCells {
    UIView* superview = self.gridViewSuperview;

    for(FLGridCell* cell in self.visibleCellCollection) {
        if(!cell.isHidden) {
            [cell cellDidDisappearFromSuperview:superview viewController:self];
        }
    }
    
    [self.visibleCellCollection removeAllCells];
}

- (void) updateVisibleCells:(CGRect) visibleBounds {
    UIView* superview = self.gridViewSuperview;
        
    for(FLGridCell* cell in self.visibleCellCollection) {
        if(CGRectIntersectsRect(cell.frame, visibleBounds)) {
            if(cell.isHidden) {
                [cell cellWillAppearInSuperview:superview viewController:self];
            }
        }
        else {
            if(!cell.isHidden) {
                [cell cellDidDisappearFromSuperview:superview viewController:self];
            }
        }    
    }
}

- (void) visibleGridCellCollectionVisibleCellsDidChange:(id<FLVisibleGridCellCollection>) collection {
    [self visibleCellsChanged];
}

- (void) visibleGridCellCollection:(id<FLVisibleGridCellCollection>) collection updateCellVisiblityInBounds:(CGRect) bounds {
    [self updateVisibleCells:bounds];
}

- (FLOrderedCollection*) visibleGridCellCollectionGetCellCollection:(id<FLVisibleGridCellCollection>) collection {
    return self.cellCollection;
}

- (void) reflowCells {
    [self reflowCellsInBounds:self.view.bounds];
}

- (void) reflowCellsInBounds:(CGRect) bounds {
    FLAssertIsNotNil(self.arrangement);
    FLAssertIsNotNil(self.visibleCellCollection);
    FLAssertIsNotNil(self.scrollView);

    self.scrollView.contentSize = [self.arrangement performArrangement:self.cellCollection.objectArray inBounds:bounds];
    
    [_visibleCellCollection recalculateVisibleCellsInBounds:self.visibleBounds];
}

- (void) visibleCellsChanged {
    FLVisibleCellRanges visible = _visibleCellCollection.visibleRanges;

    FLAssertWithComment(visible.count == 1, @"expecting only one range");

    NSRange range = visible.ranges[0];

    if(_scrollIndicatorView) {
        _scrollIndicatorView.text = [NSString stringWithFormat:@"%d-%d of %d", range.location + 1, range.location + 1 + range.length, _cellCollection.count];             
    }

    if(range.location + range.length >= _cellCollection.count) {
        if(!_gridViewControllerFlags.showingLastCell) {
            _gridViewControllerFlags.showingLastCell = YES;
            [self lastCellIsVisible];
        }
    }
    else {
        _gridViewControllerFlags.showingLastCell = NO;
    }
}

- (void) lastCellIsVisible {
}

- (void) scrollToCell:(FLGridCell*) cell    
             animated:(BOOL) animated {
    FLAssertIsNotNil(cell);
    [self.scrollView scrollRectToVisible:cell.frame animated:animated];
}

- (void) updateScrollIndicatorViewPosition {
    if(_scrollIndicatorView) {
        CGRect r;
        r.origin = self.scrollView.contentOffset;
        r.size = self.scrollView.bounds.size;
        
        if(r.size.height > 0) {
            CGFloat mid = CGRectGetMidY(r);
            
            CGFloat percentage = mid / self.scrollView.contentSize.height;
            
            CGFloat proportionalMid = self.view.bounds.size.height * percentage;
            
            _scrollIndicatorView.frame = CGRectMake(
                FLRectGetRight(self.view.bounds) - _scrollIndicatorView.frame.size.width - 10, 
                proportionalMid - (_scrollIndicatorView.frame.size.height / 2.0f), 
                _scrollIndicatorView.frame.size.width, 
                _scrollIndicatorView.frame.size.height);
        }
    }
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(_scrollIndicatorView) {
        _scrollIndicatorView.hidden = YES;
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if(_scrollIndicatorView) {
        _scrollIndicatorView.hidden = NO;
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    FLLog(@"Zooming zoom scale: %f", scrollView.zoomScale);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollView;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self reflowCells];

    if(self.visibleCellCollection.count == 0) {   
        [self beginRefreshing:NO];
    }
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self unloadVisibleCells];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];

    [_visibleCellCollection recalculateVisibleCellsInBounds:self.visibleBounds];
    
    [self updateScrollIndicatorViewPosition]; 
}

- (void) cellWasSelected:(FLGridCell*) cell {
}

- (void) cellWasUnselected:(FLGridCell*) cell {
}

- (void) selectCell:(FLGridCell*) cell {
    if(![self isCellSelected:cell]) {
        if(![self allowMultipleSelections]) {
            [self unselectAllCells];
        }
    
        [_selectedObjectIds addObject:cell.cellDataRefKey];
        cell.selected = YES;

        [self cellWasSelected:cell];
    }
}

//- (FLGridCell*) cellForObject:(id) object {
//    return [_cellCollection objectForKey:[object dataRefKey]];
//}

- (FLGridCell*) cellForDataRefKey:(id) dataRefKey {
    return [_cellCollection objectForKey:dataRefKey];
}

- (void) unselectCell:(FLGridCell*) cell {
    if([self isCellSelected:cell]) {
        [_selectedObjectIds removeObject:cell.cellDataRefKey];
        cell.selected = NO;
        [self cellWasUnselected:cell];
    }
}

- (void) unselectAllCells {
    NSArray* prev = _selectedObjectIds;
    mrc_retain_(prev);
    FLAutorelease(prev);
    FLSetObjectWithRetain(_selectedObjectIds, [NSMutableArray array]);

    for(id dataRefKey in prev) {
        FLGridCell* cell = [self cellForDataRefKey:dataRefKey];
        cell.selected = NO;
        [self cellWasUnselected:cell];
    }
}

- (BOOL) isCellSelected:(FLGridCell*) cell {
    id dataRefKey = cell.cellDataRefKey;
    
    for(id selectedId in _selectedObjectIds) {
        if([selectedId isEqual:dataRefKey]) {
            cell.selected = YES;
            return YES;
        }
    }

    return NO;
}

- (FLGridCell*) createGridViewCellForObject:(id) object {
    return [object createGridViewCell];
}

- (void) mergeCellDataRefs:(NSArray*) dataRefArray {
    FLOrderedCollection* newCollection = [FLOrderedCollection orderedCollectionWithCapacity:dataRefArray.count];
    
    for(id object in dataRefArray) {
        id dataRefKey = [object dataRefKey];
        FLGridCell* cell = [_cellCollection objectForKey:dataRefKey];
        if(cell) {
            cell.cellDataRef = object;
        }
        else {
            cell = [self createGridViewCellForObject:object];
        }

        FLAssertIsNotNil(cell);
        [newCollection addObject:cell forKey:dataRefKey];
    }
    
    FLSetObjectWithRetain(_cellCollection, newCollection);
    [self reflowCells];
}

- (void) replaceCellDataRefs:(NSArray*) dataRefArray {

    [self removeAllCells];

    FLOrderedCollection* newCollection = [FLOrderedCollection orderedCollectionWithCapacity:dataRefArray.count];
    
    for(id object in dataRefArray) {
        id dataRefKey = [object dataRefKey];
        FLGridCell* cell = [self createGridViewCellForObject:object];
        FLAssertIsNotNil(cell);
        [newCollection addObject:cell forKey:dataRefKey];
    }
    
    FLSetObjectWithRetain(_cellCollection, newCollection);
    [self reflowCells];
}

- (void) _addOrReplaceCellDataRef:(id) object {
    id dataRefKey = [object dataRefKey];
    FLGridCell* cell = [_cellCollection objectForKey:dataRefKey];
    if(cell) {
        cell.cellDataRef = object;
    }
    else {
        cell = [self createGridViewCellForObject:object];
        FLAssertIsNotNil(cell);

        [_cellCollection addObject:cell forKey:dataRefKey];
    }
}

- (void) addOrReplaceCellDataRef:(id) object {
    [self _addOrReplaceCellDataRef:object];
    [self reflowCells];
}

- (void) addOrReplaceCellDataRefs:(NSArray*) dataRefArray  {
    for(id object in dataRefArray) {
        [self _addOrReplaceCellDataRef:object];
    }
    [self reflowCells];
}

- (void) removeCell:(FLGridCell*) cell {
    if([self isCellSelected:cell]) {
        [self unselectCell:cell];
    }
    
    [_cellCollection removeObjectForKey:cell.cellDataRefKey];
    [self reflowCells];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self reflowCells];
}

- (id) dataModelForCell:(FLGridCell *)cell {
    return self.dataModel;
}

- (UIViewController*) createViewControllerForSelectedCell:(FLGridCell *)cell {
    return nil;
}

- (void) presentViewControllerForSelectedCell:(FLGridCell *)cell {   
    [self.viewControllerStack pushViewController:[self createViewControllerForSelectedCell:cell] withAnimation:[self createOpenAnimationForCell:cell]];
}

- (id<FLViewControllerTransitionAnimation>) createOpenAnimationForCell:(FLGridCell*) cell {
    return [UIViewController defaultTransitionAnimation];
}



@end

