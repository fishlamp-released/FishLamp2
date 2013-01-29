//
//  ZFEntryCell.m
//  ZenfolioDownloader
//
//  Created by patrick machielse on 22-8-07.
//  Copyright 2007 Zenfolio, Inc.. All rights reserved.
//

#import "ZFEntryCell.h"
#import "NSFont+ZFAdditions.h"

@implementation ZFGroupElement (OutlineView)

//- (NSCellStateValue) cellStateForSelection:(ZFGroupElementSelection*) selection {
//	return [selection isGroupElementSelected:self] ? NSOnState : NSOffState;
//}

- (NSImage *) icon
{
	static NSString *icons[] = {
		@"group",
		@"gallery",
		@"collection"
	};
	NSBundle *bundle  = [NSBundle bundleForClass:[self class]];
	NSString *imgpath = [bundle pathForImageResource:icons[self.groupElementType]];
	return FLAutorelease([[NSImage alloc] initWithContentsOfFile:imgpath] );
}

@end

@implementation ZFGroup (OutlineView)

//- (NSCellStateValue) cellStateForSelection:(ZFGroupElementSelection*) selection {
//
//    int count = [self.Elements count];
//    if(count) {
//        int onCount = 0;
//        int offCount = 0;
//        
//        for(ZFGroupElement* entry in self.Elements) {
//            
//            switch([entry cellStateForSelection:selection]) {
//                case NSMixedState:
//                    return NSMixedState;
//                break;
//                
//                case NSOnState:
//                    ++onCount;
//                break;
//                
//                case NSOffState:
//                    ++offCount;
//                break;
//            }
//		}
//		
//        if(onCount == count) {
//            return NSOnState;
//        }
//        else if(offCount == count) {
//            return NSOffState;
//        }
//        
//        return NSMixedState;
//    }
//    else {
//        return [super cellStateForSelection:selection];
//    }
//}

@end

@implementation ZFEntryCell

@synthesize groupElement = _groupElement;

+ (id)cell {
	return FLAutorelease([[[self class] alloc] init]);
}

//+ (id) entryCellWithDelegate:(id<ZFEntryCellDelegate>) delegate {
//    ZFEntryCell* cell = [self cell];
//    cell.delegate = delegate;
//    return cell;
//}

- (id)init {
	self = [super init];
	if ( self ) {
		[self setSelectable:YES];
    }
	return self;
}

-(void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    ZFGroupElement  *entry = [self groupElement];
    
    CGRect iconFrame = cellFrame;
    iconFrame.size.width = iconFrame.size.height;
    iconFrame.origin.x += 10;
    
	NSImage *entryIcon = [entry icon];
	[entryIcon setFlipped:[controlView isFlipped]];
	[entryIcon drawInRect:iconFrame
				 fromRect:NSZeroRect
				operation:NSCompositeSourceOver
				 fraction:1.0];

    cellFrame = FLRectInsetLeft(cellFrame, (FLRectGetRight(iconFrame) - cellFrame.origin.x) + 8);

    [super drawInteriorWithFrame:cellFrame inView:controlView];
}

//static NSPoint downPoint;

//- (BOOL)startTrackingAt:(NSPoint)startPoint inView:(NSOutlineView *)controlView
//{
//	if ( [[self objectValue] isGroupElement])  {
//		return NO;
//	}
////	downPoint = startPoint;
//	int cellRow = [controlView rowAtPoint:startPoint];
//	NSRect cellFrame = [controlView frameOfCellAtColumn:0 row:cellRow];
//	return NSPointInRect(startPoint, [self frameForCheckboxInCellFrame:cellFrame]);
//}
//
//- (BOOL)continueTracking:(NSPoint)lastPoint 
//                      at:(NSPoint)currentPoint 
//                  inView:(NSOutlineView *)controlView {
//	return YES;
//}
//
//- (void)stopTracking:(NSPoint)lastPoint 
//                  at:(NSPoint)stopPoint 
//              inView:(NSOutlineView *)controlView 
//           mouseIsUp:(BOOL)up
//{
//	if ( !up ) {
//		return;
//	}
//
//	int cellRow = [controlView rowAtPoint:stopPoint];
//	NSRect cellFrame = [controlView frameOfCellAtColumn:0 row:cellRow];
//	
//    if ( NSPointInRect(stopPoint, [self frameForCheckboxInCellFrame:cellFrame]) ) {
//		[self.delegate toggleSelectionForItemAtRow:cellRow];
//	}
//}
//
//- (BOOL)trackMouse:(NSEvent *)event 
//            inRect:(NSRect)cellFrame 
//            ofView:(NSView *)controlView 
//      untilMouseUp:(BOOL)up {
//      
//	if ( NSLeftMouseDown == [event type] ) {
//		return [super trackMouse:event inRect:cellFrame ofView:controlView untilMouseUp:up];
//	} else {
//		return NO;
//	}
//}

@end

