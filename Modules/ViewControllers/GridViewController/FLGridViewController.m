//
//  FLGridViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/17/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGridViewController.h"
#import "UIScrollView+FLExtras.h"
#import "FLCallback.h"
#import "FLViewControllerStack.h"

#import <objc/runtime.h>

#if DEBUG
#define TRACE 0
#endif

@interface FLGridViewController ()
- (UIView*) gridViewSuperview; // self.scrollView is default
@end

@implementation FLGridViewController 

@synthesize dataSource = _dataProvider;
@synthesize objectCache = _objectCache;
@synthesize cellArrangement = _arrangement;
@synthesize cellCollection = _cellCollection;
@synthesize visibleCellCollection = _visibleCellCollection;

FLSynthesizeStructProperty(allowMultipleSelections, setAllowMultipleSelections, BOOL, _gridViewControllerFlags);

@dynamic actionContext;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        _objectCache = [[FLObjectCache alloc] init];
        _cellCollection = [[FLOrderedCollection alloc] init];

        _visibleCellCollection = [[FLContiguousVisibleGridViewCellCollection alloc] init];
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
    for(id objectId in _selectedObjectIds) {
        [array addObject:[self cellForObjectId:objectId]];
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

    for(FLGridViewCell* cell in self.visibleCellCollection) {
        if(cell.isCellLoaded) {
            [cell cellDidDisappearFromSuperview:superview viewController:self];
        }
    }
    
    [self.visibleCellCollection removeAllCells];
}

- (void) updateVisibleCells:(CGRect) visibleBounds {
    UIView* superview = self.gridViewSuperview;
        
    for(FLGridViewCell* cell in self.visibleCellCollection) {
        if(CGRectIntersectsRect(cell.frame, visibleBounds)) {
            if(!cell.isCellLoaded) {
                [cell cellWillAppearInSuperview:superview viewController:self];
            }
        }
        else {
            if(cell.isCellLoaded) {
                [cell cellDidDisappearFromSuperview:superview viewController:self];
            }
        }    
    }
}

- (void) visibleGridViewCellCollectionVisibleCellsDidChange:(id<FLVisibleGridViewCellCollection>) collection {
    [self visibleCellsChanged];
}

- (void) visibleGridViewCellCollection:(id<FLVisibleGridViewCellCollection>) collection updateCellVisiblityInBounds:(CGRect) bounds {
    [self updateVisibleCells:bounds];
}

- (FLOrderedCollection*) visibleGridViewCellCollectionGetCellCollection:(id<FLVisibleGridViewCellCollection>) collection {
    return self.cellCollection;
}

- (void) reflowCells {
    [self reflowCellsInBounds:self.view.bounds];
}

- (void) reflowCellsInBounds:(CGRect) bounds {
    FLAssertIsNotNil(self.cellArrangement);
    FLAssertIsNotNil(self.visibleCellCollection);
    FLAssertIsNotNil(self.scrollView);

    self.scrollView.contentSize = [self.cellArrangement performArrangement:self.cellCollection.objectArray inBounds:bounds];
    
    [_visibleCellCollection recalculateVisibleCellsInBounds:self.visibleBounds];
}

- (void) visibleCellsChanged {
    FLVisibleCellRanges visible = _visibleCellCollection.visibleRanges;

    FLAssert(visible.count == 1, @"expecting only one range");

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

- (void) scrollToCell:(FLGridViewCell*) cell    
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

- (void) cellWasSelected:(FLGridViewCell*) cell {
}

- (void) cellWasUnselected:(FLGridViewCell*) cell {
}

- (void) selectCell:(FLGridViewCell*) cell {
    if(![self isCellSelected:cell]) {
        if(![self allowMultipleSelections]) {
            [self unselectAllCells];
        }
    
        [_selectedObjectIds addObject:[cell.gridViewObject gridViewObjectId]];
        cell.selected = YES;

        [self cellWasSelected:cell];
    }
}

- (FLGridViewCell*) cellForObject:(id) object {
    return [_cellCollection objectForKey:[object gridViewObjectId]];
}

- (FLGridViewCell*) cellForObjectId:(id) objectId {
    return [_cellCollection objectForKey:objectId];
}

- (void) unselectCell:(FLGridViewCell*) cell {
    if([self isCellSelected:cell]) {
        [_selectedObjectIds removeObject:[cell.gridViewObject gridViewObjectId]];
        cell.selected = NO;
        [self cellWasUnselected:cell];
    }
}

- (void) unselectAllCells {
    NSArray* prev = _selectedObjectIds;
    FLRetain(prev);
    FLAutorelease(prev);
    FLAssignObject(_selectedObjectIds, [NSMutableArray array]);

    for(id objectId in prev) {
        FLGridViewCell* cell = [self cellForObjectId:objectId];
        cell.selected = NO;
        [self cellWasUnselected:cell];
    }
}

- (id) objectFromCell:(FLGridViewCell*) cell {
    return cell.gridViewObject;
}

- (id) objectIdFromCell:(FLGridViewCell*) cell {
    return [cell.gridViewObject gridViewObjectId];
}

- (BOOL) isCellSelected:(FLGridViewCell*) cell {
    id objectId = [self objectIdFromCell:cell];
    
    for(id selectedId in _selectedObjectIds) {
        if([selectedId isEqual:objectId]) {
            cell.selected = YES;
            return YES;
        }
    }

    return NO;
}

- (FLGridViewCell*) createGridViewCellForObject:(id) object {
    return [object createGridViewCell];
}

- (void) mergeGridViewObjects:(NSArray*) itemArray {
    FLOrderedCollection* newCollection = [FLOrderedCollection orderedCollectionWithCapacity:itemArray.count];
    
    for(id object in itemArray) {
        id objectId = [object gridViewObjectId];
        FLGridViewCell* cell = [_cellCollection objectForKey:objectId];
        if(cell) {
            cell.gridViewObject = object;
        }
        else {
            cell = [self createGridViewCellForObject:object];
        }

        FLAssertIsNotNil(cell);
        [newCollection addObject:cell forKey:objectId];
    }
    
    FLAssignObject(_cellCollection, newCollection);
    [self reflowCells];
}

- (void) replaceGridViewObjects:(NSArray*) itemArray {

    [self removeAllCells];

    FLOrderedCollection* newCollection = [FLOrderedCollection orderedCollectionWithCapacity:itemArray.count];
    
    for(id object in itemArray) {
        id objectId = [object gridViewObjectId];
        FLGridViewCell* cell = [self createGridViewCellForObject:object];
        FLAssertIsNotNil(cell);
        [newCollection addObject:cell forKey:objectId];
    }
    
    FLAssignObject(_cellCollection, newCollection);
    [self reflowCells];
}

- (void) _addOrReplaceGridViewObject:(id) object {
    id objectId = [object gridViewObjectId];
    FLGridViewCell* cell = [_cellCollection objectForKey:objectId];
    if(cell) {
        cell.gridViewObject = object;
    }
    else {
        cell = [self createGridViewCellForObject:object];
        FLAssertIsNotNil(cell);

        [_cellCollection addObject:cell forKey:objectId];
    }
}

- (void) addOrReplaceGridViewObject:(id) object {
    [self _addOrReplaceGridViewObject:object];
    [self reflowCells];
}

- (void) addOrReplaceGridViewObjects:(NSArray*) itemArray  {
    for(id object in itemArray) {
        [self _addOrReplaceGridViewObject:object];
    }
    [self reflowCells];
}

- (void) removeCell:(FLGridViewCell*) cell {
    if([self isCellSelected:cell]) {
        [self unselectCell:cell];
    }
    
    [_cellCollection removeObjectForKey:[self objectIdFromCell:cell]];
    [self reflowCells];
}

- (void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self reflowCells];
}

- (id) dataSourceForCell:(FLGridViewCell *)cell {
    return self.dataSource;
}

- (UIViewController*) createViewControllerForOpeningCell:(FLGridViewCell *)cell {
    return nil;
}

- (void) showViewControllerForCell:(FLGridViewCell *)cell {   
    [self.viewControllerStack pushViewController:[self createViewControllerForOpeningCell:cell] withAnimation:[self createOpenAnimationForCell:cell]];
}

- (id<FLViewControllerTransitionAnimation>) createOpenAnimationForCell:(FLGridViewCell*) cell {
    return [UIViewController defaultTransitionAnimation];
}



@end

