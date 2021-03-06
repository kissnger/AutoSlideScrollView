//
//  ViewController.m
//  AutoPlayImageDemo
//
//  Created by Massimo on 15/10/29.
//  Copyright © 2015年 Massimo. All rights reserved.
//

#import "ViewController.h"
#import "PlayImageView.h"
@interface ViewController ()
{
  PlayImageView *showView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  CGFloat width = [UIScreen mainScreen].bounds.size.width;
  CGFloat height = [UIScreen mainScreen].bounds.size.height;

  NSArray *imageNames = @[@"xia.jpg",@"welcome.jpg",@"background.jpg",@"car.JPG"];

  NSMutableArray *imageViews = [@[] mutableCopy];

  for (NSString *imageName in imageNames) {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];

    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [imageViews addObject:imageView];
  }

  showView = [[PlayImageView alloc] initWithFrame:CGRectMake(0, 20, width, 320)
                                            views:imageViews];
  
  [self.view addSubview:showView];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
