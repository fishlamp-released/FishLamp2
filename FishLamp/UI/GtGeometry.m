//
//  GtGeometry.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtGeometry.h"


CGRect GtFillRectInRect(CGRect container, CGRect containee)
{
	if(	containee.size.width >= container.size.width &&
		containee.size.height >= container.size.height )
	{
		return containee;
	}
	
	CGFloat horizScale = container.size.width / containee.size.width;
	CGFloat vertScale = container.size.height / containee.size.height;
	
	CGFloat scale = MAX(horizScale, vertScale);
	
	containee.size.width *= scale;
	containee.size.height *= scale;
	
	return containee;
}