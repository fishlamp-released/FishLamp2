//
//  GtTextEditCellManager.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/4/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtTextEditCellManager.h"
#import "GtGeometry.h"
#import "GtSimpleCallback.h"

@implementation GtTextEditCellManager
@synthesize delegate = m_delegate;

#define REDUCEDEDHEIGHT 202

GtSynthesize(currentCell, setCurrentCell, GtTextEditCell, m_currentCell);

- (id) initWithTableView:(UITableView*) tableView
{
	if(self = [super init])
	{
		m_tableView = tableView;
		
		NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
		[nc addObserver:self selector:@selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object:nil];
		[nc addObserver:self selector:@selector(keyboardWillHide:) name: UIKeyboardWillHideNotification object:nil];
		[nc addObserver:self selector:@selector(keyboardDidHide:) name: UIKeyboardDidHideNotification object:nil];
		[nc addObserver:self selector:@selector(keyboardDidShow:) name: UIKeyboardDidShowNotification object:nil];
	}
	
	return self;
}

- (void)dealloc 
{
	[self cancelEditing];

	m_tableView = nil;

	[[NSNotificationCenter defaultCenter] removeObserver:self];

	GtRelease(m_currentCell);
	
    [super dealloc];
}

- (BOOL) isEditing
{
    return self.currentCell != nil;
}

- (BOOL) resizeToFitKeyboardIfNeeded
{
	if(!m_flags.resized)
	{
#if DEBUG
	GtTrace(GtTraceTextEditing, @"GtTextEditCellManager resizeToFitKeyboardIfNeeded");
#endif
		m_flags.resized = YES;
		CGRect frame = m_tableView.frame;
		m_prevHeight = frame.size.height;
        frame.size.height = REDUCEDEDHEIGHT + m_tableView.contentInset.top;
		
//        [UIView beginAnimations:@"viewin" context:nil];
//        [UIView setAnimationDuration:0.3];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        m_tableView.frame = frame;
//        [UIView commitAnimations];
        
        return YES;
	}
    
    return NO;
}

- (void) keyboardWillShow:(id)sender
{
}

- (void) keyboardDidShow:(id)sender
{
    m_flags.keyboardShowing = YES;
}
- (void) keyboardDidHide:(id)sender

{
     m_flags.keyboardShowing = NO;
}

- (void) keyboardWillHide:(id)sender
{
}

- (void) beginEditingForCellAtIndexPath:(NSIndexPath *)indexPath 
{
	id cell = [self.delegate textEditCellManager:self cellForIndexPath:indexPath];
	if([cell isKindOfClass:[GtTextEditCell class]])
	{
		[self beginEditingCell:(GtTextEditCell*) cell];
	}
}

- (void)textEditCellDidEndEditing:(GtTextEditCell *)cell
{
#if DEBUG
	GtTrace(GtTraceTextEditing, @"GtTextEditCellManager textEditCellDidEndEditing");
#endif
	
    GtAssert(cell == self.currentCell, @"wrong cell");
   
    [self stopEditing];
}

- (void)textEditCellBeginEditingCell:(GtTextEditCell *)nextCell
{
    if([nextCell isKindOfClass:[GtTextEditCell class]])
    {
        [self beginEditingCell:(GtTextEditCell*) nextCell];
    }
    else
    {
        NSIndexPath* indexPath = [self.delegate textEditCellManager:self indexPathForRowId:nextCell];
        if(indexPath)
        {
            [self beginEditingForCellAtIndexPath:indexPath];
        }
    }
}

#define SCROLL_OFFSET 10

- (void) scrollCellIntoView
{
	GtTextEditCell* cell = self.currentCell;
	
//	if(cell.needsScrolledTo)
	{
//		cell.needsScrolledTo = NO;
#if DEBUG
		GtTrace(GtTraceTextEditing, @"GtTextEditCellManager scrollCellIntoView");
#endif			
		
//		[m_tableView scrollRectToVisible:cell.frame animated:YES];

    //    [m_tableView scrollRectToVisible:cell.frame animated:YES];

		
        
        NSIndexPath* path = [self.delegate textEditCellManager:self
			indexPathForCell:cell];
		
		[m_tableView scrollToRowAtIndexPath:path 
			atScrollPosition:UITableViewScrollPositionTop
			animated:NO];
    
		if([self.delegate respondsToSelector:@selector(textEditCellManager:cellScrolledIntoView:)])
		{
			[self.delegate textEditCellManager:self cellScrolledIntoView:cell];
		}
/*	
		CGRect contentRect = m_tableView.bounds;
		
//		contentRect = CGRectInset(contentRect, 0, m_tableView.contentInset.top);
		
//			contentRect.origin.y += m_tableView.contentInset.top;

		CGRect cellFrame = cell.frame;
		
		if(!GtRectEnclosesRect(contentRect, cellFrame))
		{
			CGFloat maxPointToScrollTo = 
				m_tableView.contentSize.height - 
					m_tableView.frame.size.height; );

			CGFloat pointToScrollTo = cell.frame.origin.y - SCROLL_OFFSET - m_tableView.contentInset.top;

			CGPoint point = CGPointMake(0, MIN(maxPointToScrollTo, pointToScrollTo));
			[m_tableView setContentOffset:point animated:YES];


#if 0		// this doesn't work if the scroll view is inset at the top
			NSIndexPath* path = [m_tableView indexPathForRowAtPoint:cell.frame.origin];
			[m_tableView scrollToRowAtIndexPath:path 
				atScrollPosition:UITableViewScrollPositionTop animated:YES];
#endif
		}
*/
		
	}
	
}




- (void)textEditCellDidBeginEditing:(GtTextEditCell *)cell
{
#if DEBUG
	GtTrace(GtTraceTextEditing, @"GtTextEditCellManager textEditCellDidBeginEditing");
#endif
//	[m_tableView scrollRectToVisible:cell.frame animated:YES];

	NSIndexPath* path = [self.delegate textEditCellManager:self
		indexPathForCell:cell];
	
	[m_tableView scrollToRowAtIndexPath:path 
		atScrollPosition:UITableViewScrollPositionTop
		animated:YES];


	[self.delegate textEditCellManager:self didBeginEditingCell:cell];
}

- (void) setDelegateForCellIfTextEditCell:(UITableViewCell*) cell
{
	if([cell isKindOfClass:[GtTextEditCell class]])
	{
		((GtTextEditCell*) cell).delegate = self;
	}
}

- (void) stopEditingCurrentCell
{
    if(self.currentCell)
    {
        [self.currentCell endEditing];
        self.currentCell = nil;
    }
   
}

- (void) beginEditingCell:(GtTextEditCell*) cell
{
    if(![GtTextEditCell inGlobalEditingMode])
    {
        [GtTextEditCell setGlobalEditingMode:YES];
        
        if([self resizeToFitKeyboardIfNeeded])
		{
			[m_tableView reloadData];
        }
        
        if(m_delegate && [m_delegate respondsToSelector:@selector(textEditCellManagerDidStartEditing:)])
        {
            [m_delegate textEditCellManagerDidStartEditing:self];
        }
    }

	if(self.currentCell != cell)
	{
        [self stopEditingCurrentCell];
 
        self.currentCell = cell;
 
        [self scrollCellIntoView];
		
        [cell beginEditing];
    }
}

- (void) stopEditing
{
    [self stopEditingCurrentCell];
    [GtTextEditCell setGlobalEditingMode:NO];
 
    if(m_flags.resized)
	{
#if DEBUG
	GtTrace(GtTraceTextEditing, @"GtTextEditCellManager keyboardDidHide");
#endif
		m_flags.resized = NO;
		CGRect frame = m_tableView.frame;
		frame.size.height = m_prevHeight;
		m_tableView.frame = frame;
	}

	[m_tableView reloadData];

    if(m_delegate && [m_delegate respondsToSelector:@selector(textEditCellManagerDidStartEditing:)])
    {
        [m_delegate textEditCellManagerDidEndEditing:self];
    }   
}

- (void) cancelEditing
{
	self.delegate = nil;
    m_tableView = nil;

    [self stopEditing];
}

- (BOOL) startEditingForRowIfTextEditCell:(UITableViewCell*) cell atIndexPath:(NSIndexPath*) indexPath
{
#if DEBUG
	GtTrace(GtTraceTextEditing, @"GtTextEditCellManager startEditingForRowIfTextEditCell");
#endif

	if([cell isKindOfClass:[GtTextEditCell class]])
	{	
		[self beginEditingCell:(GtTextEditCell*)cell];
		return YES;
	}
	else 
	{
		[self stopEditing];
	}
	
	return NO;
}






@end
