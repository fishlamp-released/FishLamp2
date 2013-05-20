//
//	GtTextEditingTableViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/20/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTextEditingTableViewController.h"
#import "GtGradientView.h"
#import "UIScrollView+GtExtras.h"
#import "GtKeyboardManager.h"
#import "GtHoverViewController.h"


@interface GtTextEditingTableViewController ()
- (void) stopEditingText:(BOOL) withDonePress deferShutdown:(BOOL) deferShutdown;
@property (readwrite, retain, nonatomic) GtTextEditCell* currentCell;
- (void) _keyboardDidShow:(id)sender;
- (void) _keyboardDidHide:(id)sender;
- (void) popoverWasResized:(id) sender;
@end

@implementation GtTextEditingTableViewController

@synthesize intermediateScrollView = m_intermediateScrollView;

@synthesize currentCell = m_currentCell;

GtSynthesizeStructProperty(showTextEditingBar, setShowTextEditingBar, BOOL, m_textEditingTableViewControllerFlags);
GtSynthesizeStructProperty(keyboardWillShowInView, setKeyboardWillShowInView, BOOL, m_textEditingTableViewControllerFlags);

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
	{
		self.keyboardWillShowInView = YES;
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardDidShow:) name: GtKeyboardDidShowNotification object:nil];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_keyboardDidHide:) name: GtKeyboardDidHideNotification object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popoverWasResized:) 
            name: GtPopoverViewWasResized object:nil];
    
	}
	
	return self;
}

- (void) _cleanupTextEditingTableViewController
{
	GtReleaseWithNil(m_intermediateScrollView);
	GtReleaseWithNil(m_currentCell);
	GtReleaseWithNil(m_textEditBar);
	
	for(GtTextEditCell* cell in m_textEditCells)
	{
		cell.textEditingCellDelegate = nil;
	}
	
	GtReleaseWithNil(m_textEditCells);
}

- (void) dealloc
{	
	[self stopEditingText:NO deferShutdown:NO];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
		
	if(m_textEditBar && !OSVersionIsAtLeast3_2())
	{
		[m_textEditBar removeFromSuperview];
	}
	GtReleaseWithNil(m_textEditBar);
	[self _cleanupTextEditingTableViewController];
	GtSuperDealloc();
}

- (void) updateContentInsets
{
	UIEdgeInsets insets = m_intermediateScrollView.contentInset;
	
//	  insets.top = GtViewContentsDescriptorCalculateTop(self.viewContentsDescriptor);
//	  insets.bottom = GtViewContentsDescriptorCalculateBottom(self.viewContentsDescriptor);

	insets.top = [self contentInsetTop];
	insets.bottom = [self contentInsetBottom];
	
	m_intermediateScrollView.contentInset = insets;
}

- (NSUInteger) keyboardHeight
{
	return [[GtKeyboardManager instance] keyboardRectForView:self.view].size.height; // (m_keyboardRect.size.height + (m_textEditBar ? m_textEditBar.frame.size.height : 0));
}

- (void) updateHeights
{
	CGRect rectForSection = [self.tableView rectForSection:self.tableView.numberOfSections - 1];
	CGFloat height = rectForSection.origin.y + rectForSection.size.height; // + m_intermediateScrollView.contentInset.top; // self.tableView.contentInset.top;
	self.tableView.newFrame = GtRectSetHeight(self.tableView.frame, height);

	CGSize size = self.tableView.frame.size;
	if(self.keyboardWillShowInView && m_textEditingTableViewControllerFlags.resizedForEditing)
	{
		size.height += (self.keyboardHeight - GtViewContentsDescriptorCalculateBottom(self.viewContentsDescriptor));
	}
		
	m_intermediateScrollView.contentSize = size;
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
//	  self.view.backgroundColor = [UIColor whiteColor];
	
	self.tableView.scrollEnabled = NO;
	self.tableView.bounces = NO;
	//((GtWidgetView*)self.view).viewDelegate = self;
	m_intermediateScrollView = [[UIScrollView alloc] initWithFrame:self.tableView.superview.bounds];
	m_intermediateScrollView.backgroundColor = [UIColor blueColor];
	
	m_intermediateScrollView.userInteractionEnabled = YES;
	m_intermediateScrollView.autoresizesSubviews = YES;
	m_intermediateScrollView.autoresizingMask = self.tableView.autoresizingMask;
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleEverything;
	m_intermediateScrollView.backgroundColor = self.tableView.backgroundColor;
	if(OSVersionIsAtLeast3_2())
	{
		self.tableView.backgroundView = nil; // [[[GtGradientView alloc] initWithFrame:self.view.bounds] autorelease];
	}
    UITableView* tableView = self.tableView;
	[tableView.superview insertSubview:m_intermediateScrollView belowSubview:tableView];
	GtRetain(tableView);
	[tableView removeFromSuperview];
	tableView.frame = GtRectSetOrigin(self.tableView.frame, 0,0);
	tableView.contentInset = UIEdgeInsetsZero;
	[m_intermediateScrollView addSubview:tableView];
	GtRelease(tableView);
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
	return m_intermediateScrollView.contentInset.top /*+ self.tableView.sectionHeaderHeight*/;
}

- (CGRect) visibleRectForScrolling
{
	if(self.keyboardWillShowInView)
	{
		CGRect rect = self.view.bounds;
		CGFloat top = GtViewContentsDescriptorCalculateTop(self.viewContentsDescriptor);
		rect.origin.y = top;
		rect.size.height -= top;
		
		if(self.keyboardHeight)
		{
			rect.size.height -= self.keyboardHeight;
		}
		else
		{
			rect.size.height -= GtViewContentsDescriptorCalculateBottom(self.viewContentsDescriptor);
		}
		
		return rect; //[self.view convertRect:rect fromView:self.view];
	}
	else
	{
		return [self.view convertRect:m_intermediateScrollView.visibleRect fromView:m_intermediateScrollView];
	}
}

- (void) _scrollTextEditCellIntoView:(GtTextEditCell*) cell animated:(BOOL) animated
{
	GtAssertNotNil(cell);

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
            
                scrollPoint.y = GtRectGetBottom(rect) - GtRectGetBottom(visibleRect);
                //GtRectGetBottom(visibleRect);
                // GtRectGetBottom(rect) - GtRectGetBottom(visibleRect); // visibleRect.origin.y - visibleRect.size.height;

    //				  GtRectGetBottom(rect) - visibleRect.size.height - visibleRect.origin.y;
                
                
                ///*(GtRectGetBottom(rect) - rect.size.height)*/ (GtRectGetBottom(rect) - visibleRect.size.height) 
              //	  rect.origin.y- visibleRect.origin.y; //- m_intermediateScrollView.contentInset.top - visibleRect.origin.y ; // - m_intermediateScrollView.contentInset.top; //visibleRect.size.height - 64; // GtRectGetBottom(visibleRect) - m_intermediateScrollView.contentInset.top; // visibleRect.origin.y + (GtRectGetBottom(rect) - visibleRect.size.height);
            }
            else
            {
                scrollPoint.y = rect.origin.y - visibleRect.origin.y;
            }
            
            [m_intermediateScrollView setContentOffset:[m_intermediateScrollView convertPoint:scrollPoint fromView:self.view] animated:animated];
        }
    }
}

- (void) _deferScroll:(GtTextEditCell*) cell
{
	[self _scrollTextEditCellIntoView:cell animated:YES];
}

- (void) scrollTextEditCellIntoView:(GtTextEditCell*) cell animated:(BOOL) animated
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

- (void) textEditingBarNextButtonPressed:(GtTextEditingBar*) bar
{
	[self.currentCell onNext:self];
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[self _scrollTextEditCellIntoView:self.currentCell animated:YES];
}
- (void) textEditingBarPreviousButtonPressed:(GtTextEditingBar*) bar
{
	[self.currentCell onPrevious:self];
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	[self _scrollTextEditCellIntoView:self.currentCell animated:YES];
}
- (void) textEditingBarCancelButtonPressed:(GtTextEditingBar*) bar
{
	[self.currentCell onStopEditing:self];
}

- (BOOL) textEditingBarNextButtonEnabled:(GtTextEditingBar*) bar
{
	return self.currentCell.nextCellToEdit != nil;
}

- (BOOL) textEditingBarPreviousButtonEnabled:(GtTextEditingBar*) bar
{
	return self.currentCell.prevCellToEdit != nil;
}

- (BOOL) resizeToFitKeyboardIfNeeded
{
	if(self.keyboardWillShowInView && !m_textEditingTableViewControllerFlags.resizedForEditing)
	{
		m_previousInsets = m_intermediateScrollView.contentInset;
		
		UIEdgeInsets contentInset = m_previousInsets;
		contentInset.bottom += self.keyboardHeight;
		m_intermediateScrollView.contentInset = contentInset;
		
		m_textEditingTableViewControllerFlags.resizedForEditing = YES;
	
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
 //	  [m_intermediateScrollView setContentOffset:CGPointMake(0, -m_intermediateScrollView.contentInset.top) animated:YES];

}

- (void) updateTextEditBar
{
	if(self.showTextEditingBar)
	{	
		if(!m_textEditBar)
		{
			m_textEditBar = [[GtTextEditingBar alloc] initWithFrame:CGRectZero];
			m_textEditBar.delegate = self;
			if(!OSVersionIsAtLeast3_2())
			{	
				m_textEditBar.hidden = YES;
				[self.view addSubview:m_textEditBar];
			}
		}
		[m_textEditBar update];
	}
} 


- (void) removeAdjustmentsForKeyboard
{
	if(m_textEditingTableViewControllerFlags.resizedForEditing)
	{
		m_textEditingTableViewControllerFlags.resizedForEditing = NO;
		m_intermediateScrollView.contentInset = m_previousInsets;
	}
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	if(!OSVersionIsAtLeast3_2())
	{
		m_textEditBar.hidden = YES;
	}
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
				if(m_textEditBar)
				{
					[m_textEditBar showWithKeyboardRect:[[GtKeyboardManager instance] keyboardRectForView:self.view]];
					[m_textEditBar update];
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
		if([cell isKindOfClass:[GtTextEditCell class]])
		{
			[self beginEditingTextInCell:(GtTextEditCell*) cell];
		}
	}
}

- (void)textEditCellDidEndEditingText:(GtTextEditCell *)cell withDoneButtonPress:(BOOL) donePress
{
	GtAssert(cell == self.currentCell, @"wrong cell");
   
	[self stopEditingText:donePress	 deferShutdown:donePress ? NO : YES];
}

- (void)textEditCellNeedsToBeginEditingText:(GtTextEditCell *)nextCell
{
	if(self.viewIsVisible)
	{
		if([nextCell isKindOfClass:[GtTextEditCell class]])
		{
			[self beginEditingTextInCell:(GtTextEditCell*) nextCell];
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

- (GtTextEditCell*) textEditCellGetNextEditableCell:(GtTextEditCell*) cell;
{
	return nil;
}

- (GtTextEditCell*) textEditCellGetPreviousEditableCell:(GtTextEditCell*) cell;
{
	return nil;
}

- (void)textEditCellDidBeginEditingText:(GtTextEditCell *)cell
{
	[self didBeginEditingTextInCell:cell];
	
	if(self.currentCell != cell)
	{
		self.currentCell = cell;
//		  if(m_textEditingTableViewControllerFlags.resizedForEditing)
		{
			[self scrollTextEditCellIntoView:self.currentCell animated:YES];
		}
	}
	
	[self updateTextEditBar];
}

- (void) setDelegateForCellIfTextEditCell:(UITableViewCell*) cell
{
	if([cell isKindOfClass:[GtTextEditCell class]])
	{
		if(!m_textEditCells)
		{
			m_textEditCells = [[NSMutableArray alloc] init];
		}
		if(((GtTextEditCell*) cell).textEditingCellDelegate != self)
		{
			[m_textEditCells addObject:cell];
			((GtTextEditCell*) cell).textEditingCellDelegate = self;
		}
	}
}

- (GtTextEditCell*) textEditingBarGetCurrentCell:(GtTextEditingBar*) bar
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

- (BOOL)textEditCellDoStartEditing:(GtTextEditCell *)cell
{
	if(!self.viewIsVisible)
	{
		return NO;
	}
	
	if(![GtTextEditCell inGlobalEditingMode])
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

- (void) beginEditingTextInCell:(GtTextEditCell*) cell
{
	GtAssertNotNil(cell);
	if(self.viewIsVisible)
	{
		if(![GtTextEditCell inGlobalEditingMode])
		{
			[GtTextEditCell setGlobalEditingMode:YES];
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
	m_textEditBar.delegate = nil;
	if(m_textEditBar && !OSVersionIsAtLeast3_2())
	{
		[m_textEditBar removeFromSuperview];
	}
	GtReleaseWithNil(m_textEditBar);

	[GtTextEditCell setGlobalEditingMode:NO];
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
			[m_textEditBar slideOffscreen];
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
	if([cell isKindOfClass:[GtTextEditCell class]])
	{	
		[self beginEditingTextInCell:(GtTextEditCell*)cell];
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
- (void) didBeginEditingTextInCell:(GtTextEditCell *)cell
{
}
- (void) didStopEditingTextInCell:(GtTextEditCell *)cell
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
		self.keyboardWillShowInView = !self.hoverViewController;
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

- (UIView*) textEditCellGetInputAccessoryView:(GtTextEditCell *)textField
{
	[self updateTextEditBar];
	if(m_textEditBar)
	{
		m_textEditBar.newFrame = GtRectSetWidth(m_textEditBar.frame, 
			[[GtKeyboardManager instance] keyboardRectForView:self.view].size.width);
		[m_textEditBar update];
	}
	return m_textEditBar;
}



@end
