//
//	GtOrientationUtilities.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

// orientation utils
typedef enum {
	GtViewRotationDegreePortrait		   = 0,
	GtViewRotationDegreeLandscapeLeft	   = -90,
	GtViewRotationDegreeLandscapeRight	   = 90,
	GtViewRotationDegreePortraitUpsideDown = 180
} GtViewRotationDegree;

NS_INLINE
UIInterfaceOrientation UIInterfaceOrientationFlip(UIInterfaceOrientation interfaceOrientation)
{
	switch(interfaceOrientation)
	{
		case UIInterfaceOrientationPortraitUpsideDown: return UIInterfaceOrientationPortrait;			
		case UIInterfaceOrientationPortrait: return UIInterfaceOrientationPortraitUpsideDown;		  
		case UIInterfaceOrientationLandscapeLeft: return UIInterfaceOrientationLandscapeRight;
		case UIInterfaceOrientationLandscapeRight: return UIInterfaceOrientationLandscapeLeft; 
		default:
			GtAssertFailed(@"Unsupported orientation");
			break;
	}
	
	return UIInterfaceOrientationPortrait;
}

NS_INLINE
UIImageOrientation UIImageOrientationFlip(UIImageOrientation interfaceOrientation)
{
	switch(interfaceOrientation)
	{
		case UIImageOrientationDown: return UIImageOrientationUp;			
		case UIImageOrientationUp: return UIImageOrientationDown;		  
		case UIImageOrientationLeft: return UIImageOrientationRight;
		case UIImageOrientationRight: return UIImageOrientationLeft; 
		default:
			GtAssertFailed(@"Unsupported orientation");
			break;
	}
	
	
	return UIImageOrientationUp;
}

NS_INLINE
UIDeviceOrientation UIDeviceOrientationFlip(UIDeviceOrientation interfaceOrientation)
{
	switch(interfaceOrientation)
	{
		case UIInterfaceOrientationPortraitUpsideDown: 
			return UIDeviceOrientationPortrait;			  

		case UIDeviceOrientationUnknown:
		case UIDeviceOrientationPortrait:
			return UIDeviceOrientationPortraitUpsideDown;
		
		case UIDeviceOrientationLandscapeLeft: 
			return UIDeviceOrientationLandscapeRight;

		case UIDeviceOrientationLandscapeRight: 
			return UIDeviceOrientationLandscapeLeft; 
		default:
			GtAssertFailed(@"Unsupported orientation");
			break;
	}
	
	return UIDeviceOrientationPortrait;
}

NS_INLINE
UIDeviceOrientation UIConvertInterfaceToDeviceOrientation(UIInterfaceOrientation interfaceOrientation)
{
// set note in UIApplication.h about left/right switching
	switch(interfaceOrientation)
	{	
		case UIInterfaceOrientationPortrait: return UIDeviceOrientationPortrait;
		case UIInterfaceOrientationPortraitUpsideDown: return UIDeviceOrientationPortraitUpsideDown;
		case UIInterfaceOrientationLandscapeLeft: return UIDeviceOrientationLandscapeRight;
		case UIInterfaceOrientationLandscapeRight: return UIDeviceOrientationLandscapeLeft;
		default:
			GtAssertFailed(@"Unsupported orientation");
			break;
	}
	
	
	
	return UIDeviceOrientationPortrait;
}



NS_INLINE
UIInterfaceOrientation UIConvertDeviceToInterfaceOrientation(UIDeviceOrientation deviceOrientation)
{
// set note in UIApplication.h about left/right switching
	switch(deviceOrientation)
	{	
		case UIDeviceOrientationUnknown:
		case UIDeviceOrientationPortrait: 
		case UIDeviceOrientationFaceUp:
		case UIDeviceOrientationFaceDown:
			return UIInterfaceOrientationPortrait;

		case UIDeviceOrientationPortraitUpsideDown: 
			return UIInterfaceOrientationPortraitUpsideDown;
		
		case UIDeviceOrientationLandscapeRight: 
			return UIInterfaceOrientationLandscapeLeft;

		case UIDeviceOrientationLandscapeLeft: 
			return UIInterfaceOrientationLandscapeRight;
			
		default:
			GtAssertFailed(@"Unsupported orientation");
			break;
	}
	
	return UIInterfaceOrientationPortrait;
}

NS_INLINE
UIInterfaceOrientation UIConvertImageToInterfaceOrientation(UIImageOrientation imageOrientation)
{
	switch(imageOrientation)
	{
		case UIImageOrientationLeft: 
			return UIInterfaceOrientationLandscapeLeft; 

		case UIImageOrientationRight: 
			return UIInterfaceOrientationLandscapeRight; 

		case UIImageOrientationDown: 
			return UIInterfaceOrientationPortraitUpsideDown; 
			
		case UIImageOrientationUp:
			return UIInterfaceOrientationPortrait;

		default:
			GtAssertFailed(@"Unsupported orientation");
			break;
	}
	
	return UIInterfaceOrientationLandscapeLeft;

}

NS_INLINE
UIImageOrientation UIConvertInterfaceToImageOrientation(UIInterfaceOrientation imageOrientation)
{
	switch(imageOrientation)
	{
		case UIInterfaceOrientationLandscapeLeft: 
			return UIImageOrientationLeft; 

		case UIInterfaceOrientationLandscapeRight: 
			return UIImageOrientationRight; 

		case UIInterfaceOrientationPortrait: 
			return UIImageOrientationUp; 
			
		case UIInterfaceOrientationPortraitUpsideDown:
			return UIImageOrientationDown;
			
		default:
			GtAssertFailed(@"Unsupported orientation");
			break;
	}
	
	return 0;

}

// convert device <--> image
#define UIConvertDeviceToImageOrientation(__orientation__) UIConvertInterfaceToImageOrientation(UIConvertDeviceToInterfaceOrientation(__orientation__))
#define UIConvertImageToDeviceOrientation(__orientation__) UIConvertInterfaceToDeviceOrientation(UIConvertImageToInterfaceOrientation(__orientation__))

NS_INLINE
CGFloat /*GtViewRotationDegree*/ UIDegreesFromInterfaceOrientation(UIInterfaceOrientation interfaceOrientation)
{
	switch(interfaceOrientation)
	{
		case UIInterfaceOrientationLandscapeLeft: 
			return GtViewRotationDegreeLandscapeLeft; 

		case UIInterfaceOrientationLandscapeRight: 
			return GtViewRotationDegreeLandscapeRight; 

		case UIInterfaceOrientationPortrait: 
			return GtViewRotationDegreePortrait; 
			
		case UIInterfaceOrientationPortraitUpsideDown:
			return GtViewRotationDegreePortraitUpsideDown;

		default:
			GtAssertFailed(@"Unsupported orientation");
			break;
	}
	
	return GtViewRotationDegreePortrait;
}

NS_INLINE
UIInterfaceOrientation UIDegreeToInterfaceOrientation(GtViewRotationDegree degree)
{
	switch(degree)
	{
		case GtViewRotationDegreeLandscapeLeft: 
			return UIInterfaceOrientationLandscapeLeft; 

		case GtViewRotationDegreeLandscapeRight: 
			return UIInterfaceOrientationLandscapeRight; 

		case GtViewRotationDegreePortrait: 
			return UIInterfaceOrientationPortrait; 
			
		case GtViewRotationDegreePortraitUpsideDown:
			return UIInterfaceOrientationPortraitUpsideDown;

		default:
			GtAssertFailed(@"Unsupported orientation");
			break;
	}
	
	return UIInterfaceOrientationPortrait;
}


// I truly suck at math.

NS_INLINE
GtViewRotationDegree GtAddDegrees(GtViewRotationDegree lhs, GtViewRotationDegree rhs)
{
	if(lhs < 0) lhs += 360;
	if(rhs < 0) rhs += 360;
	lhs += rhs;
	return lhs > 180 ? lhs - 360 : lhs;
}

NS_INLINE
GtViewRotationDegree GtSubtractDegrees(GtViewRotationDegree lhs, GtViewRotationDegree rhs)
{
	if(lhs < 0) lhs += 360;
	if(rhs < 0) rhs += 360;
	lhs -= rhs;
	return lhs > 180 ? lhs - 360 : lhs;
}


NS_INLINE
CGFloat UICalculateInterfaceRotationDegrees(UIInterfaceOrientation from, UIInterfaceOrientation to)
{
	CGFloat fromDegrees = UIDegreesFromInterfaceOrientation(from);
	CGFloat toDegrees = UIDegreesFromInterfaceOrientation(to);

	return GtSubtractDegrees(toDegrees, fromDegrees);
}

NS_INLINE
CGRect CGRectForInterfaceOrientation(UIInterfaceOrientation interfaceOrientation, CGRect rect)
{
	return UIInterfaceOrientationIsLandscape(interfaceOrientation) != (rect.size.width > rect.size.height) ? GtRectRotate90Degrees(rect) : rect;
}
