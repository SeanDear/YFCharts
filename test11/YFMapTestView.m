//
//  YFMapTestView.m
//  test11
//
//  Created by leoshi on 2018/3/21.
//  Copyright © 2018年 gongzi. All rights reserved.
//

#import "YFMapTestView.h"

@implementation YFMapTestView{
    
    
    CGPoint         lastPoint;
    CGPoint         currentPoint;
    
}



- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self locationManage];
        [self geoCoder];
        [self addSubview:[self mkView]];
        
    }
    return self;
}
- (MKMapView *)mkView{
    
    if (!_mkView) {
        _mkView = [[MKMapView alloc]initWithFrame:self.bounds];
        _mkView.showsBuildings = YES;
        _mkView.delegate = self;
        _mkView.showsUserLocation = YES;
        _mkView.userTrackingMode = MKUserTrackingModeFollow;
        [_mkView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)]];
    }
    return _mkView;
}
- (CLLocationManager *)locationManage{
    
    if (!_locationManage) {
        NSLog(@"authorizationStatus %d",[CLLocationManager authorizationStatus]);
        _locationManage = [[CLLocationManager alloc]init];
        if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 8.0)
        {
            //设置定位权限 仅ios8有意义
            [_locationManage requestWhenInUseAuthorization];// 前台定位
            
        }
    }
    return _locationManage;
}

- (CLGeocoder *)geoCoder{
    
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc]init];
    }
    return _geoCoder;
}

- (void)tapGesture:(UITapGestureRecognizer *)gesture{
    
    if (gesture.numberOfTouches == 1) {
        CGPoint tapPoint = [gesture locationInView:_mkView];
        NSLog(@"Point %@",NSStringFromCGPoint(tapPoint));
        CLLocationCoordinate2D tapMapCoordinate = [_mkView convertPoint:tapPoint toCoordinateFromView:_mkView];
        CLLocation *location = [[CLLocation alloc]initWithLatitude:tapMapCoordinate.latitude longitude:tapMapCoordinate.longitude];
        __weak typeof(self) weakSf = self;
        [_geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            NSAssert((placemarks.count != 0), @"地理编码错误!");
            __strong typeof(self) strongSf = weakSf;
            if (placemarks.count > 0) {
                CLPlacemark *placeMark = [placemarks firstObject];
                MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc]init];
                pointAnnotation.title = placeMark.name;
                pointAnnotation.subtitle = @"我点击了";
                pointAnnotation.coordinate = tapMapCoordinate;
                [strongSf.mkView addAnnotation:pointAnnotation];
            }
            
        }];
        [_mkView setCenterCoordinate:tapMapCoordinate animated:YES];
        
    }
    
}
#pragma -mark MKMapDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"latitude %f,longitude %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    
    userLocation.title = @"这是上海";
    userLocation.subtitle = @"这是一栋楼";
    
    
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    //显示区域已经改变
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *tapTouch = [touches anyObject];
    CGPoint tapPoint = [tapTouch locationInView:_mkView];
    lastPoint = currentPoint;
    currentPoint = tapPoint;
//    [self addLineWithStartPoint:lastPoint withEndPoint:currentPoint];
}

- (void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
}

- (void)addLineWithStartPoint:(CGPoint)start withEndPoint:(CGPoint)end{
    
    if ((start.x == 0 && start.y == 0) ||(end.x == 0 && end.y == 0)) {
        return;
    }
    
    CAShapeLayer    *lineLayer = [CAShapeLayer layer];
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.frame = self.bounds;
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = [UIColor cyanColor].CGColor;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath     *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:start];
    [linePath addLineToPoint:end];
    lineLayer.path = linePath.CGPath;
    
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"StrokeEnd"];
    animate.fromValue = @(0.0);
    animate.toValue = @(1.0);
    animate.duration = 1.5;
    animate.autoreverses = NO;
    [lineLayer addAnimation:animate forKey:@"lineEnd"];
    [self.layer addSublayer:lineLayer];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
