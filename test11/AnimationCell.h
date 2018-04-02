//
//  AnimationCell.h
//  test11
//
//  Created by leoshi on 2018/4/2.
//  Copyright © 2018年 gongzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFAnimationView.h"


typedef void(^AddAnimationBlock)(NSInteger index);


@interface AnimationCell : UITableViewCell



@property (nonatomic, copy)     AddAnimationBlock       animaBlock;
@property (weak, nonatomic) IBOutlet YFAnimationView *animaView;
@property (weak, nonatomic) IBOutlet UILabel *titlelable;

@end
