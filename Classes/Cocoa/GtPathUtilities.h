//
//	GtPathUtilities.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/16/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

extern void GtCreateRectPathWithCornerRadii(CGMutablePathRef path, CGRect rect, CGFloat topLeft, CGFloat topRight, CGFloat bottomRight, CGFloat bottomLeft);

NS_INLINE void GtCreateRectPath(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius)
{
	return GtCreateRectPathWithCornerRadii(path, rect, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
}


#define GtCreateRectPath(path, rect, cornerRadius) GtCreateRectPathWithCornerRadii(path, rect, cornerRadius, cornerRadius, cornerRadius, cornerRadius )

extern void GtCreateRectPathWithTopArrow(CGMutablePathRef path, CGRect rect, CGPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius);
extern void GtCreateRectPathWithRightArrow(CGMutablePathRef path, CGRect rect, CGPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius);
extern void GtCreateRectPathWithBottomArrow(CGMutablePathRef path, CGRect rect, CGPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius);
extern void GtCreateRectPathWithLeftArrow(CGMutablePathRef path, CGRect rect, CGPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius);

extern void GtCreatePartialRectPathTop(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius);
extern void GtCreatePartialRectPathLeft(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius);
extern void GtCreatePartialRectPathRight(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius);
extern void GtCreatePartialRectPathBottom(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius);

extern void GtCreateRectPathBackButtonShape(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius, CGFloat pointSize);

