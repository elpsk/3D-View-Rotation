//
//  APViewController.h
//  3dRotate
//
//  Created by alberto pasca on 02/07/13.
//  Copyright (c) 2013 Alberto Pasca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APViewController : UIViewController
{
  IBOutlet UIView *_Container;
  IBOutlet UIView *_Parent;
  IBOutlet UIView *_Child1;
  IBOutlet UIView *_Child2;

  IBOutlet UILabel *_LblPersp;
  IBOutlet UILabel *_LblDur;

  UIImageView *_imgvcChild1;
  UIImageView *_imgvcChild2;

  BOOL  _front;
  float _duration;
  float _perspective;
}

- (IBAction)ruota:(id)sender;
- (IBAction)perspective:(id)sender;
- (IBAction)duration:(id)sender;

@end
