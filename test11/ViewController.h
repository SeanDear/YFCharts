//
//  ViewController.h
//  test11
//
//  Created by leoshi on 2017/9/20.
//  Copyright © 2017年 gongzi. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    DemoOne,
    DemoTwo,
    DemoThree,
    DemoFour,
    DemoFive,
} DemoType;

@interface ViewController : UIViewController



@property (nonatomic, assign)       DemoType    myType;

@end

