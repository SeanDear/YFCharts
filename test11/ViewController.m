//
//  ViewController.m
//  test11
//
//  Created by leoshi on 2017/9/20.
//  Copyright © 2017年 gongzi. All rights reserved.
//


#define blank       70

#import "ViewController.h"
#import "UIImageView+Fileter.h"
#import "YFMapTestView.h"
#import "UIFont+AdjustSize.h"
#import "YFChartView.h"



@interface ViewController ()<UITextFieldDelegate>{
    
    UIImageView         *oneImage;
    UITextField         *oneTextfield;
    YFMapTestView       *yfMapView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    YFChartView *charView = [[YFChartView alloc]initWithFrame:CGRectMake(20, 80, width-40, width-40)];
    [self.view addSubview:charView];
    
    
//    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, 150, 30)];
//    oneLabel.font = [UIFont systemFontOfSize:10];
//    oneLabel.text = @"这是一条测试";
//    [self.view addSubview:oneLabel];
    return;
//    系统生成二维码代码
    oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(blank, 100, width-blank*2, width-blank*2)];
    oneImage.center = [UIApplication sharedApplication].delegate.window.center;
    [self.view addSubview:oneImage];

    oneTextfield = [[UITextField alloc]initWithFrame:CGRectMake(blank, CGRectGetMinY(oneImage.frame)-60, width-blank*2, 50)];
    oneTextfield.delegate = self;
    oneTextfield.placeholder = @"请输入生成二维码的字符";
    oneTextfield.layer.cornerRadius = 6;
    oneTextfield.layer.masksToBounds = YES;
    oneTextfield.font = [UIFont systemFontOfSize:17];
    oneTextfield.layer.borderColor = [UIColor lightTextColor].CGColor;
    oneTextfield.layer.borderWidth = 0.5;
    oneTextfield.textAlignment = NSTextAlignmentCenter;
    [oneTextfield addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:oneTextfield];
//    图片用贝塞尔曲线切圆角
//    UIImageView *oneImage = [[UIImageView alloc]initWithFrame:CGRectMake(30, 70, 250, 250)];
//    [oneImage setImage:[UIImage imageNamed:@"IMG_1290.JPG"]];
//    [self.view addSubview:oneImage];
//    UIBezierPath    *maskPath = [UIBezierPath bezierPathWithRoundedRect:oneImage.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
//    CAShapeLayer    *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.path = maskPath.CGPath;
//    maskLayer.frame = oneImage.bounds;
//    oneImage.layer.mask = maskLayer;
//
//    UILabel *oneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(oneImage.frame)-70, CGRectGetWidth(oneImage.frame), 70)];
//    oneLabel.text = @"这是一套测试数据";
//    oneLabel.textColor = [UIColor whiteColor];
//    oneLabel.backgroundColor = [UIColor blueColor];
//    [oneImage addSubview:oneLabel];
//    地图应用
//    yfMapView = [[YFMapTestView alloc]initWithFrame:CGRectMake(0, 64, width, width)];
//    [self.view addSubview:yfMapView];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)textChange:(UITextField *)sTet{
    
    //更新二维码
   [oneImage SetImageForString:sTet.text imageSize:200 withLogo:NO withLogoSize:50];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [oneTextfield resignFirstResponder];
}

@end
