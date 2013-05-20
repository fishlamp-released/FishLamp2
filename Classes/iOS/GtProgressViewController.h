//
//  GtProgressViewController.h
//  FishLamp2
//
//  Created by Mike Fullerton on 5/17/13.
//
//

#import "GtAutoLayoutViewController.h"

@interface GtProgressViewController : GtAutoLayoutViewController<GtProgressProtocol> {
@private
}
@property (readonly, retain, nonatomic) UIView<GtProgressProtocol>* progressView;

- (id) initWithProgressView:(UIView<GtProgressProtocol>*) view;
+ (id) progressViewController:(UIView<GtProgressProtocol>*) view;

- (void) showProgressInViewController:(UIViewController*) controller;
@end
