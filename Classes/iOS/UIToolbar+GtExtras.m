//
//	GtToolbar.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/24/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UIToolbar+GtExtras.h"


@implementation UIToolbar (GtExtras)

//- (BOOL) replaceBarButtonItemWithCustomView:(UIBarButtonItem*) oldItem
//	  customView:(UIView*) newView
//	  animated:(BOOL) animated
//	  outNewItem:(UIBarButtonItem**) outNewItem
//{
//		GtAssertNotNil(oldItem);
//	  GtAssertNotNil(newView);
//
//	  BOOL foundIt = NO;
//	  
//	  NSMutableArray* items = [[NSMutableArray alloc] initWithArray:self.items];
//	  for(int i = 0; i < items.count; i++)
//	  {
//		  if([[items objectAtIndex:i] isEqual:oldItem])
//		  {
//			  foundIt = YES;
//			  UIBarButtonItem* customItem = [[UIBarButtonItem alloc] initWithCustomView:newView];
//			  customItem.tag = oldItem.tag;
//			  [items replaceObjectAtIndex:i withObject:customItem];
//			  if(outNewItem)
//			  {
//				  *outNewItem = GtRetain(customItem);
//			  }
//	 
//			  GtReleaseWithNil(customItem);
//			  
//			  break;
//		  }
//	  }
//
//	[self setItems:items animated:animated];
//
//	  GtReleaseWithNil(items);
//	 
//	  return foundIt;
//}

- (void) setAllItemsEnabled:(BOOL) enabled
{
	NSArray* items = self.items;
	for(UIBarButtonItem* item in items)
	{
		item.enabled = enabled;
	}
	self.items = items;
}

- (UIBarButtonItem*) toolbarItemForTag:(NSInteger) tag
{
	for(UIBarButtonItem* item in self.items)
	{
		if(item.tag == tag)
		{
			return item;
		}
	}	
	
	return nil;
}

- (BOOL) setToolbarItem:(UIBarButtonItem*) item forTag:(NSInteger) tag animated:(BOOL) animated
{
	BOOL foundIt = NO;
	NSMutableArray* items = [[NSMutableArray alloc] initWithArray:self.items];
	for(NSUInteger i = 0; i < items.count; i++)
	{
		if([[items objectAtIndex:i] tag] == tag)
		{
			item.tag = tag;
			foundIt = YES;
			[items replaceObjectAtIndex:i withObject:item];
			
			self.items = items;
			break;
		}
	}
	
	GtReleaseWithNil(items);
	
	return foundIt;
}

@end

@implementation UIBarButtonItem (GtExtras)

+ (UIBarButtonItem*) flexibleSpaceBarButtonItem
{
	return GtReturnAutoreleased([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]);
}

+ (UIBarButtonItem*) imageButtonBarButtonItem:(UIImage*) image target:(id) target action:(SEL) action
{
	return GtReturnAutoreleased([[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target	action:action] );
}

+ (UIBarButtonItem*) fixedSpaceBarButtonItem:(CGFloat) width
{
	UIBarButtonItem* item = GtReturnAutoreleased([[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil]);
	item.width = width;
	return item;
}

@end