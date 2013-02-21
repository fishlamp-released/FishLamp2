//
//  FLZenfolioWebApi.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 1/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLampCocoa.h"

#import "FLHttp.h"

#import "FLUserLogin.h"
#import "FLUserLogin+ZenfolioAdditions.h"

#import "FLZenfolioApi1_6All.h"
#import "FLZenfolioAccessDescriptor+More.h"
#import "FLZenfolioGroup+More.h"
#import "FLZenfolioGroupElement+More.h"
#import "FLZenfolioPhoto+More.h"
#import "FLZenfolioPhotoSet+More.h"
#import "FLZenfolioUploadGallery+More.h"

#import "FLZenfolioHttpRequest.h"
#import "FLZenfolioAuthenticationService.h"

// these are misspelled in WSDL declaration so are misspelled in generated code
#define kZenfolioInformationLevelLevel1     kZenfolioInformatonLevelLevel1 
#define kZenfolioInformationLevelLevel2     kZenfolioInformatonLevelLevel2
#define kZenfolioInformationLevelFull       kZenfolioInformatonLevelFull
