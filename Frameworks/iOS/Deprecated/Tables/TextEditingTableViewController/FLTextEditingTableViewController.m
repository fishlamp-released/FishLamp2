//
//	FLTextEditingTableViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLTextEditingTableViewController.h"
#import "FLGradientView.h"
#import "UIScrollView+FLExtras.h"
#import "FLKeyboardManager.h"
#import "FLFloatingViewController.h"


@interface FLTextEditingTableViewController ()
- (void) stopEditingText:(BOOL) withDonePress deferShutdown:(BOOL) deferShutdown;
@property (readwrite, retain, nonatomic) FLTextEditCell* currentCell;
- (void) _keyboardDidShow:(id)sender;
- (void) _keyboardDidHide:(id)sender;
- (void) popoverWasResized:(id) sender;
@end

@implementation FLTextEditingTableViewController

@synthesize intermediateScrollView = _intermediateScrollView;

@synthesize currentCell = _currentCell;

FLSynthesizeStructProperty(showTextEditingBar, setShowTextEditingBar, BOOL, _textEditingTableViewControllerFlags);
FLSynthesizeStructProperty(keyboardWillShowInView, setKeyboardWillShowInView, BOOL, _textEditingTableViewControllerFlags);

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		self.keyboardWillShowInView = YES;
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardDidShow:) name: FLKeyboardDidShowNotification object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardDidHide:) name: FLKeyboardDidHideNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popoverWasResized:) 
            name: FLPopoverViewWasResized object:nil];
    
	}
	
	return self;
}

- (void) _cleanupTextEditingTableViewController
{
	FLReleaseWithNil(_intermediateScrollView);
	FLReleaseWithNil(_currentCell);
	FLReleaseWithNil(_textEditBar);
	
	for(FLTextEditCell* cell in _textEditCells)
	{
		cell.textEditingCellDelegate = nil;
	}
	
	FLReleaseWithNil(_textEditCells);
}

- (void) dealloc
{	
	[self stopEditingText:NO deferShutdown:NO];
	[[NSNotificationCenter defaultCenter] removeObserver:self];

// TODO?? 
		
//	if(_textEditBar && !OSVersionIsAtLeast3_2())
//	{
//		[_textEditBar removeFromSuperview];
//	}
	FLReleaseWithNil(_textEditBar);
	[self _cleanupTextEditingTableViewController];
	FLSuperDealloc();
}

- (void) updateContentInsets
{
//	UIEdgeInsets insets = _intermediateScrollView.contentInset;
//	
////	  insets.top = FLViewContentsDescriptorCalculateTop(self.viewContentsDescriptor);
////	  insets.bottom = FLViewContentsDescriptorCalculateBottom(self.viewContentsDescriptor);
//
//	insets.top = [self contentInsetTop];
//	insets.bottom = [self contentInsetBottom];
	
	_intermediateScrollView.contentInset = self.contentViewInsets;
}

- (NSUInteger) keyboardHeight
{
	return [[FLKeyboardManager instance] keyboardRectForView:self.view].size.height; // (_keyboardRect.size.height + (_textEditBar ? _textEditBar.frame.size.height : 0));
}

- (void) updateHeights
{
	CGRect rectForSection = [self.tableView rectForSection:self.tableView.numberOfSections - 1];
	CGFloat height = rectForSection.origin.y + rectForSection.size.height; // + _intermediateScrollView.contentInset.top; // self.tableView.contentInset.top;
	self.tableView.newFrame = FLRectSetHeight(self.tableView.frame, height);

	CGSize size = self.tableView.frame.size;
	if(self.keyboardWillShowInView && _textEditingTableViewControllerFlags.resizedForEditing)
	{
		size.height += (self.keyboardHeight - self.contentViewInsetBottom);
	}
		
	_intermediateScrollView.contentSize = size;
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
//	  self.view.backgroundColor = [UIColor whiteColor];
	
	self.tableView.scrollEnabled = NO;
	self.tableView.bounces = NO;
	//((FLView*)self.view).viewDelegate = self;
	_intermediateScrollView = [[UIScrollView alloc] initWithFrame:self.tableView.superview.bounds];
	_intermediateScrollView.backgroundColor = [UIColor blueColor];
	
	_intermediateScrollView.userInteractionEnabled = YES;
	_intermediateScrollView.autoresizesSubviews = YES;
	_intermediateScrollView.autoresizingMask = self.tableView.autoresizingMask;
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	_intermediateScrollView.backgroundColor = self.tableView.backgroundColor;
	self.tableView.backgroundView = nil; 
    // FLAutorelease([[FLGradientView alloc] initWithFrame:self.view.bounds]);
	UITableView* tableView = self.tableView;
	[tableView.superview insertSubview:_intermediateScrollView belowSubview:tableView];
	mrc_retain_(tableView);
	[tableView removeFromSuperview];
	tableView.frame = FLRectSetOrigin(self.tableView.frame, 0,0);
	tableView.contentInset = UIEdgeInsetsZero;
	[_intermediateScrollView addSubview:tableView];
	FLRelease(tableView);
}

- (void) tableViewDidLayoutSubviews:(UITableView*) tableView
{	
	[super tableViewDidLayoutSubviews:tableView];
	[self updateHeights];
}

- (void) viewDidUnload
{
	 [super viewDidUnload];
	 [self _cleanupTextEditingTableViewController];
}

- (BOOL) isEditingText
{
	return self.currentCell != nil;
}

- (CGFloat) _topOfScrollArea
{
	return _intermediateScrollView.contentInset.top /*+ self.tableView.sectionHeaderHeight*/;
}

- (CGRect) visibleRectForScrolling
{
	if(self.keyboardWillShowInView)
	{
		CGRect rect = self.view.bounds;
		CGFloat top = self.contentViewInsetTop;
		rect.origin.y = top;
		rect.size.height -= top;
		
		if(self.keyboardHeight)
		{
			rect.size.height -= self.keyboardHeight;
		}
		else
		{
			rect.size.height -= self.contentViewInsetBottom;
		}
		
		return rect; //[self.view convertRect:rect fromView:self.view];
	}
	else
	{
		return [self.view convertRect:_intermediateScrollView.visibleRect fromView:_intermediateScrollView];
	}
}

- (void) _scrollTextEditCellIntoView:(FLTextEditCell*) cell animated:(BOOL) animated
{
	FLAssertIsNotNil(cell);

    if(cell)
    {
        CGRect rect = [self.view convertRect:cell.bounds fromView:cell];
        
        CGRect visibleRect = [self visibleRectForScrolling];
        
        if(!CGRectContainsRect(visibleRect, rect))
        {
            CGPoint scrollPoint = rect.origin;
            
            if(rect.size.height > visibleRect.size.height)
            {
    //			  CGFloat delta = (rect.size.height - visibleRect.size.height);
            
                scrollPoint.y = FLRectGetBottom(rect) - FLRectGetBottom(visibleRect);
                //FLRectGetBottom(visibleRect);
                // FLRectGetBottom(rect) - FLRectGetBottom(visibleRect); // visibleRect.origin.y - visibleRect.size.height;

    //				  FLRectGetBottom(rect) - visibleRect.size.height - visibleRect.origin.y;
                
                
                ///*(FLRectGetBottom(rect) - rect.size.height)*/ (FLRectGetBottom(rect) - visibleRect.size.height) 
              //	  rect.origin.y- visibleRect.origin.y; //- _intermediateScrollView.contentInset.top - visibleRect.origin.y ; // - _intermediateScrollView.contentInset.top; //visibleRect.size.height - 64; // FLRectGetBottom(visibleRect) - _intermediateScrollView.contentInset.top; // visibleRect.origin.y + (FLRectGetBottom(rect) - visibleRect.size.height);
            }
            else
            {
                scrollPoint.y = rect.origin.y - visibleRect.origin.y;
            }
            
            [_intermediateScrollView setContentOffset:[_intermediateScrollView convertPoint:scrollPoint fromView:self.view] animated:animated];
        }
    }
}

- (void) _deferScroll:(FLTextEditCell*) cell
{
	[self _scrollTextEditCellIntoView:cell animated:YES];
}

- (void) scrollTextEditCellIntoView:(FLTextEditCell*) cell animated:(BOOL) animated
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	if(animated)
	{
		[self performSelector:@selector(_deferScroll:) withObject:cell afterDelay:0.15];
	}
	else
	{
		[self _scrollTextEditCellIntoView:cell animated:NO];
	}
}

- (void) textEditingBarNextButtonPressed:(FLTextEditingBar*) bar
{
	[self.currentCell onNext:self];
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[self _scrollTextEditCellIntoView:self.currentCell animated:YES];
}
- (void) textEditingBarPreviousButtonPressed:(FLTextEditingBar*) bar
{
	[self.currentCell onPrevious:self];
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[self _scrollTextEditCellIntoView:self.currentCell animated:YES];
}
- (void) textEditingBarCancelButtonPressed:(FLTextEditingBar*) bar
{
	[self.currentCell onStopEditing:self];
}

- (BOOL) textEditingBarNextButtonEnabled:(FLTextEditingBar*) bar
{
	return self.currentCell.nextCellToEdit != nil;
}

- (BOOL) textEditingBarPreviousButtonEnabled:(FLTextEditingBar*) bar
{
	return self.currentCell.prevCellToEdit != nil;
}

- (BOOL) resizeToFitKeyboardIfNeeded
{
	if(self.keyboardWillShowInView && !_textEditingTableViewControllerFlags.resizedForEditing)
	{
		_previousInsets = _intermediateScrollView.contentInset;
		
		UIEdgeInsets contentInset = _previousInsets;
		contentInset.bottom += self.keyboardHeight;
		_intermediateScrollView.contentInset = contentInset;
		
		_textEditingTableViewControllerFlags.resizedForEditing = YES;
	
		return YES;
	}
	
	return NO;
}


- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	
	if(self.currentCell)
	{
		[self resizeToFitKeyboardIfNeeded];
		[self scrollTextEditCellIntoView:self.currentCell animated:YES];
	}
}

- (void) resetScrollPosition
{
 //	  [_intermediateScrollView setContentOffset:CGPointMake(0, -_intermediateScrollView.contentInset.top) animated:YES];

}

- (void) updateTextEditBar
{
	if(self.showTextEditingBar)
	{	
		if(!_textEditBar)
		{
			_textEditBar = [[FLTextEditingBar alloc] initWithFrame:CGRectZero];
			_textEditBar.delegate = self;
//			if(!OSVersionIsAtLeast3_2())
//			{	
//				_textEditBar.hidden = YES;
//				[self.view addSubview:_textEditBar];
//			}
		}
		[_textEditBar update];
	}
} 


- (void) removeAdjustmentsForKeyboard
{
	if(_textEditingTableViewControllerFlags.resizedForEditing)
	{
		_textEditingTableViewControllerFlags.resizedForEditing = NO;
		_intermediateScrollView.contentInset = _previousInsets;
	}
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
//	if(!OSVersionIsAtLeast3_2())
//	{
//		_textEditBar.hidden = YES;
//	}
	[self removeAdjustmentsForKeyboard];
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void) keyboardDidShow
{
}

- (void) _keyboardDidShow:(id)sender
{
	if(self.viewIsVisible)
	{
		[self keyboardDidShow];
		[self updateContentInsets];
			
		if(self.viewIsVisible)
		{
			[self updateTextEditBar];
			
			if(!OSVersionIsAtLeast3_2())
			{
				if(_textEditBar)
				{
					[_textEditBar showWithKeyboardRect:[[FLKeyboardManager instance] keyboardRectForView:self.view]];
					[_textEditBar update];
				}
			}
			[self resizeToFitKeyboardIfNeeded];
			if(self.currentCell)
			{
				[self scrollTextEditCellIntoView:self.currentCell animated:YES];
			}
		
		}
	}
}

- (void) beginEditingForCellAtIndexPath:(NSIndexPath *)indexPath 
{
	if(self.viewIsVisible)
	{
		id cell = [self cellForIndexPath:indexPath];
		if([cell isKindOfClass:[FLTextEditCell class]])
		{
			[self beginEditingTextInCell:(FLTextEditCell*) cell];
		}
	}
}

- (void)textEditCellDidEndEditingText:(FLTextEditCell *)cell withDoneButtonPress:(BOOL) donePress
{
	FLAssertWithComment(cell == self.currentCell, @"wrong cell");
   
	[self stopEditingText:donePress	 deferShutdown:donePress ? NO : YES];
}

- (void)textEditCellNeedsToBeginEditingText:(FLTextEditCell *)nextCell
{
	if(self.viewIsVisible)
	{
		if([nextCell isKindOfClass:[FLTextEditCell class]])
		{
			[self beginEditingTextInCell:(FLTextEditCell*) nextCell];
		}
		else
		{
			NSIndexPath* indexPath = [self indexPathForRowId:nextCell];
			if(indexPath)
			{
				[self beginEditingForCellAtIndexPath:indexPath];
			}
		}
	}
}

- (FLTextEditCell*) textEditCellGetNextEditableCell:(FLTextEditCell*) cell
{
	return nil;
}

- (FLTextEditCell*) textEditCellGetPreviousEditableCell:(FLTextEditCell*) cell
{
	return nil;
}

- (void)textEditCellDidBeginEditingText:(FLTextEditCell *)cell
{
	[self didBeginEditingTextInCell:cell];
	
	if(self.currentCell != cell)
	{
		self.currentCell = cell;
//		  if(_textEditingTableViewControllerFlags.resizedForEditing)
		{
			[self scrollTextEditCellIntoView:self.currentCell animated:YES];
		}
	}
	
	[self updateTextEditBar];
}

- (void) setDelegateForCellIfTextEditCell:(UITableViewCell*) cell
{
	if([cell isKindOfClass:[FLTextEditCell class]])
	{
		if(!_textEditCells)
		{
			_textEditCells = [[NSMutableArray alloc] init];
		}
		if(((FLTextEditCell*) cell).textEditingCellDelegate != self)
		{
			[_textEditCells addObject:cell];
			((FLTextEditCell*) cell).textEditingCellDelegate = self;
		}
	}
}

- (FLTextEditCell*) textEditingBarGetCurrentCell:(FLTextEditingBar*) bar
{
	return self.currentCell;
}

- (void) stopTextEditingInCurrentCell
{
	if(self.currentCell)
	{
		[self.currentCell endEditing];
		self.currentCell = nil;
	}
}

- (BOOL)textEditCellDoStartEditing:(FLTextEditCell *)cell
{
	if(!self.viewIsVisible)
	{
		return NO;
	}
	
	if(![FLTextEditCell inGlobalEditingMode])
	{
		[self performSelectorOnMainThread:@selector(beginEditingTextInCell:) withObject:cell waitUntilDone:NO];
		return NO;
	}
	else if(self.currentCell != cell)
	{
		[self.currentCell allowResponderToResign];
	}
	
	return YES;
}

- (void) beginEditingTextInCell:(FLTextEditCell*) cell
{
	FLAssertIsNotNil(cell);
	if(self.viewIsVisible)
	{
		if(![FLTextEditCell inGlobalEditingMode])
		{
			[FLTextEditCell setGlobalEditingMode:YES];
			[self.tableView reloadData];
			[self didBeginEditingText];
		}

		if(self.currentCell != cell)
		{
			[self stopTextEditingInCurrentCell];
			[cell beginEditing];
		}
	}
}

- (void) _shutDownTextEditing
{
	_textEditBar.delegate = nil;
	if(_textEditBar && !OSVersionIsAtLeast3_2())
	{
		[_textEditBar removeFromSuperview];
	}
	FLReleaseWithNil(_textEditBar);

	[FLTextEditCell setGlobalEditingMode:NO];
	[self removeAdjustmentsForKeyboard];
	[self resetScrollPosition];
			
	[self.tableView reloadData];	
}

- (void) stopEditingText:(BOOL) withDonePress deferShutdown:(BOOL) deferShutdown 
{
	if(self.isEditingText)
	{
		if(!OSVersionIsAtLeast3_2())
		{
			[_textEditBar slideOffscreen];
		}
		[self stopTextEditingInCurrentCell];
		if(deferShutdown)
		{
			[self performSelector:@selector(_shutDownTextEditing) withObject:nil afterDelay:0.3];
		}
		else
		{
			[self _shutDownTextEditing];
		}
		[self didStopEditingText:withDonePress];
	}
}

- (void) stopEditingText:(BOOL) withDonePress
{
	[self stopEditingText:withDonePress deferShutdown:NO];
}

- (BOOL) beginEditingTextInCell:(UITableViewCell*) cell 
	atIndexPath:(NSIndexPath*) indexPath
{
	if([cell isKindOfClass:[FLTextEditCell class]])
	{	
		[self beginEditingTextInCell:(FLTextEditCell*)cell];
		return YES;
	}
	else 
	{
		[self stopEditingText:NO deferShutdown:YES];
	}
	
	return NO;
}


- (id) cellForIndexPath:(NSIndexPath*) indexPath
{
	return [self.tableView cellForRowAtIndexPath:indexPath];
}

- (NSIndexPath*) indexPathForCell:(UITableViewCell*) cell
{
	return [self.tableView indexPathForCell:cell];
}

// per cell
- (void) didBeginEditingTextInCell:(FLTextEditCell *)cell
{
}
- (void) didStopEditingTextInCell:(FLTextEditCell *)cell
{
}

- (NSIndexPath*) indexPathForRowId:(id) rowId
{
	return nil;
}

- (void) didBeginEditingText
{
}
- (void) didStopEditingText:(BOOL) withDonePress
{
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	if(DeviceIsPad()) // TODO: this should be abstracted in a different way
	{
		self.keyboardWillShowInView = !self.floatingViewController;
	}
}

- (void) popoverWasResized:(id) sender
{
	if(self.currentCell)
	{
		[self scrollTextEditCellIntoView:self.currentCell animated:YES];
	}
}

- (void) keyboardDidHide
{
}

- (void) _keyboardDidHide:(id) sender
{
	if(self.viewIsVisible)
	{
		[self updateContentInsets];
		[self.tableView reloadData];

		[self keyboardDidHide];
	}
}

- (void) viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self stopEditingText:NO deferShutdown:NO];
}

- (UIView*) textEditCellGetInputAccessoryView:(FLTextEditCell *)textField
{
	[self updateTextEditBar];
	if(_textEditBar)
	{
		_textEditBar.newFrame = FLRectSetWidth(_textEditBar.frame, 
			[[FLKeyboardManager instance] keyboardRectForView:self.view].size.width);
		[_textEditBar update];
	}
	return _textEditBar;
}



@end
