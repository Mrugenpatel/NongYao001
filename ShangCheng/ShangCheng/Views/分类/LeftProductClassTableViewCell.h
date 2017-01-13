//
//  LeftProductClassTableViewCell.h
//  ShangCheng
//
//  Created by TongLi on 2017/1/8.
//  Copyright © 2017年 TongLi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftProductClassTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftCellLabel;

- (void)updateLeftCellWithTitle:(NSString *)titleStr;
@end
