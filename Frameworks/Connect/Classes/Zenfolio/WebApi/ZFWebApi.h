//
//  ZFWebApi.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 1/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLampCocoa.h"

#import "FLHttp.h"

#import "FLUserLogin.h"
#import "FLUserLogin+ZenfolioAdditions.h"

#import "ZFApi1_6All.h"
#import "ZFAccessDescriptor+More.h"
#import "ZFGroup+More.h"
#import "ZFGroupElement+More.h"
#import "ZFPhoto+More.h"
#import "ZFPhotoSet+More.h"
#import "ZFUploadGallery+More.h"

#import "ZFHttpRequest.h"
#import "ZFAuthenticationService.h"

// these are misspelled in WSDL declaration so are misspelled in generated code
#define kZenfolioInformationLevelLevel1     kZenfolioInformatonLevelLevel1 
#define kZenfolioInformationLevelLevel2     kZenfolioInformatonLevelLevel2
#define kZenfolioInformationLevelFull       kZenfolioInformatonLevelFull
