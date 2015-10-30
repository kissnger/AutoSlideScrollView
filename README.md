# AutoSlideScrollView

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
        //只此一句代码搞定图片无线轮播功能  把创建好的UIImageView 放进数组里就OK了
      showView = [[PlayImageView alloc] initWithFrame:CGRectMake(0, 20, width, 320)
                                                views:imageViews];
      
     [self.view addSubview:showView];
    }
