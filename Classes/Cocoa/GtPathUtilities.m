//
//	GtPathUtilities.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/16/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPathUtilities.h"

void GtCreateRectPathWithCornerRadii(CGMutablePathRef path, CGRect rect, CGFloat topLeft, CGFloat topRight, CGFloat bottomRight, CGFloat bottomLeft)
{
	//
	// Create the boundary path
	//
	
	// bottomLeft
	
	CGPathMoveToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height - bottomLeft);

	// Top left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		topLeft);

	// Top right corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
		topRight);

	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		bottomRight);

	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y,
		bottomLeft);

	// Close the path at the rounded rect
	CGPathCloseSubpath(path);
}

void GtCreateRectPathWithTopArrow(CGMutablePathRef path, CGRect rect, CGPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius)
{
	

// bottom left
	CGPathMoveToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height - cornerRadius);
		
//	// Top left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + arrowSize,
		rect.origin.x + cornerRadius,
		rect.origin.y + arrowSize,
		cornerRadius);
		
	CGPathAddLineToPoint(path, NULL,
		arrowPoint.x - (arrowSize),
		rect.origin.y + arrowSize);

	CGPathAddLineToPoint(path, NULL,
		arrowPoint.x,
		arrowPoint.y);

	CGPathAddLineToPoint(path, NULL,
		arrowPoint.x + (arrowSize),
		rect.origin.y + arrowSize);
		
	CGPathAddLineToPoint(path, NULL,
		GtRectGetRight(rect) - cornerRadius,
		rect.origin.y + arrowSize);

// top right
	CGPathAddArcToPoint(path, NULL,
		GtRectGetRight(rect),
		rect.origin.y + arrowSize,
		GtRectGetRight(rect),
		rect.origin.y + rect.size.height,
		cornerRadius);

	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		cornerRadius);

	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y,
		cornerRadius);

	// Close the path at the rounded rect
	CGPathCloseSubpath(path);

}

void GtCreateRectPathBackButtonShape(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius, CGFloat ptSize)
{
	// bottomLeft
	
	CGPathMoveToPoint(path, NULL,
		rect.origin.x + 0.5,
		GtRectGetCenter(rect).y + 0.5);

	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + ptSize,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		cornerRadius);

	// Top right corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height + cornerRadius,
		cornerRadius);

	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
		rect.origin.x + 0.5,
		rect.origin.y + rect.size.height,
		cornerRadius);

	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + ptSize,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		GtRectGetCenter(rect).y - 0.5,
		cornerRadius);

	// Close the path at the rounded rect
	CGPathCloseSubpath(path);

}


void GtCreateRectPathWithRightArrow(CGMutablePathRef path, CGRect rect, CGPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius)
{
        // bottom left
	CGPathMoveToPoint(path, NULL,
                      rect.origin.x,
                      rect.origin.y + rect.size.height - cornerRadius);
    
        //	// Top left corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x,
                        rect.origin.y,
                        rect.origin.x + cornerRadius,
                        rect.origin.y,
                        cornerRadius);
    
    	// Top right corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + rect.size.width - arrowSize,
                        rect.origin.y,
                        rect.origin.x + rect.size.width - arrowSize,
                        rect.origin.y + cornerRadius ,
                        cornerRadius);

        // start of right point
	CGPathAddLineToPoint(path, NULL,
                         rect.origin.x + rect.size.width - arrowSize,
                         arrowPoint.y - (arrowSize));
    
	CGPathAddLineToPoint(path, NULL,
                         arrowPoint.x,
                         arrowPoint.y);
        
        // end of right point
	CGPathAddLineToPoint(path, NULL,
                         rect.origin.x + rect.size.width - arrowSize,
                         arrowPoint.y + arrowSize);
    
//	CGPathAddLineToPoint(path, NULL,
//                         rect.origin.x + rect.size.width,
//                         rect.origin.y + rect.size.height);
    
        // Bottom right corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + rect.size.width - arrowSize,
                        rect.origin.y + rect.size.height,
                        rect.origin.x,
                        rect.origin.y + rect.size.height,
                        cornerRadius);
    
        // Bottom left corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x,
                        rect.origin.y + rect.size.height,
                        rect.origin.x,
                        rect.origin.y,
                        cornerRadius);
    
        // Close the path at the rounded rect
	CGPathCloseSubpath(path);

}

void GtCreateRectPathWithBottomArrow(CGMutablePathRef path, CGRect rect, CGPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius)
{
	
 
// bottom left
	CGPathMoveToPoint(path, NULL,
		rect.origin.x,
		GtRectGetBottom(rect) - cornerRadius - arrowSize);
		
//	// Top left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y,
		rect.origin.x + cornerRadius,
		rect.origin.y,
		cornerRadius);
		
// top right
	CGPathAddArcToPoint(path, NULL,
		GtRectGetRight(rect),
		rect.origin.y,
		GtRectGetRight(rect),
		GtRectGetBottom(rect) - arrowSize,
		cornerRadius);

	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
		GtRectGetRight(rect),
		GtRectGetBottom(rect) - arrowSize,
		GtRectGetRight(rect) - cornerRadius,
		GtRectGetBottom(rect) - arrowSize,
		cornerRadius);

	// right base of arrow
	CGPathAddLineToPoint(path, NULL,
		arrowPoint.x + (arrowSize),
		GtRectGetBottom(rect) - arrowSize);

	// tip of arrow
	CGPathAddLineToPoint(path, NULL,
		arrowPoint.x,
		arrowPoint.y);

	// left base of arrow
	CGPathAddLineToPoint(path, NULL,
		arrowPoint.x - (arrowSize),
		GtRectGetBottom(rect) - arrowSize);
	 
	CGPathAddLineToPoint(path, NULL,
		rect.origin.x + cornerRadius,
		GtRectGetBottom(rect) - arrowSize);


	// Bottom left corner
//	CGPathAddArcToPoint(path, NULL,
//		rect.origin.x,
//		GtRectGetBottom(rect) - arrowSize - cornerRadius,
//		rect.origin.x + cornerRadius,
//		GtRectGetBottom(rect) - arrowSize,
//		cornerRadius);

	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		GtRectGetBottom(rect) - arrowSize,
		rect.origin.x,
		GtRectGetBottom(rect) - arrowSize - cornerRadius,
		cornerRadius);
		
	// Close the path at the rounded rect
	CGPathCloseSubpath(path);

}

void GtCreateRectPathWithLeftArrow(CGMutablePathRef path, CGRect rect, CGPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius)
{
        // bottom left
	CGPathMoveToPoint(path, NULL,
                      rect.origin.x + arrowSize,
                      rect.origin.y + rect.size.height - cornerRadius);

        // start of  point
	CGPathAddLineToPoint(path, NULL,
                         rect.origin.x + arrowSize,
                         arrowPoint.y - (arrowSize));
    
	CGPathAddLineToPoint(path, NULL,
                         arrowPoint.x,
                         arrowPoint.y);
    
        // end of  point
	CGPathAddLineToPoint(path, NULL,
                         rect.origin.x + arrowSize,
                         arrowPoint.y + arrowSize);

        //	Top left corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + arrowSize,
                        rect.origin.y,
                        rect.origin.x + arrowSize + cornerRadius,
                        rect.origin.y,
                        cornerRadius);
    
    	// Top right corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + rect.size.width,
                        rect.origin.y,
                        rect.origin.x + rect.size.width,
                        rect.origin.y + cornerRadius ,
                        cornerRadius);
    
        // Bottom right corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + rect.size.width,
                        rect.origin.y + rect.size.height,
                        rect.origin.x,
                        rect.origin.y + rect.size.height,
                        cornerRadius);
    
        // Bottom left corner
	CGPathAddArcToPoint(path, NULL,
                        rect.origin.x + arrowSize,
                        rect.origin.y + rect.size.height,
                        rect.origin.x + arrowSize,
                        rect.origin.y,
                        cornerRadius);
    
        // Close the path at the rounded rect
	CGPathCloseSubpath(path);
}

void GtCreatePartialRectPathTop(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius)
{
	//
	// Create the boundary path
	//
	
	
	// bottom left
	CGPathMoveToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height);

	// Top left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		cornerRadius);

	// Top right corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
		cornerRadius);
		
	CGPathAddLineToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height);		  

	// Close the path at the rounded rect
	//CGPathCloseSubpath(path);
	
}

void GtCreatePartialRectPathLeft(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius)
{
	
	CGPathMoveToPoint(path, NULL,
		GtRectGetLeft(rect),
		GtRectGetTop(rect) + cornerRadius);
	CGPathAddLineToPoint(path, NULL,
		GtRectGetLeft(rect),
		GtRectGetBottom(rect) - cornerRadius);	
}

void GtCreatePartialRectPathRight(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius)
{
	
	CGPathMoveToPoint(path, NULL,
		GtRectGetRight(rect),
		GtRectGetTop(rect) + cornerRadius);
	CGPathAddLineToPoint(path, NULL,
		GtRectGetRight(rect),
		GtRectGetBottom(rect) - cornerRadius);	
}

void GtCreatePartialRectPathBottom(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius)
{
	//
	// Create the boundary path
	//
	
	
	// bottom left
	CGPathMoveToPoint(path, NULL,
		GtRectGetRight(rect),
		GtRectGetTop(rect));

	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		cornerRadius);

	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y,
		cornerRadius);
		
	CGPathAddLineToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y);		   

	// Close the path at the rounded rect
}

