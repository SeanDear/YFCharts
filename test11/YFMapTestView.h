//
//  YFMapTestView.h
//  test11
//
//  Created by leoshi on 2018/3/21.
//  Copyright © 2018年 gongzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface YFMapTestView : UIView<MKMapViewDelegate>


@property (nonatomic, retain)       MKMapView               *mkView;
@property (nonatomic, retain)       CLLocationManager       *locationManage;
@property (nonatomic, retain)       CLGeocoder              *geoCoder;


@end
