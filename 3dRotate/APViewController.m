//
//  APViewController.m
//  3dRotate
//
//  Created by alberto pasca on 02/07/13.
//  Copyright (c) 2013 Alberto Pasca. All rights reserved.
//

#import "APViewController.h"
#import <QuartzCore/QuartzCore.h>


CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};


@implementation APViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _front       = YES;

  _duration    = 1.5;
  _perspective = -200;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}


// -------------------------------
// -------------------------------


- ( void ) setupAnimation
{
  CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
  rotationAndPerspectiveTransform.m34 = 1.0 / _perspective;
  _Container.layer.sublayerTransform = rotationAndPerspectiveTransform;

  //
  // child 1 - grab and draw view
  //
  UIGraphicsBeginImageContext(_Child1.frame.size);
  [_Child1.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *grab = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  if ( _imgvcChild1 ) [_imgvcChild1 removeFromSuperview];
  _imgvcChild1 = [[ UIImageView alloc ] initWithImage:grab];
  [ _Parent addSubview:_imgvcChild1 ];

  //
  // child 2 - grab and draw view
  //
  UIGraphicsBeginImageContext(_Child2.frame.size);
  [_Child2.layer renderInContext:UIGraphicsGetCurrentContext()];
  grab = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  if ( _imgvcChild2 ) [_imgvcChild2 removeFromSuperview];
  _imgvcChild2 = [[ UIImageView alloc ] initWithImage:grab];
  [ _Parent addSubview:_imgvcChild2 ];

  CGRect r = _Parent.bounds;
  _imgvcChild1.frame = r;
  r.origin.y = r.size.height;
  _imgvcChild2.frame = r;

  _Parent.layer.anchorPointZ = -(r.size.height/2);
  _Parent.layer.zPosition    = -(r.size.height/2);

  //
  // transform child-2 grabbed
  //
  CATransform3D trans = CATransform3DIdentity;
  trans = CATransform3DRotate    ( trans, DegreesToRadians(-90), 1, 0, 0 );
  trans = CATransform3DTranslate ( trans, 0, r.size.height/2, 0 );
  trans = CATransform3DTranslate ( trans, 0, 0, -r.size.height/2 );
  [ _imgvcChild2.layer setTransform: trans ];
}


- ( IBAction ) ruota: ( id ) sender
{
  [self setupAnimation];

  [_Child1 removeFromSuperview];
  [_Child2 removeFromSuperview];

  [ UIView animateWithDuration: _duration animations: ^
  {
    CATransform3D trans = CATransform3DIdentity;
    trans = CATransform3DRotate ( trans, DegreesToRadians(_front ? 90 : 0), 1, 0, 0 );
    [_Parent.layer setTransform:trans];
  } completion:^(BOOL finished)
  {
		//
		// add/remove something.
		//
    if ( _front )
    {
      [_imgvcChild1 removeFromSuperview];
      [_Container addSubview:_Child2];
    }
    else
    {
      [_imgvcChild2 removeFromSuperview];
      [_Container addSubview:_Child1];
    }

    _front = !_front;
  }];
}



// -------------------------------
// -------------------------------


- (IBAction)perspective:(UISlider*)sender
{
  _perspective = sender.value;
  _LblPersp.text = [NSString stringWithFormat:@"%.0f", _perspective];
}

- (IBAction)duration:(UISlider*)sender
{
  _duration = sender.value;
  _LblDur.text = [NSString stringWithFormat:@"%.2f", _duration];
}


@end

