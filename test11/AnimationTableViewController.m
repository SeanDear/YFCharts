//
//  AnimationTableViewController.m
//  test11
//
//  Created by leoshi on 2018/4/2.
//  Copyright © 2018年 gongzi. All rights reserved.
//

#import "AnimationTableViewController.h"
#import <objc/runtime.h>
#import "AnimationCell.h"


@interface AnimationTableViewController (){
    
    NSArray     *sectionTitleArr;
    NSArray     *basicArr;
    
}

@end

@implementation AnimationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    unsigned int count = 0;
    
    objc_property_t *propertys = class_copyPropertyList([CALayer class], &count);
    
    sectionTitleArr = @[@"CABasicAnimation",@"CAKeyframeAnimation",@"CATransition",@"CAAnimationGroup"];
    basicArr = @[@"position",@"bounds",@"transform",@"backgroundColor",@"opacity",@"cornerRadius"];
    self.tableView.rowHeight = 150.0f;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [sectionTitleArr objectAtIndex: section];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sectionTitleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return basicArr.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"basicCell";
    AnimationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AnimationCell" owner:self options:nil]lastObject];
    }
    if (indexPath.section == 0) {
        cell.titlelable.text = [basicArr objectAtIndex:indexPath.row];
        cell.animaBlock(indexPath.row);
    }
    else{
        
    }
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
