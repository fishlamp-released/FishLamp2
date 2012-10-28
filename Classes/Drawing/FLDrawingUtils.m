//
//  FLDrawingUtils.m
//  FishLamp-iOS
//
//  Created by Mike Fullerton on 5/14/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDrawingUtils.h"

void FLDrawLinearGradient(CGContextRef context, 
    FLRect rect, 
    CGColorRef startColor, 
    CGColorRef endColor) {

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGFloat locations[] = { 0.0, 1.0 };
	
	NSArray *colors = [NSArray arrayWithObjects:(__bridge_fl id)startColor, (__bridge_fl id)endColor, nil];
	
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge_fl CFArrayRef) colors, locations);
	
	FLPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
	FLPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
	
	CGContextSaveGState(context);
	CGContextAddRect(context, rect);
	CGContextClip(context);
	CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
	CGContextRestoreGState(context);
	
	CGGradientRelease(gradient);
	CGColorSpaceRelease(colorSpace);
}

void FLDrawLine(CGContextRef context, FLLine_t line) {
	CGContextSaveGState(context);
	CGContextSetLineCap(context, line.cap); // kCGLineCapSquare
	CGContextSetStrokeColorWithColor(context, line.color);
	CGContextSetLineWidth(context, line.width);
	CGContextMoveToPoint(context, line.startPoint.x + 0.5, line.startPoint.y + 0.5);
	CGContextAddLineToPoint(context, line.endPoint.x + 0.5, line.endPoint.y + 0.5);
	CGContextStrokePath(context);
	CGContextRestoreGState(context);		
}