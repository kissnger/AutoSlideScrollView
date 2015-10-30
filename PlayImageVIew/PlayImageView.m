//
//  PlayImageView.m
//  AutoPlayImageDemo
//
//  Created by Massimo on 15/10/29.
//  Copyright © 2015年 Massimo. All rights reserved.
//

#import "PlayImageView.h"

#define kRect self.bounds

@interface PlayImageView()<UIScrollViewDelegate>
@property (strong, nonatomic)UIScrollView *scrollView;
@property (assign, nonatomic)CGFloat scrollViewStartContentOffsetX;
@property (strong, nonatomic)NSMutableArray *views;
@property (strong, nonatomic)NSMutableArray *images;
@property (assign, nonatomic)NSInteger currentViewIndex;
@end
@implementation PlayImageView

- (instancetype)initWithFrame:(CGRect)frame views:(NSArray *)views{

  self = [self initWithFrame:frame];
  if (self) {
    self.images = [NSMutableArray new];
    self.views = [NSMutableArray new];
    self.scrollView.scrollEnabled = views.count == 1 ? NO : YES;

    for (UIImageView *imageView in views) {

      [self.images addObject:imageView.image];
    }
    UIImageView *tempImageView = views.lastObject;
    for (int i = 0 ; i < 3; i++) {
      UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
      
      imageView.contentMode = tempImageView.contentMode;
      imageView.clipsToBounds = tempImageView.clipsToBounds;
      [self.views addObject:imageView];
    }
  }
  return self;
}
- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
    self.autoresizesSubviews = YES;
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.autoresizingMask = 0xFF;
    self.scrollView.contentMode = UIViewContentModeCenter;
    self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    self.currentViewIndex = 0;
  }
  return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
  [self configViews];

  
}

- (void)configViews{
  NSArray *contantViews = [[self scrollViewDataSource] copy];
  NSInteger counter = 0;
  for (UIView *view in contantViews) {
    CGRect rightRect = view.frame;
    rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
    view.frame = rightRect;

    [self.scrollView addSubview:view];
  }
  
  if (contantViews.count > 1) {
    [self.scrollView setContentOffset:CGPointMake(kRect.size.width, 0)];
  }
}

- (NSArray*)scrollViewDataSource{
  NSInteger beforViewIndex = [self configNextImageIndex:self.currentViewIndex - 1];
  NSInteger nextViewIndex = [self configNextImageIndex:self.currentViewIndex + 1];
  NSArray * set = @[@(beforViewIndex),@(self.currentViewIndex),@(nextViewIndex)];

  NSMutableArray *contantViews = [NSMutableArray new];
  NSInteger i = 0;
  for (NSNumber *number in set) {
    NSInteger index = number.integerValue;
    if ([self isValidIndex:index]) {
      UIImageView *imageView = _views[i];

      imageView.image = _images[index];

       [contantViews addObject:imageView];
      
      i++;
    }
  }
  return contantViews;
}

//确定前后也该获取的照片中的索引值
- (NSInteger)configNextImageIndex:(NSInteger)currentIndex{
  NSInteger result;

  if (currentIndex == -1) {
    result = self.images.count - 1;
  }else if (currentIndex == self.images.count){
    result = 0;
  }else{
    result = currentIndex;
  }

  return result;
}



//判断是否是有效的索引值
- (BOOL)isValidIndex:(NSInteger)index{

  if (index >=0 && index <= self.images.count - 1) {
    return YES;
  }
  return NO;
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

  CGFloat contentOffsetX = scrollView.contentOffset.x;

  if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
    self.currentViewIndex = [self configNextImageIndex:self.currentViewIndex + 1];
//            NSLog(@"next，当前页:%ld",self.currentViewIndex);
    [self configViews];
  }
  if(contentOffsetX <= 0) {
    self.currentViewIndex = [self configNextImageIndex:self.currentViewIndex - 1];
//            NSLog(@"previous，当前页:%ld",self.currentViewIndex);
    [self configViews];
  }


}



@end
