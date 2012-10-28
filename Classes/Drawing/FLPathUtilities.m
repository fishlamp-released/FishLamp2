//
//	FLPathUtilities.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/16/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLPathUtilities.h"

void FLCreateRectPathWithCornerRadii(CGMutablePathRef path, FLRect rect, CGFloat topLeft, CGFloat topRight, CGFloat bottomRight, CGFloat bottomLeft)
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

void FLCreateRectPathWithTopArrow(CGMutablePathRef path, FLRect rect, FLPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius)
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
		FLRectGetRight(rect) - cornerRadius,
		rect.origin.y + arrowSize);

// top right
	CGPathAddArcToPoint(path, NULL,
		FLRectGetRight(rect),
		rect.origin.y + arrowSize,
		FLRectGetRight(rect),
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

void FLCreateRectPathBackButtonShape(CGMutablePathRef path, FLRect rect, CGFloat cornerRadius, CGFloat ptSize)
{
	// bottomLeft
	
	CGPathMoveToPoint(path, NULL,
		rect.origin.x + 0.5,
		FLRectGetCenter(rect).y + 0.5);

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
		FLRectGetCenter(rect).y - 0.5,
		cornerRadius);

	// Close the path at the rounded rect
	CGPathCloseSubpath(path);

}


void FLCreateRectPathWithRightArrow(CGMutablePathRef path, FLRect rect, FLPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius)
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

void FLCreateRectPathWithBottomArrow(CGMutablePathRef path, FLRect rect, FLPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius)
{
	
 
// bottom left
	CGPathMoveToPoint(path, NULL,
		rect.origin.x,
		FLRectGetBottom(rect) - cornerRadius - arrowSize);
		
//	// Top left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y,
		rect.origin.x + cornerRadius,
		rect.origin.y,
		cornerRadius);
		
// top right
	CGPathAddArcToPoint(path, NULL,
		FLRectGetRight(rect),
		rect.origin.y,
		FLRectGetRight(rect),
		FLRectGetBottom(rect) - arrowSize,
		cornerRadius);

	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
		FLRectGetRight(rect),
		FLRectGetBottom(rect) - arrowSize,
		FLRectGetRight(rect) - cornerRadius,
		FLRectGetBottom(rect) - arrowSize,
		cornerRadius);

	// right base of arrow
	CGPathAddLineToPoint(path, NULL,
		arrowPoint.x + (arrowSize),
		FLRectGetBottom(rect) - arrowSize);

	// tip of arrow
	CGPathAddLineToPoint(path, NULL,
		arrowPoint.x,
		arrowPoint.y);

	// left base of arrow
	CGPathAddLineToPoint(path, NULL,
		arrowPoint.x - (arrowSize),
		FLRectGetBottom(rect) - arrowSize);
	 
	CGPathAddLineToPoint(path, NULL,
		rect.origin.x + cornerRadius,
		FLRectGetBottom(rect) - arrowSize);


	// Bottom left corner
//	CGPathAddArcToPoint(path, NULL,
//		rect.origin.x,
//		FLRectGetBottom(rect) - arrowSize - cornerRadius,
//		rect.origin.x + cornerRadius,
//		FLRectGetBottom(rect) - arrowSize,
//		cornerRadius);

	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		FLRectGetBottom(rect) - arrowSize,
		rect.origin.x,
		FLRectGetBottom(rect) - arrowSize - cornerRadius,
		cornerRadius);
		
	// Close the path at the rounded rect
	CGPathCloseSubpath(path);

}

void FLCreateRectPathWithLeftArrow(CGMutablePathRef path, FLRect rect, FLPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius)
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

void FLCreatePartialRectPathTop(CGMutablePathRef path, FLRect rect, CGFloat cornerRadius)
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

void FLCreatePartialRectPathLeft(CGMutablePathRef path, FLRect rect, CGFloat cornerRadius)
{
	
	CGPathMoveToPoint(path, NULL,
		FLRectGetLeft(rect),
		FLRectGetTop(rect) + cornerRadius);
	CGPathAddLineToPoint(path, NULL,
		FLRectGetLeft(rect),
		FLRectGetBottom(rect) - cornerRadius);	
}

void FLCreatePartialRectPathRight(CGMutablePathRef path, FLRect rect, CGFloat cornerRadius)
{
	
	CGPathMoveToPoint(path, NULL,
		FLRectGetRight(rect),
		FLRectGetTop(rect) + cornerRadius);
	CGPathAddLineToPoint(path, NULL,
		FLRectGetRight(rect),
		FLRectGetBottom(rect) - cornerRadius);	
}

void FLCreatePartialRectPathBottom(CGMutablePathRef path, FLRect rect, CGFloat cornerRadius)
{
	//
	// Create the boundary path
	//
	
	
	// bottom left
	CGPathMoveToPoint(path, NULL,
		FLRectGetRight(rect),
		FLRectGetTop(rect));

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

void FLSetPathToTriangleInRectCorner(CGMutablePathRef path, 
    FLRect rect, 
    FLTriangleCorner cornerInRect) {
    
    switch(cornerInRect) {
        case FLTriangleCornerUpperLeft:
          	CGPathMoveToPoint(path, NULL, rect.origin.x, rect.origin.y);
            CGPathAddLineToPoint(path, NULL, FLRectGetRight(rect), rect.origin.y);
            CGPathAddLineToPoint(path, NULL, rect.origin.x, FLRectGetBottom(rect));
            CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y);
        break;
        case FLTriangleCornerUpperRight:
          	CGPathMoveToPoint(path, NULL, FLRectGetRight(rect), rect.origin.y);
            CGPathAddLineToPoint(path, NULL, FLRectGetRight(rect), FLRectGetBottom(rect));
            CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y);
            CGPathAddLineToPoint(path, NULL, FLRectGetRight(rect), rect.origin.y);
        break;
        case FLTriangleCornerBottomRight:
          	CGPathMoveToPoint(path, NULL, FLRectGetRight(rect), FLRectGetBottom(rect));
            CGPathAddLineToPoint(path, NULL, rect.origin.x, FLRectGetBottom(rect));
            CGPathAddLineToPoint(path, NULL, FLRectGetRight(rect), rect.origin.y);
            CGPathAddLineToPoint(path, NULL, FLRectGetRight(rect), FLRectGetBottom(rect));
        break;
        case FLTriangleCornerBottomLeft:
          	CGPathMoveToPoint(path, NULL, rect.origin.x, FLRectGetBottom(rect));
            CGPathAddLineToPoint(path, NULL, rect.origin.x, rect.origin.y);
            CGPathAddLineToPoint(path, NULL, FLRectGetRight(rect), rect.origin.y);
            CGPathAddLineToPoint(path, NULL, rect.origin.x, FLRectGetBottom(rect));
        break;

    
    }

  	CGPathCloseSubpath(path);
}

